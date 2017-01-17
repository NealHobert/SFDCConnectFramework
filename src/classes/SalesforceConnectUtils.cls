/**
 * Copyright (c), Trifecta Technologies, Inc
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification,
 *   are permitted provided that the following conditions are met:
 *
 * - Redistributions of source code must retain the above copyright notice,
 *      this list of conditions and the following disclaimer.
 * - Redistributions in binary form must reproduce the above copyright notice,
 *      this list of conditions and the following disclaimer in the documentation
 *      and/or other materials provided with the distribution.
 * - Neither the name of the Trifecta Technologies, Inc nor the names of its contributors
 *      may be used to endorse or promote products derived from this software without
 *      specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 *  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
 *  OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL
 *  THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 *  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 *  OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
 *  OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 *  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
**/

public class SalesforceConnectUtils {

	private static String STRING_CONVERSION = 'String';
	private static String CURRENCY_CONVERSION = 'Currency';

	public static Object getEnumerationValue(Object fieldValue, Salesforce_Connect_Field_Mapping__mdt metaData){
		String enumValue;
		String queryString = 'SELECT MasterLabel, Display_Value__c, Enumeration_Value__c FROM ' + metaData.Enumeration_Metadata_Type__c + ' WHERE ' + metaData.Display_Field_Name__c + ' = :fieldValue';
		
		List<SObject> enumerations = Database.query(queryString);
        
        if (!enumerations.isEmpty()){
            enumValue = (String) enumerations[0].get(metaData.Enumeration_Field_Name__c); 
        } else {
        	SalesforceConnectDataSourceUtils dsUtils= new SalesforceConnectDataSourceUtils();
           dsUtils.throwException ('Enumeration value could not be located in ' + metaData.Enumeration_Metadata_Type__c + ' for Value ' + fieldValue ); 
        }
        return enumValue;
	}

	public static Object getDisplayValue(Object fieldValue, Salesforce_Connect_Field_Mapping__mdt metaData){
		String enumValue;
		String queryString = 'SELECT MasterLabel, Display_Value__c, Enumeration_Value__c FROM ' + metaData.Enumeration_Metadata_Type__c + ' WHERE ' + metaData.Enumeration_Field_Name__c + ' = :fieldValue';
		
		List<SObject> enumerations = Database.query(queryString);
        
        if (!enumerations.isEmpty()){
            enumValue = (String) enumerations[0].get(metaData.Display_Field_Name__c); 
        } else {
       		SalesforceConnectDataSourceUtils dsUtils= new SalesforceConnectDataSourceUtils();
           	dsUtils.throwException ('Enumeration value could not be located in ' + metaData.Enumeration_Metadata_Type__c + ' for Value ' + fieldValue ); 
        }
        return enumValue;
	}

	public static SalesforceConnectMapper getMapperClass(DataSource.QueryContext context){
		DataSource.TableSelection tableSelection  = context.tableSelection;
		String tableName = tableSelection.tableSelected;
		Salesforce_Connect_Service_Setting__mdt setting = [SELECT MasterLabel, Mapper_Class__c FROM Salesforce_Connect_Service_Setting__mdt WHERE MasterLabel = :tableName LIMIT 1];
        SalesforceConnectMapper mapper = (SalesforceConnectMapper) Type.forName(setting.Mapper_Class__c).newInstance();
		
		return mapper;

	}

	public static SalesforceConnectMapper getMapperClass(DataSource.UpsertContext context){
		String tableName = context.tableSelected;
		Salesforce_Connect_Service_Setting__mdt setting = [SELECT MasterLabel, Mapper_Class__c FROM Salesforce_Connect_Service_Setting__mdt WHERE MasterLabel = :tableName LIMIT 1];
        SalesforceConnectMapper mapper = (SalesforceConnectMapper) Type.forName(setting.Mapper_Class__c).newInstance();
		
		return mapper;

	}

	public static SalesforceConnectMapper getMapperClass(DataSource.DeleteContext context){
		String tableName = context.tableSelected;
		Salesforce_Connect_Service_Setting__mdt setting = [SELECT MasterLabel, Mapper_Class__c FROM Salesforce_Connect_Service_Setting__mdt WHERE MasterLabel = :tableName LIMIT 1];
        SalesforceConnectMapper mapper = (SalesforceConnectMapper) Type.forName(setting.Mapper_Class__c).newInstance();
		
		return mapper;

	}

	public static Map<String, Salesforce_Connect_Field_Mapping__mdt> getFieldMappings(String sObjectAPIName){
		List<Salesforce_Connect_Field_Mapping__mdt> rows = new List<Salesforce_Connect_Field_Mapping__mdt>([
					SELECT MasterLabel,
						Enumeration_Metadata_Type__c,
						Enumeration_Field_Name__c,
						Display_Field_Name__c,
						Conversion_Type__c,
						Implied_Decimal_Places__c
					FROM Salesforce_Connect_Field_Mapping__mdt 
					WHERE isActive__c = true AND 
					Salesforce_Connect_Object_Mapping__r.MasterLabel = :sObjectAPIName]);

		Map<String, Salesforce_Connect_Field_Mapping__mdt> fieldMapping = new Map<String, Salesforce_Connect_Field_Mapping__mdt>();
		for (Salesforce_Connect_Field_Mapping__mdt row : rows){
			fieldMapping.put(row.MasterLabel, row);
		}
		return fieldMapping;
	}

	public static void mapEnumerations(Map<String, Object> dataRow, Map<String, Salesforce_Connect_Field_Mapping__mdt> fieldMapping){
		for (String fieldName : fieldMapping.keySet()){
			if (dataRow.get(fieldName) != null){
				Salesforce_Connect_Field_Mapping__mdt metaInfo = fieldMapping.get(fieldName);
				if (metaInfo.Conversion_Type__c == STRING_CONVERSION){
					dataRow.put(fieldName, getEnumerationValue(dataRow.get(fieldName), fieldMapping.get(fieldName)));
				} else if (metaInfo.Conversion_Type__c == CURRENCY_CONVERSION){
					dataRow.put(fieldName, getEnumeratedCurrencyValue(dataRow.get(fieldName),metaInfo));
				}
				
			}
		}
	}

	public static void mapDisplayValues(Map<String, Object> dataRow, Map<String, Salesforce_Connect_Field_Mapping__mdt> fieldMapping){
		for (String fieldName : fieldMapping.keySet()){
			if (dataRow.get(fieldName) != null){
				Salesforce_Connect_Field_Mapping__mdt metaInfo = fieldMapping.get(fieldName);
				if (metaInfo.Conversion_Type__c == STRING_CONVERSION){
					dataRow.put(fieldName, getDisplayValue(dataRow.get(fieldName), fieldMapping.get(fieldName)));
				} else if (metaInfo.Conversion_Type__c == CURRENCY_CONVERSION){
					dataRow.put(fieldName, getDisplayCurrencyValue(dataRow.get(fieldName),metaInfo));
				}
			}	
		}
	}

	public static Decimal getDisplayCurrencyValue(Object value, Salesforce_Connect_Field_Mapping__mdt rate){
        Decimal convertedValue;
        List<String> dps = new List<String>();
		dps.add('1');
        
        if (Integer.valueOf(rate.Implied_Decimal_Places__c) == 0){
        	convertedValue = Double.valueOf(value);
        	} else {
        		for (Integer i = 0; i < Integer.valueOf(rate.Implied_Decimal_Places__c); i++){
      				dps.add('0');
				}
    		    String conversionFactor = String.join(dps, '');
				convertedValue = Double.valueOf(value) / Integer.valueOf(conversionFactor);
        	}
        
        return convertedValue;
    }

    public static Integer getEnumeratedCurrencyValue(Object value, Salesforce_Connect_Field_Mapping__mdt rate){
        Integer convertedValue;
        
        if (rate.Implied_Decimal_Places__c == 0){
        	convertedValue = Integer.valueOf(value);
        } else {
        	String conversionFactor = '1';
        	for (Integer i = 0; i == Integer.valueOf(rate.Implied_Decimal_Places__c); i++){
        		conversionFactor = conversionFactor + '0';
        	}
			convertedValue = Integer.valueOf(Double.valueOf(value) * Integer.valueOf(conversionFactor));
        }
        
        return convertedValue;
    }


	
}
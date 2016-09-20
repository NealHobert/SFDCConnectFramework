/**
* This is a base class with core funtionality to support the data mapping portion of the framework.
*/
public abstract with sharing class ExternalObjectMapperBase implements ExternalObjectMapper {

	//protected KenanServiceConnection__c kenanSettings;

	/**
	* String externalObjectAPIName: must be set before invoking getAPIValues or getDisplayValues methods.
	* This value is used to retrieve the records from Object_Field_Mapping__mdt that represent field mapping information
	**/
	public String externalObjectAPIName { get; set; }

	/**
	* internal property that is used to hold field mapping information.
	**/
	protected Map<String, Object_Field_Mapping__mdt> fieldMapping;	

	public ExternalObjectMapperBase(){
		
	}

	/**
	* Main method that is used to map Display Values to APIValues using Cutstom Metadata Types
	* @param records List&lt;Map&lt;String, Object&gt;&gt;
	* @return none
	**/
	public void mapAPIValues(List<Map<String, Object>> records){
		getFieldMapping();
		for (Map<String, Object> record : records){
			mapAPIValues(record);
		}
	}

	/**
	* Main method that is used to map API Values to Display Values using Cutstom Metadata Types
	* @param records List&lt;Map&lt;String, Object&gt;&gt;
	* @return none
	**/
	public void mapDisplayValues(List<Map<String, Object>> records){
		getFieldMapping();
		for (Map<String, Object> record : records){
			mapDisplayValues(record);
		}
	}

	/**
	* Method that is used to map a single record Display Values to API Values using Cutstom Metadata Types. It is invoked by getAPIValues
	* After all the Fields have been mapped, mapCustomAPIValues is invoked.
	* This method may be overridden if the Object_Field_Mapping__mdt object is extended with additional data that is required for mapping values
	* @param records Map&lt;String, Object&gt;
	* @return none
	**/
	protected virtual void mapAPIValues(Map<String, Object> record){
		for (String key : fieldMapping.keySet()){
			Object_Field_Mapping__mdt item = fieldMapping.get(key);
			if (record.get(key) != null) record.put(key,  getAPIValue(item.Custom_MetaData_Type__c, item.MetaData_Key_Field__c, record.get(key), item.MetaData_Display_Field__c));
		}
		mapCustomAPIValues(record);
	}

	/**
	* Method that is used to map a single record API Values to Display Values using Cutstom Metadata Types. It is invoked by getDisplayValues
	* After all the Fields have been mapped, mapCustomDisplayValues method is invoked.
	* This method may be overridden if the Object_Field_Mapping__mdt object is extended with additional data that is required for mapping values
	* @param records Map&lt;String, Object&gt;
	* @return none
	**/
	protected virtual void mapDisplayValues(Map<String, Object> record){
    	for (String key : fieldMapping.keySet()){
			Object_Field_Mapping__mdt item = fieldMapping.get(key);
			if (record.get(key) != null) record.put(key,  getDisplayValue(item.Custom_MetaData_Type__c, item.MetaData_Key_Field__c, record.get(key), item.MetaData_Display_Field__c));
		}
		mapCustomDisplayValues(record);
	}

	/**
	* Method that is used to map a single record fields API Values that cannot be accomplished using the standard Object_Field_Mapping__mdt.
	* An Example would be concatenating field values together or enforcing a date format.
	* This method must be overridden.
	* @param record Map&lt;String, Object&gt;
	* @return none
	**/
	protected abstract void mapCustomAPIValues(Map<String, Object> record);

	/**
	* Method that is used to map a single record fields Display Values that cannot be accomplished using the standard Object_Field_Mapping__mdt.
	* An Example would be concatenating field values together or enforcing a date format.
	* This method must be overridden.
	* @param record Map&lt;String, Object&gt;
	* @return none
	**/
	protected abstract void mapCustomDisplayValues(Map<String, Object> record);


	/**
	* Method that is used to retrieve an API Value using the supplied parameters
	* This method can be overridden if the Object_Field_Mapping__mdt object is extended with additional data that is required for mapping values
	* @param customMetaDataAPIName String The Custom MetaData API Name
	* @param keyFieldName String The Custom Metadata Type API Field Name that contains the API Value
	* @param displayObjectValue Object The Display Value that is transposed into the API Value
	* @param displayFieldName String The Custom Metadata Type Field that contains the Display Value
	* @return String
	**/
	protected virtual String getAPIValue(String customMetaDataAPIName, String keyFieldName, Object displayObjectValue, String displayFieldName){

        String displayValue = String.valueOf(displayObjectValue);
        String apiValue;
        String queryString = 'SELECT ' + keyFieldName + ' FROM ' + customMetaDataAPIName + ' WHERE ' + displayFieldName + ' = :displayValue';
        List<SObject> enumerations = Database.query(queryString);
        if (!enumerations.isEmpty()){
            apiValue = (String) enumerations[0].get(keyFieldName); 
        } else {
           //TODO: throw new MetadataServiceException('Enumeration value could not be located in ' + customMetaDataAPIName + 'for Value ' + displayValue ); 
        }
        
        return apiValue;
    }

    /**
	* Method that is used to retrieve a Display Value using the supplied parameters
	* This method may be overridden if the Object_Field_Mapping__mdt object is extended with additional data that is required for mapping values
	* @param records List&lt;Map&lt;String, Object&gt;&gt;
	* @return none
	**/
    protected virtual String getDisplayValue(String customMetaDataAPIName, String keyFieldName, Object keyObjectValue, String displayFieldName){

        String displayValue;
        String keyValue = String.valueOf(keyObjectValue);
        String queryString = 'SELECT ' + displayFieldName + ' FROM ' + customMetaDataAPIName + ' WHERE ' + keyFieldName + ' = :keyValue';
        List<SObject> enumerations = Database.query(queryString);
        if (!enumerations.isEmpty()){
            displayValue = (String) enumerations[0].get(displayFieldName); 
        } else {
            //throw new MetadataServiceException('Key value could not be located in ' + customMetaDataAPIName + ' for Key ' + keyValue );
        }
        return displayValue;
    }

    /**
	* Method that is used to retrieve a list of field mapping records.
	* This method may be overridden if the Object_Field_Mapping__mdt object is extended with additional data that is required for mapping values
	* @param records Map&lt;String, Object_Field_Mapping__mdt&gt;
	* @return none
	**/
    protected virtual Map<String, Object_Field_Mapping__mdt> getFieldMapping(){
		List<Object_Field_Mapping__mdt> mappingList = new List<Object_Field_Mapping__mdt>([SELECT 
																							Custom_MetaData_Type__c,
																							External_Object_Type__c,
																							External_Object_Type_Field_Name__c,
																							MetaData_Display_Field__c,
																							MetaData_Key_Field__c,
																							Sort_Order__c,
																							isActive__c
																						FROM
																							Object_Field_Mapping__mdt
																						WHERE 
																							External_Object_Type__c = : externalObjectAPIName
																							AND
																							isActive__c = true
																						ORDER BY 
																							Sort_Order__c
																						]);

		Map<String, Object_Field_Mapping__mdt> fieldMappings = new Map<String, Object_Field_Mapping__mdt>();
		for (Object_Field_Mapping__mdt item : mappingList){
			fieldMappings.put(item.External_Object_Type__c + ':' + item.External_Object_Type_Field_Name__c, item);
		}
		return fieldMappings;
    }

}
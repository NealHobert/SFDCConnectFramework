/*
Copyright (c) 2016 Trifecta Technologies Inc.
All rights reserved.

Trifecta (We/Us) grant (You/Your) non-exclusive, 
non-transferable, non-redistributable, royalty-free license to use and run (as applicable) 
solely for Your internal business purposes associated with Your use of Our code developed by Us for You.  
We retain all rights, title and interest in its respective intellectual property and We retain all ownership 
rights in this code.
*/

public with sharing class SampleSalesforceConnectService implements SalesforceConnectService {
		
    private SalesforceConnectMapper mapper;

	public SampleSalesforceConnectService() {
	   
	}


    public DataSource.TableResult query(DataSource.QueryContext context){
    	List<Map<String, Object>> rows = new List<Map<String, Object>>();
        Integer offset = context.offset;
        Integer maxResults = context.maxResults;
        mapper = SalesforceConnectUtils.getMapperClass(context);
        //TODO: implement mapper requirements

        //TODO: Determine the endpoint, json Payload, Http Method and call the SalesforceConnectConnectionHelper.sendRequest
        // 
        //HttpResponse response = SalesforceConnectConnectionHelper.sendRequest(String jsonString, String method, String endpoint, Integer startRecord, Integer blockSize)

        //TODO: Deserialize jsonBody int rows
		DataSource.TableResult result;
		result = DataSource.TableResult.get(context, rows);
		
		return result;
    }

	
    public DataSource.TableResult search(DataSource.TableSelection context, String searchPhrase){
    	return null;
    }

	
    public List<DataSource.UpsertResult> upsertRows(DataSource.UpsertContext context){
    	mapper = SalesforceConnectUtils.getMapperClass(context);

        return null;
    }
    
    public List<DataSource.DeleteResult> deleteRows(DataSource.DeleteContext context){
    	mapper = SalesforceConnectUtils.getMapperClass(context);

        return null;
    }

}
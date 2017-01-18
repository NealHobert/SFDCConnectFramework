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
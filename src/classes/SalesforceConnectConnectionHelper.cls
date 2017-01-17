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

public class SalesforceConnectConnectionHelper {

	public static HttpResponse sendRequest(String jsonString, String method, String endpoint, Integer startRecord, Integer blockSize){

		Salesforce_Connect_Settings__c connection = Salesforce_Connect_Settings__c.getInstance();

		HttpRequest request = new HttpRequest();
		request.setMethod(method);
		request.setHeader('Content-Type', 'application/json');
		request.setHeader('Accept', 'application/json');
		request.setHeader('startRecord', String.valueOf(startRecord));
		request.setHeader('blockSize', String.valueOf(blockSize));
		request.setHeader('Authorization', connection.Authentication_Token__c);
		request.setTimeout(Integer.valueOf(connection.Session_Timeout__c));
		request.setEndpoint(connection.Base_Endpoint__c);
		
		if (String.isNotEmpty(jsonString)){
			request.setBody(jsonString);	
		}
		
		Http service = new Http();
		HttpResponse response = service.send(request);	
		
		return response;
	}

}
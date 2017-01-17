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

public interface SalesforceConnectService {

	/**
	* Accepts a QueryContext to retrieve data from the Kenan API 
	* @param context DataSource.QueryContext
	* @return DataSource.TableResult with the results from the API
	*/
    DataSource.TableResult query(DataSource.QueryContext context);

	/**
	* Accepts a Table Description and a Search Phrase to execute a search on the Kenan API
	* @param context DataSource.TableSelection
	* @param searchPhrase String
	* @return DataSource.TableResult with the results from the API
	*/
    DataSource.TableResult search(DataSource.TableSelection context, String searchPhrase);

	/**
	* Accepts an UpsertContext to insert or update data via the Kenan API 
	* @param context DataSource.UpsertContext
	* @return DataSource.UpsertResult with the results from the API
	*/
    List<DataSource.UpsertResult> upsertRows(DataSource.UpsertContext context);
    
    /**
	* Accepts a DeleteContext to delete data via the Kenan API 
	* @param context DataSource.DeleteContext
	* @return DataSource.DeleteResult with the results from the API
	*/
	List<DataSource.DeleteResult> deleteRows(DataSource.DeleteContext context);
    
}
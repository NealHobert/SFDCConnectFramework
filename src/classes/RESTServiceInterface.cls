/*
* Defined Interface that all REST Services must implement.
*/
public interface RESTServiceInterface {

	/**
	* Accepts a DataSource.QueryContext to retrieve data from and external REST API 
	* @param context DataSource.QueryContext
	* @return DataSource.TableResult with the results from the API
	*/
    DataSource.TableResult query(DataSource.QueryContext context);

	/**
	* Accepts a Table Description and a Search Phrase to execute a search on an external REST API
	* @param context DataSource.TableSelection
	* @param searchPhrase String
	* @return DataSource.TableResult with the results from the API
	*/
    DataSource.TableResult search(DataSource.TableSelection context, String searchPhrase);

	/**
	* Accepts an UpsertContext to insert or update data via an external REST API
	* @param context DataSource.UpsertContext
	* @return DataSource.UpsertResult with the results from the API
	*/
    List<DataSource.UpsertResult> upsertRows(DataSource.UpsertContext context);
    
    /**
	* Accepts a DeleteContext to delete data via an external REST API
	* @param context DataSource.DeleteContext
	* @return DataSource.DeleteResult with the results from the API
	*/
	List<DataSource.DeleteResult> deleteRows(DataSource.DeleteContext context);

}
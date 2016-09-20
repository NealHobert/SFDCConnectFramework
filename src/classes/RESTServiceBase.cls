/*
* Base Service Implementation class that can be extended by and actual implementation class.
*/
public abstract with sharing class RESTServiceBase implements RESTServiceInterface {

	/*
	* local variable to hold service setting information
	*/	
	protected External_Object_Service__mdt serviceSetting;

	/*
	* local variable to hold externalObjectType
	*/	
	protected String externalObjectType;
    
    /**
	* Method called by the main Connector Class when a SOQL Query is executed on an External Object
	* This method must be overriden in the implementation class
	* @param context DataSource.QueryContext
	* @return DataSource.TableResult
	*/
    public abstract DataSource.TableResult query(DataSource.QueryContext context);

    /**
	* Method called by the main Connector Class when a SOSL Search is executed on an External Object
	* This method must be overridden in actual implementation class
	* @param context DataSource.TableSelection
	* @param searchPhrase String The search criteria of a the SOSL Search
	* @return DataSource.TableResult
	*/
    public abstract DataSource.TableResult search(DataSource.TableSelection context, String searchPhrase);

    /**
	* Method called by the main Connector Class when a DML Insert ot Update is executed on an External Object
	* This method must be overridden in actual implementation class
	* @param context DataSource.UpsertContext
	* @return DataSource.UpsertResult
	*/
	public abstract List<DataSource.UpsertResult> upsertRows(DataSource.UpsertContext context);
    
    /**
	* Method called by the main Connector Class when a DML Delete is executed on an External Object
	* This method must be overridden in actual implementation class
	* @param context DataSource.DeleteContext
	* @return DataSource.DeleteResult
	*/
    public abstract List<DataSource.DeleteResult> deleteRows(DataSource.DeleteContext context);

}
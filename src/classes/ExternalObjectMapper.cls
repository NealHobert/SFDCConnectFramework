/**
* Interface that defines the methods that must be implemented to support the mapping framework. 
* It is implemented by ExternalObjectMapperBase
*/
public interface ExternalObjectMapper {

	/**
	* Accepts a List that represents the records that will have field values converted to API Values
	* @param records List&lt;Map&lt;String, Object&gt;&gt;
	* @return 
	*/
	void mapAPIValues(List<Map<String, Object>> records);

	/**
	* Accepts a List that represents the records that will have field values converted to Display Values
	* @param records List&lt;Map&lt;String, Object&gt;&gt;
	* @return 
	*/
	void mapDisplayValues(List<Map<String, Object>> records);
}
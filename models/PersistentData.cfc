component accessors="true" {

    property name="sessionData";

    public function init(){
    	return this;
    }

    public function get(key){
    	if( structKeyExists( variables, "sessionData" ) ){
	        return structKeyExists(variables.sessionData, arguments.key) ? variables.sessionData[arguments.key] : "";
    	}
    	return "";
    }

    public function set(key, value){
        variables.sessionData[arguments.key] = arguments.value;
    }

}
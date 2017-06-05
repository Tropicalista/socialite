component {

    property name="persistentData" inject="PersistentData@socialite";
    
    property name="clientId"; // The client ID.    
    property name="clientSecret"; // The client secret.    
    property name="redirectUrl"; // The redirect URL.    
    property name="scopes" type="array"; // The scopes being requested.    
    property name="scopeSeparator"; // The separating character for the requested scopes.    
    property name="stateless"; // Indicates if the session state should be utilizd.

    /**
     * Create a new provider instance.
     *
     * @clientId
     * @clientSecret
     * @redirectUrl
     */
    public function init( clientId, clientSecret, redirectUrl ){
        variables.clientId = arguments.clientId;
        variables.redirectUrl = arguments.redirectUrl;
        variables.clientSecret = arguments.clientSecret;
        variables.stateless = false;
        variables.scopes = [];
        variables.scopeSeparator = ",";

        return this;
    }

    /**
     * Redirect the user of the application to the provider's authentication screen.
     *
     */
    public function redirect(){
        variables.state = "";

        if (this.usesState()) {
            variables.state = Hmac( Now().getTime() & persistentData.get("_token"), "state");
            persistentData.set( "state", variables.state );
        }
        return location( this.getAuthUrl( state ), false );
    }

    /**
     * Get the authentication URL for the provider.
     *
     * @url
     * @state
     */
    function buildAuthUrlFromBase( serviceUrl, state ){
        queryString = StructToQueryString( this.getCodeFields( state ) );
        return serviceUrl & '?' & queryString;
    }

    /**
     * Get the GET parameters for the code request.
     *
     * @param  string|null  state
     * @return array
     */
    function getCodeFields( state = javaCast( "null", 0 ) ){
        fields = {
                    'client_id' = variables.clientId, 
                    'redirect_uri' = variables.redirectUrl,
                    'scope' = variables.formatScopes(variables.scopes, variables.scopeSeparator),
                    'response_type' = 'code',
        };
        if (this.usesState()) {
            fields['state'] = state;
        }
        return fields;
    }

    /**
     * Format the given scopes.
     *
     * @param  array  scopes
     * @scopeSeparator
     * @return string
     */
    function formatScopes( array scopes, scopeSeparator ){
        return ArrayToList( scopes, scopeSeparator );
    }

    /**
     * {@inheritdoc}
     */
    public function user( string code){

        var token = this.getAccessToken( arguments.code );
        var user = this.getUserByToken( token );

        return mapUserToObject(user);
    }

    /**
     * Determine if the current request / session has a mismatching "state".
     *
     * @return bool
     */
    protected function hasInvalidState(){
        if (variables.isStateless()) {
            return false;
        }
    }

    /**
     * Get the access token for the given code.
     *
     * @code response code from oauth
     * @return string
     */
    public function getAccessToken( string code){
        params = this.getTokenFields( arguments.code );
        httpService = new http(); 
        httpService.setMethod( "post" ); 
        httpService.setUrl( this.getTokenUrl() );
        for(key in params) {
            httpService.addParam(type="formfield",name="#key#",value="#params[key]#");
        }

        response = httpService.send().getPrefix();
        return this.parseAccessToken(response.filecontent);

    }

    /**
     * Get the POST fields for the token request.
     *
     * @code response code from oauth
     * @return struct with fields
     */
    function getTokenFields( code ){
        return {
            'client_id' = variables.clientId, 
            'client_secret' = variables.clientSecret,
            'code' = code, 
            'redirect_uri' = variables.redirectUrl
        };
    }

    /**
     * Get the access token from the token response body.
     *
     * @body
     * @return string
     */
    function parseAccessToken( body ){
        return deserializeJson( body );
    }

    /**
     * Set the scopes of the requested access.
     *
     * @scopes  array of scopes
     * @return this
     */
    public function scopes( array scopes ){
        this.scopes = scopes;
        return this;
    }

    /**
     * Determine if the provider is operating with state.
     *
     * @return boolean 
     */
    function usesState(){
        return !variables.stateless;
    }

    /**
     * Determine if the provider is operating as stateless.
     *
     * @return boolean
     */
    function isStateless(){
        return variables.stateless;
    }

    /**
     * Converts a structure to a URL query string.
     * 
     * @urlStruct     Structure of key/value pairs you want converted to URL parameters 
     * @return Returns a string with url parameters. 
     */
    function StructToQueryString( urlStruct ) {
        var qstr = "";
        var delim1 = "=";
        var delim2 = "&";

        switch (ArrayLen(Arguments)) {
            case "3":
                delim2 = Arguments[3];
            case "2":
                delim1 = Arguments[2];
        }

        for ( key in urlStruct ) {
            qstr = ListAppend( qstr, URLEncodedFormat( LCase(key) ) & delim1 & URLEncodedFormat( urlStruct[key]), delim2 );
        }
        
        return qstr;
    }
}
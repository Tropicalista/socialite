component {

    property name="sessionStorage" inject="sessionStorage@cbstorages";

    /**
     * The client ID.
     *
     * @var string
     */
    property name="clientId";
 
    /**
     * The client secret.
     *
     * @var string
     */
    property name="clientSecret";
    
    /**
     * The redirect URL.
     *
     * @var string
     */
    property name="redirectUrl";

    /**
     * The scopes being requested.
     *
     * @var array
     */
    property name="scopes" type="array";

    /**
     * The separating character for the requested scopes.
     *
     * @var string
     */
    property name="scopeSeparator";

    /**
     * Indicates if the session state should be utilized.
     *
     * @var bool
     */
    property name="stateless";

    /**
     * Create a new provider instance.
     *
     * @param  string  clientId
     * @param  string  clientSecret
     * @param  string  redirectUrl
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
            variables.state = Hmac( Now().getTime() & sessionStorage.getVar("_token"), "state");
            sessionStorage.setVar( "state", variables.state );
        }
        return location( this.getAuthUrl( state ), false );
    }

    /**
     * Get the authentication URL for the provider.
     *
     * @param  string  url
     * @param  string  state
     * @return string
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
     * @param  string  scopeSeparator
     * @return string
     */
    function formatScopes(array scopes, scopeSeparator){
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
     * @param  string  code
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
     * @param  string  code
     * @return array
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
     * @param  string  body
     * @return string
     */
    function parseAccessToken( body ){
        return deserializeJson( body );
    }

    /**
     * Set the scopes of the requested access.
     *
     * @param  array  scopes
     * @return this
     */
    public function scopes(array scopes){
        this.scopes = scopes;
        return this;
    }

    /**
     * Determine if the provider is operating with state.
     *
     * @return bool
     */
    function usesState(){
        return !variables.stateless;
    }

    /**
     * Determine if the provider is operating as stateless.
     *
     * @return bool
     */
    function isStateless(){
        return variables.stateless;
    }

    /**
     * Converts a structure to a URL query string.
     * 
     * @param struct     Structure of key/value pairs you want converted to URL parameters 
     * @param keyValueDelim      Delimiter for the keys/values.  Default is the equal sign (=). 
     * @param queryStrDelim      Delimiter separating url parameters.  Default is the ampersand (&). 
     * @return Returns a string. 
     * @author Erki Esken (erki@dreamdrummer.com) 
     * @version 1, December 17, 2001 
     */
    function StructToQueryString(struct) {
        var qstr = "";
        var delim1 = "=";
        var delim2 = "&";

        switch (ArrayLen(Arguments)) {
            case "3":
                delim2 = Arguments[3];
            case "2":
                delim1 = Arguments[2];
        }

        for (key in struct) {
            qstr = ListAppend(qstr, URLEncodedFormat(LCase(key)) & delim1 & URLEncodedFormat(struct[key]), delim2);
        }
        
        return qstr;
    }
}
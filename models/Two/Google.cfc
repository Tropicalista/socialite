component extends="BaseProvider" implements="socialite.models.contracts.IProvider" accessors="true"{

    /**
     * The separating character for the requested scopes.
     *
     * @var string
     */
    property name="scopeSeparator";


    /**
     * The scopes being requested.
     *
     * @var array
     */
    property name="scopes" type="array";

    /**
     * Constructor
     */
    function init( clientId, clientSecret, redirectUrl ){
        super.init( arguments.clientId, arguments.clientSecret, arguments.redirectUrl );
        variables.scopes = [
            "https://www.googleapis.com/auth/plus.me",
            "https://www.googleapis.com/auth/plus.login",
            "https://www.googleapis.com/auth/plus.profile.emails.read",
        ];
        variables.scopeSeparator = " ";

        return this;
    }

    /**
     * Get auth url
     */
    function getAuthUrl(state){
        return this.buildAuthUrlFromBase( "https://accounts.google.com/o/oauth2/auth", state );
    }

    /**
     * Get token url
     */
    function getTokenUrl(){
        return "https://accounts.google.com/o/oauth2/token";
    }

    /**
     * Get the access token for the given code.
     *
     * @param  string  code
     * @return string
     */
    public function getAccessToken(code){
        var params = this.getTokenFields( arguments.code );
        params.grant_type = "authorization_code";

        var req = hyper.setMethod( "POST" )
                        .setUrl( this.getTokenUrl() )
                        .setBody( params )
                        .asFormFields()
                        .send();

        return this.parseAccessToken( req.getData() );

    }

    /**
     * Get user by token
     */
    function getUserByToken( token ){

        var req = hyper.setMethod( "GET" )
                        .setUrl( "https://www.googleapis.com/plus/v1/people/me?prettyPrint=false" )
                        .withHeaders( { 
                            "Accept" = "application/json", 
                            "Authorization" = "Bearer #arguments.token.access_token#", 
                        } )
                        .send();

        return deserializeJson( req.getData() );

    }

    /**
     * Map user
     */
    function mapUserToObject( user ){
        return {
            id = user["id"], 
            nickname = structKeyExists( user, "nickname" ) ? user["nickname"] : "", 
            name = user["displayName"],
            email = user["emails"][1]["value"], 
            avatar = user["image"]["url"],
        };
    }
}
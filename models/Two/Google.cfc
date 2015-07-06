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
            'https://www.googleapis.com/auth/plus.me',
            'https://www.googleapis.com/auth/plus.login',
            'https://www.googleapis.com/auth/plus.profile.emails.read',
        ];
        variables.scopeSeparator = " ";

        return this;
    }

    /**
     * Get auth url
     */
    function getAuthUrl(state){
        return this.buildAuthUrlFromBase('https://accounts.google.com/o/oauth2/auth', state);
    }

    /**
     * Get token url
     */
    function getTokenUrl(){
        return 'https://accounts.google.com/o/oauth2/token';
    }

    /**
     * Get the access token for the given code.
     *
     * @param  string  code
     * @return string
     */
    public function getAccessToken(code){
        var params = this.getTokenFields( arguments.code );

        httpService = new http(); 
        httpService.setMethod( "post" ); 
        httpService.setUrl( this.getTokenUrl() );

        httpService.addParam(type="formfield",name="client_id",value="#params.client_id#");
        httpService.addParam(type="formfield",name="client_secret",value="#params.client_secret#");
        httpService.addParam(type="formfield",name="code",value="#params.code#");
        httpService.addParam(type="formfield",name="redirect_uri",value="#params.redirect_uri#");
        httpService.addParam(type="formfield",name="grant_type",value="authorization_code");
        response = httpService.send().getPrefix();

        return this.parseAccessToken( response.filecontent );

    }

    /**
     * Get user by token
     */
    function getUserByToken( token )
    {
        httpService = new http(); 
        httpService.setMethod( "get" ); 
        httpService.setUrl( "https://www.googleapis.com/plus/v1/people/me?prettyPrint=false" );
        httpService.addParam(type="header",name="Accept",value="application/json");
        httpService.addParam(type="header",name="Authorization",value="Bearer #arguments.token.access_token#");

        response = httpService.send().getPrefix();

        return deserializeJson(response.filecontent);

    }

    /**
     * Map user
     */
    function mapUserToObject( user )
    {
        return {
            id = user['id'], 
            nickname = structKeyExists( user, 'nickname' ) ? user['nickname'] : "", 
            name = user['displayName'],
            email = user['emails'][1]['value'], 
            avatar = user['image']['url'],
        };
    }
}
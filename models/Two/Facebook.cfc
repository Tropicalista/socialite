component extends="BaseProvider" implements="socialite.models.contracts.IProvider" accessors="true"{

    /**
     * The base Facebook Graph URL.
     */
    property name="graphUrl";

    /**
     * The Graph API version for the request.
     */
    property name="version";

    /**
     * The scopes being requested.
     */
    property name="scopes" type="array";

    /**
     * Display the dialog in a popup view.
     */
    property name="popup" type="boolean";

    /**
     * Constructor
     */
    function init( clientId, clientSecret, redirectUrl ){
        super.init( arguments.clientId, arguments.clientSecret, arguments.redirectUrl );
        variables.version = 'v2.6';
        variables.scopes = ['email'];
        variables.graphUrl = 'https://graph.facebook.com';
        variables.fields = "name,email,gender,verified";
        variables.popup = false;

        return this;
    }

    /**
     * Get auth url
     * @state
     */
    function getAuthUrl( state ){
        return this.buildAuthUrlFromBase('https://www.facebook.com/' & variables.version & '/dialog/oauth', state);
    }

    /**
     * {@inheritdoc}
     */
    function getTokenUrl(){
        return variables.graphUrl & '/oauth/access_token';
    }

    /**
     * Get the access token for the given code.
     *
     * @param  string  code
     * @return string
     */
    public function getAccessToken( code) {
        var params = this.getTokenFields( arguments.code );

        httpService = new http(); 
        httpService.setMethod( "post" ); 
        httpService.setUrl( this.getTokenUrl() );

        httpService.addParam(type="formfield",name="client_id",value="#params.client_id#");
        httpService.addParam(type="formfield",name="client_secret",value="#params.client_secret#");
        httpService.addParam(type="formfield",name="code",value="#params.code#");
        httpService.addParam(type="formfield",name="redirect_uri",value="#params.redirect_uri#");
        response = httpService.send().getPrefix();

        return this.parseAccessToken( response.filecontent );
    }

    /**
     * Parse the access token
     */
    function parseAccessToken( token ){
        var parts = listToArray( arguments.token, "&");
        var at = parts[1];
        var access_token = listGetAt(at, 2, "=");

        return access_token;
    }

    /**
     * Get user details
     */
    function getUserByToken( token )
    {
        httpService = new http(); 
        httpService.setMethod( "get" ); 
        httpService.setUrl( variables.graphUrl & '/' & variables.version & '/me?access_token=' & token & '&fields=' & variables.fields );
        response = httpService.send().getPrefix();

        return deserializeJson(response.filecontent);

    }

    /**
     * {@inheritdoc}
     */
    function mapUserToObject( struct user )
    {
        avatarUrl = variables.graphUrl & '/' & variables.version & '/' & user['id'] & '/picture';

        return  {
            'id' = user['id'], 
            'nickname' = "", 
            'name' = structKeyExists( user, 'first_name' ) ? user['first_name'] : "",
            'email' = structKeyExists( user, 'email' ) ? user['email'] : "", 
            'avatar' = avatarUrl & '?type=normal',
            'avatar_original' = avatarUrl & '?width=1920'
        };
    }

    /**
     * Set the dialog to be displayed as a popup.
     */
    public function asPopup(){
        variables.popup = true;
    }
}
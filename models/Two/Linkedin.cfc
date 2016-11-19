component extends="BaseProvider" implements="socialite.models.contracts.IProvider" accessors="true"{

    /**
     * The scopes being requested.
     *
     * @var array
     */
    property name="scopes" type="array";

    /**
     * The fields being requested.
     *
     * @var array
     */
    property name="fields" type="array";

    /**
     * Constructor
     */
    function init( clientId, clientSecret, redirectUrl ){
        super.init( arguments.clientId, arguments.clientSecret, arguments.redirectUrl );
        variables.fields = [
            'id', 'first-name', 'last-name', 'formatted-name',
            'email-address', 'headline', 'location', 'industry',
            'public-profile-url', 'picture-url', 'picture-urls::(original)'
        ];
        variables.scope = ['r_basicprofile', 'r_emailaddress'];

        return this;
    }

    /**
     * Get Auth url
     */
    function getAuthUrl(state){
        return this.buildAuthUrlFromBase('https://www.linkedin.com/uas/oauth2/authorization', state);
    }

    /**
     * Get token url
     */
    function getTokenUrl(){
        return 'https://www.linkedin.com/uas/oauth2/accessToken';
    }

    /**
     * Get the POST fields for the token request.
     *
     * @param  string  code
     * @return array
     */
    function getTokenFields(code){
        params = super.getTokenFields(code);
        params["grant_type"] = 'authorization_code';
        return params;
    }

    /**
     * Get user
     */
    function getUserByToken( token )
    {
        fields = ArrayToList( variables.fields, ',' );
        linkedinUrl = 'https://api.linkedin.com/v1/people/~:(' & fields & ')';
        //linkedinUrl = 'https://api.linkedin.com/v1/people/~';
        httpService = new http(); 
        httpService.setMethod( "get" ); 
        httpService.setEncodeUrl( false ); 
        httpService.setUrl( linkedinUrl );
        httpService.addParam(type="header",name="x-li-format",value="json");
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
            nickname = "", 
            name = user['formattedName'],
            email = user['emailAddress'], 
            avatar = structKeyExists( user, "pictureUrl" ) ? user['pictureUrl'] : ""
        };
    }
}
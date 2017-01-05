component accessors="true"{

    property name="wirebox" inject="wirebox";
    property name="credentials";

    /**
    * Constructor
    */  
    function init( struct credential ){
        setCredentials( arguments.credential );
        return this;

    }

    /**
     * Get a driver instance.
     *
     * @param string  driver The driver to be initialized
     */
    function with( driver )
    {
        var theDriver = wirebox.getInstance('#arguments.driver#@Socialite');
        theDriver.init( variables.credentials['#arguments.driver#'].client_id, 
                        variables.credentials['#arguments.driver#'].client_secret, 
                        variables.credentials['#arguments.driver#'].redirect_url );

        return theDriver;
    }

    /**
     * Format the Twitter server configuration.
     * @param  array  config
     */
    public function formatConfig( struct config )
    {
        return {
            'identifier' = config['client_id'],
            'secret' = config['client_secret'],
            'callback_uri' = config['redirect'],
        };
    }

}
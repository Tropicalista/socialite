component accessors="true"{

    /**
     * Inject wirebox.
     *
     * @var struct
     */
    property name="wirebox" inject="wirebox";
    property name="settings" inject="coldbox:setting:oauth@Socialite";

    /**
     * The array of created "drivers".
     *
     * @var struct
     */
    property name="drivers" type="struct";

    /**
    * Constructor
    */  
    function init(){
        variables.drivers = {};
        return this;

    }

    /**
     * Get a driver instance.
     *
     * @param  string  driver
     * @return mixed
     */
    function with(driver)
    {
        return this.driver(driver);
    }

    /**
     * Get a driver instance.
     *
     * @param  string  driver
     * @return mixed
     */
    function driver(driver)
    {
        driver = driver ?: getDefaultDriver();

        // If the given driver has not been created before, we will create the instances
        // here and cache it so we can return it next time very quickly. If there is
        // already a driver created by this name, we'll just return that instance.
        if ( ! StructKeyExists(variables.drivers, driver))
        {
            variables.drivers[driver] = createDriver(driver);
        }

        return variables.drivers[driver];
    }

    /**
     * Get a driver instance.
     *
     * @param  string  driver
     * @return mixed
     */
    function createDriver(driver)
    {
        var theDriver = wirebox.getInstance('#arguments.driver#@Socialite');
        theDriver.init( settings['#arguments.driver#'].client_id, settings['#arguments.driver#'].client_secret, settings['#arguments.driver#'].redirect_url );

        return theDriver;
    }

    /**
     * Format the Twitter server configuration.
     *
     * @param  array  config
     * @return array
     */
    public function formatConfig( struct config )
    {
        return {
            'identifier' = config['client_id'],
            'secret' = config['client_secret'],
            'callback_uri' = config['redirect'],
        };
    }

    /**
     * Get the default driver name.
     *
     * @throws \InvalidArgumentException
     *
     * @return string
     */
    public function getDefaultDriver()
    {
        throw(type="InvalidData",message="No Socialite driver was specified.");
    }
}
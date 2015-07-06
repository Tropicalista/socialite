/**
* I am a new Socialite Object
*/
component accessors="true" {

    /**
     * The unique identifier for the user.
     *
     * @var mixed
     */
    property name="id";

    /**
     * The user's nickname / username.
     *
     * @var string
     */
    property name="nickname";

    /**
     * The user's full name.
     *
     * @var string
     */
    property name="name";

    /**
     * The user's e-mail address.
     *
     * @var string
     */
    property name="email";

    /**
     * The user's avatar image URL.
     *
     * @var string
     */
    property name="avatar";

	/**
	* Constructor
	*/	
	function init(){
		
		return this;

	}

    /**
     * Set the raw user array from the provider.
     *
     * @param  array  user
     * @return this
     */
    public function setRaw(array user)
    {
        variables.user = user;
        return this;
    }
    
    /**
     * Map the given array onto the user's properties.
     *
     * @param  array  attributes
     * @return this
     */
    public function map(array attributes)
    {
        return this;
    }
    /**
     * Determine if the given raw user attribute exists.
     *
     * @param  string  offset
     */
    public function offsetExists(offset)
    {
        return structKeyExists( variables.user, arguments.offset );
    }
    /**
     * Get the given key from the raw user.
     *
     * @param  string  offset
     * @return mixed
     */
    public function offsetGet(offset)
    {
        return variables.user[offset];
    }
    /**
     * Set the given attribute on the raw user array.
     *
     * @param  string  offset
     * @param  mixed  value
     * @return void
     */
    public function offsetSet(offset, value)
    {
        variables.user[offset] = value;
    }
    /**
     * Unset the given value from the raw user array.
     *
     * @param  string  offset
     * @return void
     */
    public function offsetUnset(offset)
    {
        structDelete(variables.user, offset);
    }

}

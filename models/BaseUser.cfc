/**
* I am a new Socialite Object
*/
component accessors="true" {


    property name="id"; //The unique identifier for the user.
    property name="nickname"; //The user's nickname / username.
    property name="name"; //The user's full name.
    property name="email"; //The user's e-mail address.
    property name="avatar"; //The user's avatar image URL.

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
     * @offset  string  offset
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

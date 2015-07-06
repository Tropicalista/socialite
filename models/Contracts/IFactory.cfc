/**
* I am a UserInterface
*/
interface {

    /**
     * Get an OAuth provider implementation.
     *
     * @param  string  driver
     * @return Socialite\Contracts\Provider
     */
    function driver( driver );

}
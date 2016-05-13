/**
* I am a ProviderInterface
*/
interface {

    /**
     * Redirect the user to the authentication page for the provider.
     *
     */
    public function redirect();
    
    /**
     * Get the User instance for the authenticated user.
     *
     */
    public function user( string code );

}
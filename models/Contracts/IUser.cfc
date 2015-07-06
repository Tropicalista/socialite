/**
* I am a UserInterface
*/
interface {

    /**
     * Get the unique identifier for the user.
     *
     */
    function getId();

    /**
     * Get the nickname / username for the user.
     *
     */
    function getNickname();

    /**
     * Get the full name of the user.
     *
     */
    function getName();

    /**
     * Get the e-mail address of the user.
     *
     */
    function getEmail();

    /**
     * Get the avatar / image URL for the user.
     *
     */
    function getAvatar();
    
}
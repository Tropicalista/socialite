/**
* A normal ColdBox Event Handler
*/
component{

	property name="socialite" inject="SocialiteManager@socialite";
    property name="credentials" inject="coldbox:setting:socialite";
	property name="user" inject="BaseUser@socialite";


	public any function preHandler(param) {
		addAsset( event.getModuleRoot( "socialite" ) & "/includes/css/socialite.css" );
	}

	function index(event,rc,prc){
		event.setView("home/index");
	}

	function auth(event,rc,prc){

		var social = socialite.init( credentials ).with( rc.provider );
		//dump(social);abort;
		social.redirect();

	}

	function response(event,rc,prc){
		prc.user = socialite.init( credentials ).with(rc.provider).user(rc.code);
		event.setView("home/index");
	}

}
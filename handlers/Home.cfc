/**
* A normal ColdBox Event Handler
*/
component{

	property name="socialite" inject="SocialiteManager@socialite";
	property name="user" inject="BaseUser@socialite";


	public any function preHandler(param) {
		dump(getModuleConfig( "socialite" ).entryPoint);abort;
	}

	function index(event,rc,prc){
		event.setView("home/index");
	}

	function auth(event,rc,prc){

		var social = socialite.init().with(rc.provider);
		social.redirect();

	}

	function response(event,rc,prc){
		prc.user = socialite.with(rc.provider).user(rc.code);
		event.setView("home/index");
	}

}
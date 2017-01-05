component {

	// Module Properties
	this.title 				= "Socialite";
	this.author 			= "";
	this.webURL 			= "";
	this.description 		= "";
	this.version			= "1.1.0";
	// Module Entry Point
	this.entryPoint			= "socialauth";
	// Model Namespace
	this.modelNamespace		= "socialite";
	// CF Mapping
	this.cfmapping			= "socialite";

	function configure(){

		// module settings - stored in modules.name.settings
		settings = {
			/*facebook = {
				client_id = "XXXXXXXXXXXXXXXXXXXXXXXXX",
				client_secret = "XXXXXXXXXXXXXXXXXXXXXXXXX",
				redirect_url = "http://localhost/socialauth/provider/response/facebook"					
			},
			google = {
				client_id = "XXXXXXXXXXXXXXXXXXXXXXXXX",
				client_secret = "XXXXXXXXXXXXXXXXXXXXXXXXX",
				redirect_url = "http://localhost/socialauth/provider/response/google"					
			},
			github = {
				client_id = "XXXXXXXXXXXXXXXXXXXXXXXXX",
				client_secret = "XXXXXXXXXXXXXXXXXXXXXXXXX",
				redirect_url = "http://localhost/socialauth/provider/response/github"					
			},
			linkedin = {
				client_id = "XXXXXXXXXXXXXXXXXXXXXXXXX",
				client_secret = "XXXXXXXXXXXXXXXXXXXXXXXXX",
				redirect_url = "http://127.0.0.1/socialauth/provider/response/linkedin"					
			}*/
		};

		// SES Routes
		routes = [
			// Module Entry Point
			{pattern="/provider/response/:provider", handler="home",action="response"},
			{pattern="/provider/:provider", handler="home",action="auth"},
			{pattern="/", handler="home",action="index"},
			// Convention Route
			{pattern="/:handler/:action?"}
		];

	}

	/**
	* Fired when the module is registered and activated.
	*/
	function onLoad(){

	}

	/**
	* Fired when the module is unregistered and unloaded
	*/
	function onUnload(){

	}

}

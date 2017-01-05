component {

	// Module Properties
	this.title 				= "Socialite";
	this.author 			= "";
	this.webURL 			= "";
	this.description 		= "";
	this.version			= "1.0.0";
	// If true, looks for views in the parent first, if not found, then in the module. Else vice-versa
	this.viewParentLookup 	= false;
	// If true, looks for layouts in the parent first, if not found, then in module. Else vice-versa
	this.layoutParentLookup = true;
	// Module Entry Point
	this.entryPoint			= "socialauth";
	// Model Namespace
	this.modelNamespace		= "Socialite";
	// CF Mapping
	this.cfmapping			= "Socialite";
	// Module Dependencies
	this.dependencies 		= [];

	function configure(){

		// parent settings
		parentSettings = {

		};

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

		// Layout Settings
		layoutSettings = {
			defaultLayout = ""
		};

		// datasources
		datasources = {

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

		// Custom Declared Points
		interceptorSettings = {
			customInterceptionPoints = ""
		};

		// Custom Declared Interceptors
		interceptors = [
		];

		// Binder Mappings
		// binder.map("Alias").to("#moduleMapping#.model.MyService");

		// Look for module setting overrides in parent app and override them.
		var coldBoxSettings = controller.getSettingStructure();
		if( structKeyExists( coldBoxSettings, 'oauth' ) ) {
			structAppend( settings.oauth, coldBoxSettings[ 'oauth' ], true );
		}	

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

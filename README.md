# Socialite

A cool module to handle oauth2 authentication.

Currently support:

* Facebook
* Google
* Linkedin
* Github

Installation:

You can install with commandbox

`install socialite`

Otherwise download from forgebox

https://forgebox.io/view/socialite

# Configuration:

You need to put your clientId, clientSecret and redirect url in config file.
You can insert your data in ColdBox.cfc:

```
		// Custom Settings
	    moduleSettings = {
			socialite = {
				facebook = {
					client_id = "XXXXXXXXXXXXX",
					client_secret = "XXXXXXXXXXXXX",
					redirect_url = "http://YOUR-URL/provider/response/facebook"					
				},
				google = {
					client_id = "XXXXXXXXXXXXX",
					client_secret = "XXXXXXXXXXXXX",
					redirect_url = "http://YOUR-URL/provider/response/google"					
				},
				github = {
					client_id = "XXXXXXXXXXXXX",
					client_secret = "XXXXXXXXXXXXX",
					redirect_url = "http://YOUR-URL/provider/response/github"					
				},
				linkedin = {
					client_id = "XXXXXXXXXXXXX",
					client_secret = "XXXXXXXXXXXXX",
					redirect_url = "http://YOUR-URL/provider/response/linkedin"					
				}
			}
		};
```


# Usage:

First create routes:

```
		route(pattern="/provider/response/:provider", target="socialite.response");
		route(pattern="/provider/:provider", target="socialite.auth");

```

In your view put the code for login button:

`<a href="#event.buildLink( 'provider/facebook' )#">Facebook</a>`


In your handler:

`socialite.init().with('facebook').redirect()`

This will prompt you to authentication page. Then simply:

`socialite.with('facebook').user(rc.code)`

A simple example:

```

component {

	property name="socialite" inject="SocialiteManager@socialite";
    property name="credentials" inject="coldbox:modulesettings:socialite";
	property name="user" inject="BaseUser@socialite";

	function index(event,rc,prc){
		event.setView("socialite/index");
	}

	function auth(event,rc,prc){
		var social = socialite.init( credentials ).with( rc.provider );
		social.redirect();
	}

	function response(event,rc,prc){
		prc.user = socialite.init( credentials ).with(rc.provider).user(rc.code);
		event.setView("socialite/index");
	}

}
```

And you will get user data.

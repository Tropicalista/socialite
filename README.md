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

http://www.coldbox.org/forgebox/view/Socialite

Configuration:

You need to put your clientId, clientSecret and redirect url in config file.
You can insert your data in ColdBox.cfc:

```
		// Custom Settings
		settings = {
			oauth = {
				facebook = {
					client_id = "XXXXXXXXXXXXX",
					client_secret = "XXXXXXXXXXXXX",
					redirect_url = "http://localhost:49311/socialauth/provider/response/facebook"					
				},
				google = {
					client_id = "XXXXXXXXXXXXX",
					client_secret = "XXXXXXXXXXXXX",
					redirect_url = "http://localhost:49311/socialauth/provider/response/google"					
				},
				github = {
					client_id = "XXXXXXXXXXXXX",
					client_secret = "XXXXXXXXXXXXX",
					redirect_url = "http://localhost:49311/socialauth/provider/response/github"					
				},
				linkedin = {
					client_id = "XXXXXXXXXXXXX",
					client_secret = "XXXXXXXXXXXXX",
					redirect_url = "http://127.0.0.1:49311/socialauth/provider/response/linkedin"					
				}
			}
		};
```

or in ModuleConfig:

```
		// module settings - stored in modules.socialite.settings
		settings = {
			oauth = {
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
			}
		};
```

Now simply go to http://yoururl/socialauth.

Usage:

`socialite.init().with('facebook').redirect()`

This will prompt you to authentication page. Then simply:

`socialite.with('facebook').user(rc.code)`

And you will get user data.
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

In your handler 

`socialite.init().with('facebook').redirect()`

This will prompt you to authentication page. Then simply:

`socialite.with('facebook').user(rc.code)`

And you will get user data.
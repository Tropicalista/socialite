# SocialBox

A cool module to handle oauth2 authentication.

Currently support:

* Facebook
* Google
* Linkedin
* Github

Usage:

`socialite.init().with('facebook').redirect()`

This will prompt you to authentication page. Then simply:

`socialite.with('facebook').user(rc.code)`

And you will get user data.
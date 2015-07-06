<h1>Welcome to SOcialBox module page!</h1>
<cfoutput>

<a href="socialauth" class="btn btn-primary">Back to socialbox index</a>
<a href="socialauth/provider/facebook" class="btn btn-primary">Facebook</a>
<a href="socialauth/provider/google" class="btn btn-danger">Google</a>
<a href="socialauth/provider/linkedin" class="btn btn-primary">Linkedin</a>
<a href="socialauth/provider/github" class="btn btn-warning">Github</a>

</cfoutput>

<cfif structKeyExists(prc, 'user')>
	<cfdump var="#prc.user#">
</cfif>
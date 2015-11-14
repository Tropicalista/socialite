<h1>Welcome to Socialite module page!</h1>
<cfoutput>

<a href="socialauth" class="btn btn-primary">Back to socialbox index</a>
<a href="socialauth/provider/facebook" class="btn btn-primary">Facebook</a>
<a href="socialauth/provider/google" class="btn btn-danger">Google</a>
<a href="socialauth/provider/linkedin" class="btn btn-primary">Linkedin</a>
<a href="socialauth/provider/github" class="btn btn-warning">Github</a>

<cfif structKeyExists(prc, 'user')>
	<cfdump var="#prc.user#">

<div class="row">
	<div class="col-md-12">
		<ul>
			<li>Nickname: #prc.user.nickname#</li>
			<li>Name: #prc.user.name#</li>
			<li>Id: #prc.user.id#</li>
			<li>Email: #prc.user.email#</li>
			<li><img src="#prc.user.avatar#"></li>
		</ul>	
	</div>
</div>

</cfif>

</cfoutput>


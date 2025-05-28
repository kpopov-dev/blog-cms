
<!-- Logout user and redirect to login page -->
<cfset structClear(session)>
<cflocation url="login.cfm" addtoken="false">

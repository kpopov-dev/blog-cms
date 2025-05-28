
<cfif NOT structKeyExists(session, "authenticated") OR NOT session.authenticated>
    <cflocation url="/login.cfm" addtoken="false">
</cfif>

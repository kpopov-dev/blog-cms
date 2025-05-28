
<cfif structKeyExists(form, "username") and structKeyExists(form, "password")>
    <cfquery name="getUser" datasource="blog_cms_db">
        SELECT id, username, password_hash, role
        FROM users
        WHERE username = <cfqueryparam value="#form.username#" cfsqltype="cf_sql_varchar">
    </cfquery>

    <cfif getUser.recordCount EQ 1 AND hash(form.password) EQ getUser.password_hash>
        <cfset session.authenticated = true>
        <cfset session.username = getUser.username>
        <cfset session.role = getUser.role>
        <cfoutput>Login successful. <a href="admin/index.cfm">Go to Admin</a></cfoutput>
        <cfabort>
    <cfelse>
        <cfset loginError = "Invalid username or password.">
    </cfif>
</cfif>

<cfif structKeyExists(session, "authenticated") AND session.authenticated>
    <cflocation url="admin/index.cfm" addtoken="false">
</cfif>

<!DOCTYPE html>
<html>
<head>
    <title>Login - Blog CMS</title>
</head>
<body>
    <h2>Login</h2>
    <cfif structKeyExists("loginError")>
        <p style="color:red;">#loginError#</p>
    </cfif>
    <form method="post" action="login.cfm">
        <label>Username:</label><br>
        <input type="text" name="username"><br><br>
        <label>Password:</label><br>
        <input type="password" name="password"><br><br>
        <input type="submit" value="Login">
    </form>
</body>
</html>

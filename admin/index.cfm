
<cfinclude template="user_auth.cfm">

<!DOCTYPE html>
<html>
<head>
    <title>Admin Panel - Blog CMS</title>
</head>
<body>
    <h1>Welcome to Admin Panel</h1>
    <p>Hello, <cfoutput>#session.username#</cfoutput>! You are logged in as <cfoutput>#session.role#</cfoutput>.</p>
    <ul>
        <li><a href="posts.cfm">Manage Posts</a></li>
        <li><a href="gallery.cfm">Manage Gallery</a></li>
        <li><a href="forms.cfm">View Forms</a></li>
        <li><a href="../logout.cfm">Logout</a></li>
    </ul>
</body>
</html>

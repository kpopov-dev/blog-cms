
<cfinclude template="user_auth.cfm">

<cfquery name="getMessages" datasource="blog_cms_db">
    SELECT id, name, email, message, submitted_at
    FROM contact_forms
    ORDER BY submitted_at DESC
</cfquery>

<!DOCTYPE html>
<html>
<head>
    <title>Contact Form Messages</title>
</head>
<body>
    <h2>Contact Form Submissions</h2>

    <cfoutput query="getMessages">
        <div style="margin-bottom: 20px;">
            <strong>Name:</strong> #name#<br>
            <strong>Email:</strong> #email#<br>
            <strong>Message:</strong><br>
            <pre>#message#</pre>
            <em>Submitted: #dateFormat(submitted_at, "dd-mmm-yyyy HH:mm")#</em>
            <hr>
        </div>
    </cfoutput>

    <p><a href="index.cfm">← Back to Admin</a></p>
</body>
</html>


<cfparam name="form.name" default="">
<cfparam name="form.email" default="">
<cfparam name="form.message" default="">
<cfparam name="form.captcha" default="">
<cfparam name="session.captchaAnswer" default="#randRange(2, 9)#">

<cfif NOT structKeyExists(session, "captchaAnswer")>
    <cfset session.captchaAnswer = randRange(2, 9)>
</cfif>

<cfset captchaError = "">
<cfset success = false>

<!--- Read SMTP settings from environment --->
<cfset smtpServer = GetSystemEnvironment("SMTP_SERVER")>
<cfset smtpPort = GetSystemEnvironment("SMTP_PORT")>
<cfset smtpUser = GetSystemEnvironment("SMTP_USERNAME")>
<cfset smtpPass = GetSystemEnvironment("SMTP_PASSWORD")>
<cfset smtpFrom = GetSystemEnvironment("SMTP_FROM")>
<cfset smtpTo   = GetSystemEnvironment("SMTP_TO")>

<cfif structKeyExists(form, "submit")>
    <cfif trim(form.captcha) EQ session.captchaAnswer>
        <cfquery datasource="blog_cms_db">
            INSERT INTO contact_forms (name, email, message)
            VALUES (
                <cfqueryparam value="#form.name#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#form.email#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#form.message#" cfsqltype="cf_sql_longvarchar">
            )
        </cfquery>
        <cfset success = true>
        <cfset session.captchaAnswer = randRange(2, 9)>

        <!--- Email notification --->
        <cfmail 
            to="#smtpTo#"
            from="#smtpFrom#"
            subject="New Contact Form Submission"
            server="#smtpServer#"
            port="#smtpPort#"
            username="#smtpUser#"
            password="#smtpPass#"
            type="html">

            <strong>Name:</strong> #form.name#<br>
            <strong>Email:</strong> #form.email#<br>
            <strong>Message:</strong><br>
            <pre>#form.message#</pre>

        </cfmail>

    <cfelse>
        <cfset captchaError = "Incorrect CAPTCHA answer. Please try again.">
    </cfif>
</cfif>

<!DOCTYPE html>
<html>
<head>
    <title>Contact Us</title>
</head>
<body>
    <h2>Contact Us</h2>

    <cfif success>
        <p style="color:green;">Thank you for your message!</p>
    </cfif>

    <cfif captchaError NEQ "">
        <p style="color:red;">#captchaError#</p>
    </cfif>

    <form method="post" action="contact.cfm">
        <label>Name:</label><br>
        <input type="text" name="name" value="#form.name#"><br><br>

        <label>Email:</label><br>
        <input type="email" name="email" value="#form.email#"><br><br>

        <label>Message:</label><br>
        <textarea name="message" rows="6" cols="60">#form.message#</textarea><br><br>

        <label>What is 1 + <cfoutput>#session.captchaAnswer - 1#</cfoutput>? (Anti-spam)</label><br>
        <input type="text" name="captcha"><br><br>

        <input type="submit" name="submit" value="Send">
    </form>
</body>
</html>


<cfparam name="url.lang" default="en">
<cfparam name="url.id">

<cfquery name="getPost" datasource="blog_cms_db">
    SELECT pt.title, pt.body
    FROM post_translations pt
    WHERE pt.post_id = <cfqueryparam value="#url.id#" cfsqltype="cf_sql_integer">
    AND pt.language_code = <cfqueryparam value="#url.lang#" cfsqltype="cf_sql_varchar">
</cfquery>

<!DOCTYPE html>
<html>
<head>
    <title><cfoutput>#getPost.title#</cfoutput></title>
</head>
<body>
    <cfoutput>
        <h2>#getPost.title#</h2>
        <div>#getPost.body#</div>
    </cfoutput>
    <p><a href="blog.cfm?lang=#url.lang#">← Back to Blog</a></p>
</body>
</html>

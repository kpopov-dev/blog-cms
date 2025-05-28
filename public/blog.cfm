
<cfparam name="url.lang" default="en">

<cfquery name="getPosts" datasource="blog_cms_db">
    SELECT p.id, p.slug, pt.title
    FROM posts p
    JOIN post_translations pt ON p.id = pt.post_id
    WHERE pt.language_code = <cfqueryparam value="#url.lang#" cfsqltype="cf_sql_varchar">
    ORDER BY p.created_at DESC
</cfquery>

<!DOCTYPE html>
<html>
<head>
    <title>Blog</title>
</head>
<body>
    <h2>Blog Posts</h2>
    <cfoutput query="getPosts">
        <div>
            <h3><a href="post.cfm?id=#id#&lang=#url.lang#">#title#</a></h3>
        </div>
    </cfoutput>
    <p><a href="index.cfm">← Back to Home</a></p>
</body>
</html>

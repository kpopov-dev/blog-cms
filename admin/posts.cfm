
<cfinclude template="user_auth.cfm">

<cfquery name="getPosts" datasource="blog_cms_db">
    SELECT p.id, p.slug, p.created_at, pt.title, pt.language_code
    FROM posts p
    LEFT JOIN post_translations pt ON p.id = pt.post_id
    ORDER BY p.created_at DESC
</cfquery>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Posts</title>
</head>
<body>
    <h2>Manage Blog Posts</h2>
    <p><a href="post_form.cfm">+ New Post</a></p>

    <cfoutput query="getPosts" group="id">
        <h3>Post ID: #id# — Slug: #slug#</h3>
        <ul>
            <cfoutput group="language_code">
                <li>[#language_code#] #title# 
                    - <a href="post_form.cfm?id=#id#&lang=#language_code#">Edit</a>
                </li>
            </cfoutput>
        </ul>
    </cfoutput>

    <p><a href="index.cfm">← Back to Admin</a></p>
</body>
</html>

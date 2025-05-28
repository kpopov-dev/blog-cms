
<cfinclude template="user_auth.cfm">

<cfparam name="url.id" default="">
<cfparam name="url.lang" default="en">
<cfset mode = "create">

<cfif url.id NEQ "">
    <cfquery name="getPost" datasource="blog_cms_db">
        SELECT p.slug, pt.title, pt.body
        FROM posts p
        LEFT JOIN post_translations pt 
            ON p.id = pt.post_id AND pt.language_code = <cfqueryparam value="#url.lang#" cfsqltype="cf_sql_varchar">
        WHERE p.id = <cfqueryparam value="#url.id#" cfsqltype="cf_sql_integer">
    </cfquery>
    <cfif getPost.recordCount>
        <cfset mode = "edit">
        <cfset post = getPost>
    </cfif>
</cfif>

<cfif structKeyExists(form, "submit")>
    <cfif mode EQ "create">
        <cfquery name="insertPost" datasource="blog_cms_db">
            INSERT INTO posts (slug, category_id)
            VALUES (
                <cfqueryparam value="#form.slug#" cfsqltype="cf_sql_varchar">,
                NULL
            )
        </cfquery>
        <cfset newID = insertPost.generatedKey>
    <cfelse>
        <cfset newID = url.id>
        <cfquery datasource="blog_cms_db">
            UPDATE posts SET slug = <cfqueryparam value="#form.slug#" cfsqltype="cf_sql_varchar">
            WHERE id = <cfqueryparam value="#url.id#" cfsqltype="cf_sql_integer">
        </cfquery>
    </cfif>

    <cfquery datasource="blog_cms_db">
        DELETE FROM post_translations
        WHERE post_id = <cfqueryparam value="#newID#" cfsqltype="cf_sql_integer">
        AND language_code = <cfqueryparam value="#form.language_code#" cfsqltype="cf_sql_varchar">
    </cfquery>

    <cfquery datasource="blog_cms_db">
        INSERT INTO post_translations (post_id, language_code, title, body)
        VALUES (
            <cfqueryparam value="#newID#" cfsqltype="cf_sql_integer">,
            <cfqueryparam value="#form.language_code#" cfsqltype="cf_sql_varchar">,
            <cfqueryparam value="#form.title#" cfsqltype="cf_sql_varchar">,
            <cfqueryparam value="#form.body#" cfsqltype="cf_sql_longvarchar">
        )
    </cfquery>

    <cflocation url="posts.cfm" addtoken="false">
</cfif>

<!DOCTYPE html>
<html>
<head>
    <title><cfoutput>#ucase(mode)# Post</cfoutput></title>
</head>
<body>
    <h2><cfoutput>#ucase(mode)# Post</cfoutput> - <cfoutput>#url.lang#</cfoutput></h2>
    <form method="post" action="post_form.cfm?<cfoutput>id=#url.id#&lang=#url.lang#</cfoutput>">
        <label>Slug:</label><br>
        <input type="text" name="slug" value="<cfoutput>#post.slug#</cfoutput>"><br><br>
        <input type="hidden" name="language_code" value="<cfoutput>#url.lang#</cfoutput>">
        <label>Title:</label><br>
        <input type="text" name="title" value="<cfoutput>#post.title#</cfoutput>"><br><br>
        <label>Body:</label><br>
        <textarea name="body" rows="10" cols="60"><cfoutput>#post.body#</cfoutput></textarea><br><br>
        <input type="submit" name="submit" value="Save">
    </form>
    <p><a href="posts.cfm">← Back to Posts</a></p>
</body>
</html>


<cfinclude template="user_auth.cfm">

<cfparam name="url.album_id" default="">
<cfset mode = "create">

<cfif url.album_id NEQ "">
    <cfquery name="getAlbum" datasource="blog_cms_db">
        SELECT * FROM gallery_albums WHERE id = <cfqueryparam value="#url.album_id#" cfsqltype="cf_sql_integer">
    </cfquery>
    <cfif getAlbum.recordCount>
        <cfset mode = "edit">
        <cfset album = getAlbum>
    </cfif>
</cfif>

<cfif structKeyExists(form, "submit")>
    <cfif mode EQ "create">
        <cfquery datasource="blog_cms_db">
            INSERT INTO gallery_albums (title, description)
            VALUES (
                <cfqueryparam value="#form.title#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#form.description#" cfsqltype="cf_sql_longvarchar">
            )
        </cfquery>
    <cfelse>
        <cfquery datasource="blog_cms_db">
            UPDATE gallery_albums
            SET title = <cfqueryparam value="#form.title#" cfsqltype="cf_sql_varchar">,
                description = <cfqueryparam value="#form.description#" cfsqltype="cf_sql_longvarchar">
            WHERE id = <cfqueryparam value="#url.album_id#" cfsqltype="cf_sql_integer">
        </cfquery>
    </cfif>
    <cflocation url="gallery.cfm" addtoken="false">
</cfif>

<!DOCTYPE html>
<html>
<head>
    <title><cfoutput>#ucase(mode)# Album</cfoutput></title>
</head>
<body>
    <h2><cfoutput>#ucase(mode)# Album</cfoutput></h2>
    <form method="post" action="gallery_form.cfm?<cfoutput>album_id=#url.album_id#</cfoutput>">
        <label>Title:</label><br>
        <input type="text" name="title" value="<cfoutput>#album.title#</cfoutput>"><br><br>
        <label>Description:</label><br>
        <textarea name="description" rows="5" cols="60"><cfoutput>#album.description#</cfoutput></textarea><br><br>
        <input type="submit" name="submit" value="Save">
    </form>
    <p><a href="gallery.cfm">← Back to Albums</a></p>
</body>
</html>

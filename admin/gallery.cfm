
<cfinclude template="user_auth.cfm">

<cfquery name="getAlbums" datasource="blog_cms_db">
    SELECT id, title, description, created_at FROM gallery_albums ORDER BY created_at DESC
</cfquery>

<!DOCTYPE html>
<html>
<head>
    <title>Gallery Albums</title>
</head>
<body>
    <h2>Manage Gallery</h2>
    <p><a href="gallery_form.cfm">+ New Album</a></p>

    <cfoutput query="getAlbums">
        <div style="margin-bottom: 20px;">
            <h3>#title#</h3>
            <p>#description#</p>
            <a href="gallery_form.cfm?album_id=#id#">Edit Album</a> |
            <a href="gallery_images.cfm?album_id=#id#">Manage Images</a>
        </div>
    </cfoutput>

    <p><a href="index.cfm">← Back to Admin</a></p>
</body>
</html>

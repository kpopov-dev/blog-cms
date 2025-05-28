
<cfquery name="getAlbums" datasource="blog_cms_db">
    SELECT id, title, description FROM gallery_albums ORDER BY created_at DESC
</cfquery>

<!DOCTYPE html>
<html>
<head>
    <title>Gallery</title>
</head>
<body>
    <h2>Photo Gallery</h2>
    <cfoutput query="getAlbums">
        <div>
            <h3>#title#</h3>
            <p>#description#</p>
            <a href="gallery_view.cfm?album_id=#id#">View Album</a>
        </div>
    </cfoutput>
    <p><a href="index.cfm">← Back to Home</a></p>
</body>
</html>

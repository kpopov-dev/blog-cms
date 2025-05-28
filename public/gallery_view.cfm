
<cfparam name="url.album_id">

<cfquery name="getAlbum" datasource="blog_cms_db">
    SELECT title FROM gallery_albums WHERE id = <cfqueryparam value="#url.album_id#" cfsqltype="cf_sql_integer">
</cfquery>

<cfquery name="getImages" datasource="blog_cms_db">
    SELECT file_path, caption FROM gallery_images
    WHERE album_id = <cfqueryparam value="#url.album_id#" cfsqltype="cf_sql_integer">
    ORDER BY uploaded_at DESC
</cfquery>

<!DOCTYPE html>
<html>
<head>
    <title>Album - <cfoutput>#getAlbum.title#</cfoutput></title>
</head>
<body>
    <h2><cfoutput>#getAlbum.title#</cfoutput></h2>
    <cfoutput query="getImages">
        <div style="margin:20px 0;">
            <img src="/#file_path#" width="300"><br>
            <strong>#caption#</strong>
        </div>
    </cfoutput>
    <p><a href="gallery.cfm">← Back to Gallery</a></p>
</body>
</html>


<cfinclude template="user_auth.cfm">

<cfparam name="url.album_id" default="">

<cfquery name="getAlbum" datasource="blog_cms_db">
    SELECT title FROM gallery_albums WHERE id = <cfqueryparam value="#url.album_id#" cfsqltype="cf_sql_integer">
</cfquery>

<cfif getAlbum.recordCount EQ 0>
    <cfoutput>Invalid album ID.</cfoutput>
    <cfabort>
</cfif>

<!-- Обработка загрузки изображения -->
<cfif structKeyExists(form, "submit") AND structKeyExists(form, "imageFile") AND form.imageFile.len GT 0>
    <cfset uploadDir = expandPath("../../assets/uploads/")>
    <cfset newFile = uploadDir & form.imageFile.serverFile>
    <cffile action="upload" destination="#uploadDir#" filefield="imageFile" nameconflict="makeunique">
    <cfquery datasource="blog_cms_db">
        INSERT INTO gallery_images (album_id, file_path, caption)
        VALUES (
            <cfqueryparam value="#url.album_id#" cfsqltype="cf_sql_integer">,
            <cfqueryparam value="assets/uploads/#form.imageFile.serverFile#" cfsqltype="cf_sql_varchar">,
            <cfqueryparam value="#form.caption#" cfsqltype="cf_sql_varchar">
        )
    </cfquery>
</cfif>

<!-- Получение всех изображений альбома -->
<cfquery name="getImages" datasource="blog_cms_db">
    SELECT id, file_path, caption, uploaded_at
    FROM gallery_images
    WHERE album_id = <cfqueryparam value="#url.album_id#" cfsqltype="cf_sql_integer">
    ORDER BY uploaded_at DESC
</cfquery>

<!DOCTYPE html>
<html>
<head>
    <title>Images - <cfoutput>#getAlbum.title#</cfoutput></title>
</head>
<body>
    <h2>Images in "<cfoutput>#getAlbum.title#</cfoutput>"</h2>

    <form method="post" enctype="multipart/form-data" action="gallery_images.cfm?album_id=#url.album_id#">
        <label>Select image:</label><br>
        <input type="file" name="imageFile"><br><br>
        <label>Caption:</label><br>
        <input type="text" name="caption"><br><br>
        <input type="submit" name="submit" value="Upload">
    </form>

    <h3>Uploaded Images</h3>
    <cfoutput query="getImages">
        <div style="margin-bottom: 20px;">
            <img src="/#file_path#" width="200"><br>
            <strong>#caption#</strong><br>
            Uploaded: #dateFormat(uploaded_at, "dd-mmm-yyyy")#<br>
        </div>
    </cfoutput>

    <p><a href="gallery.cfm">← Back to Albums</a></p>
</body>
</html>

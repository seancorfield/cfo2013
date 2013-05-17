<cfif structKeyExists( form, "submit" )>
  <cfset post = { } />
  <cfset structAppend( post, form ) />
  <cfset structDelete( post, "submit" ) />
  <cfset structDelete( post, "fieldnames" ) />
  <cfset post[ 'posted' ] = now() />
  <cfset post[ 'published' ] = true />
  <cfset post.tags = post.tags.split( " " ) />
  <cfloop item="key" collection="#post#">
    <cfset post[ lCase( key ) ] = post[ key ] />
  </cfloop>
  <cfset posts = request.mongo.getDBCollection("posts") />
  <cfset posts.save( post ) />
  <!---
      and update denormalized tag documents if we go that way
        tagColl = request.mongo.getDBCollection("tags")
        for ( tag in post.tags ) {
          tagColl.findAndModify(
            query = { "_id" : tag },
            fields = { "$inc" : { "count" : 1 } },
            upsert = true );
        }
  --->
  <cflocation addtoken="false" url="post.cfm" />
</cfif>
<html>
<head>
<title>ORM, NoSQL, and Vietnam - Add New Post</title>
</head>
<body>
<cfoutput>
  <h1>New Blog Post</h1>
  <form method="post" action="post.cfm">
    <table>
      <tr><td>Title:</td>
        <td><input type="text" name="title" /></td></tr>
      <tr><td>Author:</td>
        <td><input type="text" name="author" /></td></tr>
      <tr><td>Body:</td>
        <td><textarea name="body"></textarea></td></tr>
      <tr><td>Tags:</td>
        <td><input type="text" name="tags" /></td></tr>
      <tr><td>&nbsp;</td>
        <td><input type="submit" name="submit" value="Post" /></td></tr>
    </table>
  </form>
  <cfinclude template="footer.cfm"/>
</cfoutput>
</body>
</html>

<html>
<head>
<title>ORM, NoSQL, and Vietnam - Blog</title>
</head>
<body>
<cfoutput>
  <h1>ORM, NoSQL, and Vietnam</h1>

  <cfset posts = request.mongo.getDBCollection("posts") />
  <cfset entries = posts.find( criteria = { "published" : true }, sort = { "posted" : -1 }, limit = 15 ) />
  <cfset cursor = entries.asCursor() />

  <cfset anyEntries = false />
  <cfloop condition="cursor.hasNext()">
    <cfset entry = cursor.next() />
    <cfset anyEntries = true />
    <h2><a href="entry.cfm?slug=#entry['_id']#">#entry['title']#</a></h2>
    <p>Posted #dateFormat(entry['posted'],'medium')#
      at #timeFormat(entry['posted'])# by #entry['author']#</p>
    <div>
      #left( entry['body'], 50 )#...
    </div>
    <p>Tags:
      <cfloop array="#entry['tags']#" index="tag">
        <a href="tag.cfm?tag=#tag#">#tag#</a>
      </cfloop>
    </p>
  </cfloop>
  <cfif !anyEntries>
    <p>No recent entries found!</p>
  </cfif>
  <cfinclude template="footer.cfm" />
</cfoutput>
</body>
</html>

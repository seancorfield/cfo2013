<html>
<head>
<title>ORM, NoSQL, and Vietnam - Entry</title>
</head>
<body>
<cfoutput>
  <cfset posts = request.mongo.getDBCollection("posts") />
  <cfset entry = posts.findById( url.slug ) />
  <h1>#entry['title']#</h1>
  <p>Posted #dateFormat(entry['posted'],'medium')#
    at #timeFormat(entry['posted'])# by #entry['author']#</p>
  <div>
    #entry['body']#
  </div>
  <p>Tags:
    <cfloop array="#entry['tags']#" index="tag">
      <a href="tag.cfm?tag=#tag#">#tag#</a>
    </cfloop>
  </p>
  <cfinclude template="footer.cfm"/>
</cfoutput>
</body>
</html>

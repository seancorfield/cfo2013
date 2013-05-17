<cfoutput>
  <cfset posts = request.mongo.getDBCollection("posts") />
  <p>
    <a href="index.cfm">Home</a> |
    <a href="login.cfm">Admin</a>
    <!---
        we don't really want to run an aggregate on every request so
        this is something we should denormalize for performance
          tagColl = request.mongo.getDBCollection("tags")
          tags = tagColl.find( criteria = { }, sort = { "_id" : 1 } ).asArray()
        the counts would be updated as each post is added / edited
    --->
    <cfset tags = posts.aggregate(
           { "$match" : { "published" : true } },
           { "$project" : { "tags" : 1, "_id" : 0 } },
           { "$unwind" : "$tags" },
           { "$group" : { "_id" : "$tags", "count" : { "$sum" : 1 } } },
           { "$sort" : { "_id" : 1 } }
           ).asArray() />
    <cfif arrayLen(tags)>
      |
      Tags:
      <cfloop array="#tags#" index="tag">
        <a href="tag.cfm?tag=#tag._id#">#tag._id#</a> (#tag.count#)
      </cfloop>
    </cfif>
  </p>
</cfoutput>

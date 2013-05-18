<cfscript>
people = request.mongoSharded.getDBCollection( "people" );
// so that query on i is unindexed, drop all indexes...
people.dropIndexes();
// ...but recreate the name index to show original shard setup
people.ensureIndex( [ { "name" : 1 } ] );

writeOutput( "<h1>Query on shard key across multiple shards</h1>" );
writeOutput( "Wildcard query /^Ben/ explained...<br />" );
explained = people.query().regex( "name", "^Ben" ).find().explain();
writeDump( var=explained, label="/^Ben/ explained", expand=false );

writeOutput( "Wildcard query /^Sean/ explained...<br />" );
explained = people.query().regex( "name", "^Sean" ).find().explain();
writeDump( var=explained, label="/^Sean/ explained", expand=false );

writeOutput( "Direct query explained...<br />" );
explained = people.query().$eq( "name", "Sean Corfield 1234" ).find().explain();
writeDump( var=explained, label="Sean Corfield 1234 explained", expand=false );

writeOutput( "<h1>Query on non shard key (across multiple shards)</h1>" );
writeOutput( "Query i = 1234 explained...<br />" );
explained = people.query().$eq( "i", 1234 ).find().explain();
writeDump( var=explained, label="i = 1234 explained", expand=false );
people.ensureIndex( [ { "i" : 1 } ] );
writeOutput( "Query i = 1234 with an index explained...<br />" );
explained = people.query().$eq( "i", 1234 ).find().explain();
writeDump( var=explained, label="i = 1234 explained", expand=false );

writeOutput( "<h1>Query on unique shard key</h1>" );
people.remove( { "name" : "Jay" } ); // remove to ensure it's unique after insertion
people.save( { "name" : "Jay" } );
explained = people.find( { "name" : "Jay" } ).explain();
writeDump( var=explained, label="find Jay explained", expand=false );

</cfscript>
<p><a href="index.cfm">Go back</a>.</p>

<cfsetting requestTimeout=500 />
<cfscript>

people = request.mongoSharded.getDBCollection( "people" );

// generate a large chunk of random text to make the documents big enough
// that MongoDB has to rebalance more quickly
randomText = "";
for ( i = 1; i <= 1000; ++i ) {
    randomText &= i & " " & randRange( 1, 10000 ) & " ";
}

writeOutput( "Saving 10,000 sets of five people...<br />" );
for ( i = 1; i <= 10000; ++i ) {
    for ( name in [ "Sean Corfield", "Ben Nadel", "Ben Forta", "Ray Camden", "Marc Esher" ] ) {
        do {
            try {
                people.save( { "name" : name & " " & randrange( 1, 10000 ), "i" : i, "text" : randomText } );
                failed = false;
            } catch ( any e ) {
                failed = true;
                writeOutput( "*** save() failed: #e.type#/#left(e.message,30)#...; sleeping ***<br />" );
                sleep( 1000 );
            }
        } while ( failed );
    }
}
writeOutput( "Done!<br />" );

n = people.count();
writeOutput( "<p>There are #n# people in the Sharded Cluster</p>" );

</cfscript>
<p><a href="index.cfm">Go back</a>.</p>

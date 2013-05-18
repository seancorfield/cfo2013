<cfscript>

people = request.mongoReplica.getDBCollection( "people" );

writeOutput( "Saving 10,000 people...<br />" );
for ( i = 1; i <= 10000; ++i ) {
    do {
        try {
            people.save( { "name" : "Sean Corfield", "i" : i } );
            failed = false;
        } catch ( any e ) {
            failed = true;
            writeOutput( "*** save() failed: #e.type#/#left(e.message,30)#...; sleeping ***<br />" );
            sleep( 1000 );
        }
    } while ( failed );
}
writeOutput( "Done!<br />" );

n = people.count();
writeOutput( "<p>There are #n# people in the Replica Set</p>" );

</cfscript>
<p><a href="index.cfm">Go back</a>.</p>

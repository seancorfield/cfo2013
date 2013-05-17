component {
    this.name = "orm";

    function onApplicationStart() {
        // server-wide instance of JavaLoader
        if ( !structKeyExists( server, application.applicationName & "_javaLoader" ) ) {
            server[ application.applicationName & "_javaloader" ] = new cfmongodb.core.JavaLoaderFactory();
        }
        
        // application-wide setup
        hosts = [ { serverName = "localhost", serverPort = 27017 } ];
        application.mongoConfig = new cfmongodb.core.MongoConfig(
            hosts = hosts,
            dbname = "orm_blog",
            mongoFactory = server[ application.applicationName & "_javaloader" ] );
    }

    function onRequestStart() {
        if ( structKeyExists( url, "reload" ) ) onApplicationStart();

        // request setup
        request.mongo = new cfmongodb.core.MongoClient( application.mongoConfig );
    }

    function onRequestEnd() {
        // end of request
        request.mongo.close();
    }

}

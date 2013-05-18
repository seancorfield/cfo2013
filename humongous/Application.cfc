component {
    this.name = "humoungous";

    function onApplicationStart() {
        // server-wide instance of JavaLoader
        if ( !structKeyExists( server, application.applicationName & "_javaLoader" ) ) {
            server[ application.applicationName & "_javaloader" ] = new cfmongodb.core.JavaLoaderFactory();
        }
        
        // application-wide setup
        // hosts for replica set:
        var macServer = "Sean-Corfields-iMac.local";
        var winServer = "sean-xps";
        if ( server.os.name.startsWith( "Mac" ) ) {
            application.serverName = macServer;
        } else {
            application.serverName = winServer;
        }
        var basePort = 36000;
        hosts = [ { serverName = application.serverName, serverPort = basePort + 100 },
                  { serverName = application.serverName, serverPort = basePort + 200 },
                  { serverName = application.serverName, serverPort = basePort + 300 } ];
        application.mongoReplicaConfig = new cfmongodb.core.MongoConfig(
            hosts = hosts,
            dbname = "humongous",
            mongoFactory = server[ application.applicationName & "_javaloader" ] );
        application.mongoShardedConfig = new cfmongodb.core.MongoConfig(
            hosts = [ { serverName = application.serverName, serverPort = basePort } ],
            dbname = "humongous",
            mongoFactory = server[ application.applicationName & "_javaloader" ] );
    }

    function onRequestStart() {
        if ( structKeyExists( url, "reload" ) ) onApplicationStart();

        // request setup
        request.mongoReplica = new cfmongodb.core.MongoClient( application.mongoReplicaConfig );
        request.mongoSharded = new cfmongodb.core.MongoClient( application.mongoShardedConfig );
    }

    function onRequestEnd() {
        // end of request
        request.mongoReplica.close();
        request.mongoSharded.close();
    }

}

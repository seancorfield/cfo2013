<html>
<head>
<title>Humongous MongoDB Code Examples</title>
</head>
<body>
<cfoutput>
<cfset s = server.separator.file />
<h1>Clean Up First!</h1>
<p>
rm -rf #s#data#s#rs1 #s#data#s#rs2 #s#data#s#rs3
</p>
<p>
mkdir #s#data#s#rs1 #s#data#s#rs2 #s#data#s#rs3
</p>
<h1>Starting up a Replica Set</h1>
<h2>Terminal Commands</h2>
<p>
mongod --replSet rs0 --port 36100 --dbpath #s#data#s#rs1
</p>
<p>
mongod --replSet rs0 --port 36200 --dbpath #s#data#s#rs2
</p>
<p>
mongod --replSet rs0 --port 36300 --dbpath #s#data#s#rs3
</p>
<h2>Initiating via mongo Shell</h2>
<p>
mongo --port 36100
</p>
<p>
rs.initiate()
</p>
<p>
rs.conf() // look at the initial configuration
</p>
<p>
rs.add( "#application.serverName#:36200" )
</p>
<p>
rs.add( "#application.serverName#:36300" )
</p>
<h1>Replication in Action via CFML</h1>
<p><a href="?reload">Restart application now MongoDB replica set is running</a>!</p>
<p><a href="replica_populate.cfm">Populate the Replica Set</a></p>
<h1>Look at a Secondary</h1>
<p>
mongo --port 36200
</p>
<p>
use humongous
</p>
<p>
db.people.count()
</p>
<p>
rs.slaveOk()
</p>
<h1>Failover</h1>
<p>
Ask the primary to step down: rs.stepDown()
</p>
<p>
One of the secondaries will become primary. Application can continue writing without losing data or losing the connection - although it will see exceptions and need to retry operations.
<p>
<h1>Clean Up First!</h1>
<p>
rm -rf #s#data#s#cfg #s#data#s#sh1 #s#data#s#sh2 #s#data#s#sh3
</p>
<p>
mkdir #s#data#s#cfg #s#data#s#sh1 #s#data#s#sh2 #s#data#s#sh3
</p>
<h1>Starting up a Sharded Cluster</h1>
<h2>Terminal Commands</h2>
<p>
mongod --configsvr --dbpath #s#data#s#cfg
</p>
<p>
mongos --configdb localhost:27019 --port 36000
</p>
<p>
mongod --port 27100 --dbpath #s#data#s#sh1
</p>
<p>
mongod --port 27200 --dbpath #s#data#s#sh2
</p>
<p>
mongod --port 27300 --dbpath #s#data#s#sh3
</p>
<h2>Initiating via mongo Shell</h2>
<p>
mongo --port 36000
</p>
<p>
sh.addShard( "localhost:27100" )
</p>
<p>
sh.addShard( "localhost:27200" )
</p>
<p>
sh.addShard( "localhost:27300" )
</p>
<p>
sh.enableSharding( "humongous" )
</p>
<p>
sh.shardCollection( "humongous.people", { name : 1 } )
</p>
<h1>Sharding in Action via CFML</h1>
<p><a href="?reload">Restart application now MongoDB sharded cluster is running</a>!</p>
<p><a href="shard_populate.cfm">Populate the Sharded Cluster</a></p>
<h1>Look at the shards directly</h1>
<p>
mongo --port 27100
</p>
<p>
use humongous
</p>
<p>
db.people.count()
</p>
<p>
mongo --port 27200
</p>
<p>
use humongous
</p>
<p>
db.people.count()
</p>
<p>
mongo --port 27300
</p>
<p>
use humongous
</p>
<p>
db.people.count()
</p>
<h1>Querying in a Shared Cluster</h1>
<p><a href="shard_query.cfm">Explaining various queries</a></p>
</cfoutput>
</body>
</html>

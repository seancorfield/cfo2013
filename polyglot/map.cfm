<cfscript>
writeOutput( "<h1>Map and Filter Examples</h1>" );
writeOutput( "define arrayMap (in terms of arrayEach)...<br />" );
function arrayMap( arr, code ) {
    var result = [ ];
    arrayEach( arr, function(elem){
        arrayAppend( result, code(elem) );
    });
    return result;
}

a = [1,2,3,4];
b = arrayMap( a, function(it){ return it * it; } );
c = arrayFilter( a, function(it){ return it > 2; } );
writeDump( var=a, label="Original Array A" );
writeDump( var=b, label="Map Square Over A" );
writeDump( var=c, label="Filter Greater Than 2 Over A" );

writeOutput( "define structMap (in terms of structEach)...<br />" );
function structMap( str, code ) {
    var result = { };
    structEach( str, function(k,v){
        result[k] = code(v);
    });
    return result;
}
s1 = { a = 1, b = 2, c = 3, d = 4 };
s2 = structMap( s1, function(it){ return it * it } );
s3 = structFilter( s1, function(_,v){ return v > 2; } );
writeDump( var=s1, label="Original Struct S1" );
writeDump( var=s2, label="Map Square Over S1" );
writeDump( var=s3, label="Filter Greater Than 2 Over S1" );

writeOutput( "define structMapKV (takes key/value args)...<br />" );
function structMapKV( str, code ) {
    var result = { };
    structEach( str, function(k,v){
        structAppend( result, code(k,v) );
    });
    return result;
}
s1 = { a = 1, b = 2, c = 3, d = 4 };
s2 = structMapKV( s1, function(k,v){ return { "#k##k#" = v * v } } );
writeDump( var=s1, label="Original Struct S1" );
writeDump( var=s2, label="MapKV Square Over S1 With Appended Key Names"  );

writeOutput( "define arrayReduce / structReduce / structReduceKV...<br />" );
function arrayReduce( arr, code, init = 0 ) {
    arrayEach( arr, function(elem){
        init = code(init,elem);
    });
    return init;
}
function structReduce( str, code, init = 0 ) {
    structEach( str, function(_,v){
        init = code(init,v);
    });
    return init;
}
function structReduceKV( str, code, init = 0 ) {
    structEach( str, function(k,v){
        init = code(init,k,v);
    });
    return init;
}
writeOutput( "reduce(a) = " &
   arrayReduce( a,
      function(i,n){ return i + n; } ) & "<br />" );
writeOutput( "reduce(s1) = " &
   structReduce( s1,
      function(i,n){ return i + n; } ) & "<br />" );
writeOutput( "reduceKV(s1): " &
   structReduceKV( s1,
      function(i,k,v){ return listAppend(i,"#k#=#v#"); }, "" ) & "<br />" );
</cfscript>
<p><a href="index.cfm">Go Back</a></p>

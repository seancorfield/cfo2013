<cfscript>
writeOutput( "<h1>Lazy Sequences</h1>" );
// lazily returns an "infinite" sequence
function iterate( f, init ){
    return function(){
        return { head = init, tail = iterate( f, f(init) ) };
    };
}
// takes first 'n' items of a lazy sequence
function take( n, s ){
    var result = [ ];
    while ( n > 0 ){
        var ss = s();
        if ( structIsEmpty( ss ) ) break;
        arrayAppend( result, ss.head );
        s = ss.tail;
        n = n - 1;
    }
    return result;
}
// drops first 'n' items from a lazy sequence
function drop( n, s ){
    while ( n > 0 ){
        var ss = s();
        if ( structIsEmpty( ss ) ) break;
        s = ss.tail;
        n = n - 1;
    }
    return s;
}
writeOutput( "define ints as the lazy infinite sequence from zero up...<br />" );
inc = function(n){ return n + 1; };
ints = iterate( inc, 0 );
writeOutput( "take( 5, ints )<br />" );
writeDump( take( 5, ints ) );
writeOutput( "take( 10, ints )<br />" );
writeDump( take( 10, ints ) );
writeOutput( "take( 5, drop( 5, iterate( ..., 1 ) ) ) ;; anonymous double fn<br />" );
writeDump( take( 5, drop( 5, iterate( function(n){ return n * 2; }, 1 ) ) ) );

// lazily map function over lazy sequence
function map( f, s ){
    return function(){
        var ss = s();
        if ( structIsEmpty( ss ) ) return ss;
        return { head = f( ss.head ), tail = map( f, ss.tail ) };
    };
}
// lazily filter over lazy sequence
function filter( pred, s ){
    return function(){
        var ss = s();
        if ( structIsEmpty( ss ) ) return ss;
        if ( pred( ss.head ) ) {
            return { head = ss.head, tail = filter( pred, ss.tail ) };
        } else {
            var filtered = filter( pred, ss.tail );
            return filtered();
        }
    };
}
writeOutput( "define range to return lazy infinite sequence of ints...<br />" );
function range( start = 0 ) {
    return iterate( inc, start );
}
writeOutput( "define oddQ to return true if arg is odd...<br />" );
oddQ = function(n){ return n mod 2 == 1; };
writeOutput( "take( 5, map( inc, filter( oddQ, range() ) ) )<br />" );
writeDump( take( 5, map( inc, filter( oddQ, range() ) ) ) );

// example seauence primitives for lazy sequences:
function first(s){
    var ss = s();
    return ss.head;
}
function rest(s){
    var ss = s();
    return ss.tail;
}
function cons(hd,tl){
    return function(){
        return { head = hd, tail = tl };
    };
}
// given a lazy sequence, return it; given an array, return a lazy sequence of it
function seq(x,i=1){
    if ( isArray( x ) ) {
        return function(){
            if ( i > arrayLen( x ) ) {
                return { };
            } else {
                return { head = x[i], tail = seq( x, i+1 ) };
            }
        }
    } else {
        return x;
    }
}
writeOutput( "take( 5, seq( [1,2,3,4,5,6,7,8,9,10] ) )<br />" );
writeDump( take( 5, seq( [1,2,3,4,5,6,7,8,9,10] ) ) );
writeOutput( "take( 10, seq( [1,2,3,4,5] ) )<br />" );
writeDump( take( 10, seq( [1,2,3,4,5] ) ) );
writeOutput( "take( 10, map( inc, seq( [1,2,4,8,16] ) ) )</br />" );
writeDump( take( 10, map( inc, seq( [1,2,4,8,16] ) ) ) );
</cfscript>
<p><a href="index.cfm">Go Back</a></p>

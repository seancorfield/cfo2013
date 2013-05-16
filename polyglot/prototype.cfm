<cfscript>
writeOutput( "<h1>Prototype Example</h1>" );
// prototype examples
Person = new person("","");
Person.prototype.greeting = function(salutation){
    writeOutput( "prototype.greeting: " );
    return salutation & " " & this.first & "!";
};
writeOutput( "create me... <br />" );
me = new person("Sean","Corfield");
writeOutput( me.greeting( "Hi" ) & "<br />" );
writeOutput( "create my wife...<br />" );
wife = new person("Jay","Bangle");
writeOutput( wife.greeting( "Hello" ) & "<br />" );

writeOutput( "add new prototype function...<br />" );
Person.prototype.fullname = function(){
    writeOutput( "prototype.fullname: " );
    return this.first & " " & this.last;
};
writeOutput( me.fullname() & "<br />" );
writeOutput( wife.fullname() & "<br />" );

// callback examples
writeOutput( "<h1>Callback Example</h1>" );
function process( name, callback ) {
    writeOutput("running process " & name & ", calling the callback: ");
    return callback( name );
}
result = process( "PROCESS1", function(name){
    writeOutput("in the callback for " & name & "<br />");
    return name;
});
writeOutput("PROCESS1 returned " & result & "<br />");
result = process( "PROCESS2", function(name){
    return "((" & name & "))";
});
writeOutput("PROCESS2 returned " & result & "<br />");

// closure examples
writeOutput( "<h1>Closure Example</h1>" );
greeting = function(salutation){
    writeOutput( "top-level function(" & salutation & ")<br />" );
    return function(name){
        writeOutput( "nested function(" & name & "): " );
        return salutation & " " & name & "!";
    };
};
formalGreeting = greeting("Good afternoon");
hipsterGreeting = greeting("Yo");
writeOutput( formalGreeting(me.first) & "<br />" );
writeOutput( hipsterGreeting(wife.first) & "<br />" );
</cfscript>
<p><a href="index.cfm">Go Back</a></p>

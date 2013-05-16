var greeting = function(salutation){
    return function(name){
        return salutation + " " + name + "!";
    };
};
var greet = greeting("Hello");
console.log( greet("Sean") ); // Hello Sean!

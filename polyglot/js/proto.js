var Person = function(first, last){
    this.first = first;
    this.last = last;
};

Person.prototype.greeting = function(salutation){
    return salutation + " " + this.first + "!";
};

var me = new Person("Sean", "Corfield");
console.log( me.greeting("Hi") ); // Hi Sean!

Person.prototype.fullname = function(){
    return this.first + " " + this.last;
};
console.log( me.fullname() ); // Sean Corfield

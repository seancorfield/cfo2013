component {
    function init() {
        this.prototype = createPrototype( getMetadata( this ) );
        return this;
    }
    this.protoype = { };
    function onMissingMethod( method, args ) {
        return callPrototype( this.prototype, method, args );
    }
    function callPrototype( proto, method, args ) {
        if ( structKeyExists( proto, method ) ) {
            var _method = " " & method;
            this[ _method ] = proto[ method ];
            return invoke( this, _method, args );
            // this[ _method ]( argumentCollection = args );
        } else if ( structKeyExists( proto, "_super" ) ) {
            return callPrototype( proto._super, method, args );
        }
    }
    function createPrototype( md ) {
        param name="application['prototype_#md.name#']" default="#structNew()#";
        var p = application[ "prototype_" & md.name ];
        if ( structKeyExists( md, "extends" ) ) {
            var pp = createPrototype( md.extends );
            p._super = pp;
        }
        return p;
    }

}

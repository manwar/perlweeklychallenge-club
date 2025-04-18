sub f { join( '', sort split//, pop ) eq
        join( '', sort split//, pop )    }

print f( "desc",   "dsec"   ) ? "ok\n" : "error\n";  # true
print f( "fuck",   "fcuk"   ) ? "ok\n" : "error\n";  # true
print f( "poo",    "eop"    ) ? "error\n" : "ok\n";  # false
print f( "stripe", "sprite" ) ? "ok\n" : "error\n";  # true

sub f { pop() =~ s/ \(\) / o /regx =~ s/ \(al\) / al /regx }

print f( $$_[0] ) eq $$_[1] ? "ok\n" : "ERROR\n" for
[ "G()(al)"        =>  "Goal"    ],
[ "G()()()()(al)"  =>  "Gooooal" ],
[ "(al)G(al)()()"  =>  "alGaloo" ],
[ "()G()G"         =>  "oGoG"    ],
[ "(al)(al)G()()"  =>  "alalGoo" ],

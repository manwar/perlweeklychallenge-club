sub f { shift =~ s{ .*? @{[ shift ]} }{ reverse $& }xer }

print f( @$_[0,1] ) eq $$_[2] ? "ok\n" : "error\n" for
[ "programming", "g"   => "gorpramming" ],
[ "hello",       "h"   => "hello"       ],
[ "abcdefghij",  "h"   => "hgfedcbaij"  ],
[ "reverse",     "s"   => "srevere"     ],
[ "perl",        "r"   => "repl"        ],
    

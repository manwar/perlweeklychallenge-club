sub f {my($s, $n) = @_; join '', map chr 97 + ( ord($_) - 97 + $n ) % 26, split //, $s }
print f(@$_[0,1] ) eq $$_[2] ? "ok\n" : "ERROR\n" for
[ "abc",    1  =>  "bcd"   ],
[ "xyz",    2  =>  "zab"   ],
[ "abc",   27  =>  "bcd"   ],
[ "hello",  5  =>  "mjqqt" ],
[ "perl",  26  =>  "perl"  ],

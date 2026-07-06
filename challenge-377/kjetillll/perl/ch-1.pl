# https://theweeklychallenge.org/blog/perl-weekly-challenge-377/

sub f { ( $_[0] . "\0" . reverse$_[0] ) =~ / (..) .* \0 .* \1 /x }

my($true, $false) = (1, 0);
print f( $$_[0] ) == $$_[1] ? "ok\n" : "ERROR\n" for
[ "abcba"   => $true  ],
[ "racecar" => $true  ],
[ "abcd"    => $false ],
[ "banana"  => $true  ],
[ "hello"   => $true  ],
[ "farout"   => $false  ],

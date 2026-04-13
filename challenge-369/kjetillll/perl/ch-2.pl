sub f {
    my($str, $size, $filler) = @_;
    ( $str . $filler x ( $size - 1 ) )  =~ /.{$size}/g
}

use Test::More tests => 5;
is_deeply [ f( splice @$_, 0, 3 ) ], $_ for
    [ "RakuPerl",   4, "*"   =>   "Raku", "Perl"             ],
    [ "Python",     5, "0"   =>   "Pytho", "n0000"           ],
    [ "12345",      3, "x"   =>   "123", "45x"               ],
    [ "HelloWorld", 3, "_"   =>   "Hel", "loW", "orl", "d__" ],
    [ "AI",         5, "!"   =>   "AI!!!"                    ],

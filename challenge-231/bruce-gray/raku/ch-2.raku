sub task2     (     @p --> UInt  ) { @p.grep(&is_senior).elems }
sub is_senior ( Str $s --> Bool  ) { $s.&passenger.<age> ≥ 60  }
sub passenger ( Str $s --> Match ) {
    my regex phone { \d ** 10 }
    my regex sex   { <[MF]>   }
    my regex age   { \d **  2 }
    my regex seat  { \d **  2 }
    return $s ~~ / ^ <phone> <sex> <age> <seat> $ /;
}


my @tests =
    ( 2, <7868190130M7522 5303914400F9211 9273338290F4010> ),
    ( 0, <1313579440F2036 2921522980M5644> ),
;
use Test;
plan +@tests;
for @tests -> ( $expected, @in ) {
    is task2(@in), $expected;
}

sub trim_list ( $i, @n ) {
    return @n.grep: * > $i;
}

my @tests = 
    ( 3, (1,4,2,3,5)     , (4,5)     ),
    ( 4, (9,0,6,2,3,8,5) , (9,6,8,5) ),
;
use Test;
plan +@tests;
for @tests -> ( $i, $n, $expected ) {
    is-deeply trim_list($i, $n), $expected;
}

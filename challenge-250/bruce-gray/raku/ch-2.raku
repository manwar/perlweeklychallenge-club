sub task2 ( @a --> Int ) {
    return @a.map({ +$_ // .chars }).max;
}


constant @tests =
    (  6, <perl 2 000 python r4ku> , 'Task example 1'  ),
    (  1, <001 1 000 0001>         , 'Task example 2'  ),
    ( -3, <-3 -55 -987>            , 'Max is negative' ),
;
use Test; plan +@tests;
for @tests -> ( $expected, @in, $name ) {
    is task2(@in), $expected, $name;
}

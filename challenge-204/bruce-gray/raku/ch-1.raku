sub task1 ( @ns --> Bool ) { ([<=] @ns) || ([>=] @ns) }


my @tests =
    (1,2,2,3) => 1,
    (1,3,2)   => 0,
    (6,5,5,4) => 1,
;
use Test;
plan +@tests;
is +task1(.key), .value for @tests;

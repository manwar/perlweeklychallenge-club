#!perl
use v5.40;

sub task2 ($str) {
    return $str =~ / ^ [^b]* b [^a]* $ /msx;
}


my @tests = (
    'aabb' , true  ,
    'abab' , false ,
    'aaa'  , false ,
    'bbb'  , true  ,
);
use Test2::V0 -no_srand => 1; plan @tests/2;
for my ( $str, $expected ) (@tests) {
    is task2($str), $expected;
}

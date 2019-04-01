# Write a script that can convert integers to and from a base35
# representation, using the characters 0-9 and A-Y.

use v5.10;
use strict;
use warnings;

sub to_base35 {
    my $num = shift;
    my $res = "";
    my @val = (0..9, 'A'..'Y');
    do {
        $res .= $val[$num % 35];
        $num = int($num / 35);
    } while $num;
    $res = reverse $res;
    $res;
}

if (@ARGV) {
    say to_base35 shift;
}
else {
    eval "use Test::More";
    is(to_base35(0),        "0");
    is(to_base35(10),       "A");
    is(to_base35(35),       "10");
    is(to_base35(1337),     "137");
    is(to_base35(20190401), "DFVXL");
    done_testing();
}

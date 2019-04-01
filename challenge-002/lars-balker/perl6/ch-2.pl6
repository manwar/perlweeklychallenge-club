# Write a script that can convert integers to and from a base35
# representation, using the characters 0-9 and A-Y.

use v6;
use Test;

sub to_base35(Int $num) {
    return $num.base(35);
}

multi sub MAIN($num) {
    say to_base35($num);
}

# kinda love this ARGV multi method dispatching in perl6
multi sub MAIN() {
    is(to_base35(0),        "0");
    is(to_base35(10),       "A");
    is(to_base35(35),       "10");
    is(to_base35(1337),     "137");
    is(to_base35(20190401), "DFVXL");
    done-testing();
}

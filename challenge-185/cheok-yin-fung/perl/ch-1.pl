# The Weekly Challenge 185
# Task 1 MAC Address
use v5.30.0;
use warnings;

sub mac_add {
    if ($_[0] =~ /(\w\w)(\w\w)\.(\w\w)(\w\w)\.(\w\w)(\w\w)/) {
        return "$1:$2:$3:$4:$5:$6";
    }
    else {
        die "Not a MAC address in the designated form."
    }
}

use Test::More tests=>2;
ok mac_add("1ac2.34f0.b1c2") eq "1a:c2:34:f0:b1:c2";
ok mac_add("abc1.20f1.345a") eq "ab:c1:20:f1:34:5a";

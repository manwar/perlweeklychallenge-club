#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab
use v6.d;

use lib $?FILE.IO.parent(2).add("lib");
use Test;

=begin comment
Task 2: Gamma Function
Implement subroutine gamma() using the Lanczos approximation method.

Example
print gamma(3); # 1.99
print gamma(5); # 24
print gamma(7); # 719.99

=end comment

# NOTE:  No credit to me.  I can grab Rosetta Code which I don't
# understand and and test it slightly.

sub Γ( \z ) {
    constant g = 9;
    z < .5 ?? pi/ sin(pi * z) / Γ(1 - z) !!
    sqrt(2*pi) *
    (z + g - 1/2)**(z - 1/2) *
    exp(-(z + g - 1/2)) *
    [+] <
        1.000000000000000174663
        5716.400188274341379136
       -14815.30426768413909044
        14291.49277657478554025
       -6348.160217641458813289
        1301.608286058321874105
       -108.1767053514369634679
        2.605696505611755827729
       -0.7423452510201416151527e-2
        0.5384136432509564062961e-7
       -0.4023533141268236372067e-8
    > Z* 1, |map 1/(z + *), 0..*
}

plan 20;

my constant @factorial = gather for 0 .. ∞  {
    once { take 1; next };
    take [×] 1 .. $_-1
}

for 1 .. 20 {
    is-approx Γ($_), @factorial[$_], "Γ($_) approximates " ~ @factorial[$_];
}
done-testing;

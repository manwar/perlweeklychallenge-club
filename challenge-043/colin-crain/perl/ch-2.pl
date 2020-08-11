#! /opt/local/bin/perl
#
#       ch-2.pl
#
#       PWC 43 - TASK #2
#             Self-descriptive Numbers
#                 Write a script to generate Self-descriptive Numbers in a given
#                 base.
#
#                 In mathematics, a self-descriptive number is an integer m that in
#                 a given base b is b digits long in which each digit d at position
#                 n (the most significant digit being at position 0 and the least
#                 significant at position b - 1) counts how many instances of digit
#                 n are in m.
#
#                 For example, if the given base is 10, then script should print
#                 6210001000.
#
#            method:
#                 There are two basic ways to approach this problem:
#
#                 1. The formula:
#
#                       (b-4)b^(b-1) + 2b^(b-2) + b^(b-3) + b^3
#
#                 will generate a self-descriptive number for any base 7+.
#                 However the formula is in base10, so we will need to convert
#                 the base10 number to the relevant base to see its
#                 self-descriptive nature. Because the numbers get quite large,
#                 we will need to utilize the bigint pragma
#
#                 2. Alternately, we could just assemble a number out of whole cloth,
#                 as the interesting qualities of the numbers are based on numeric
#                 position rather than mathematical quirks. Logic, more than math,
#                 defines whether numbers exist in the lower end of the range, and
#                 above 6, the numbers follow a set positional pattern.
#
#                 A little logical excursion shows, for example, that for binary,
#                 with 1 and 0 available, no number can exist. No number can have
#                 a 0 in the 0th position, as its existence nullifies itself. In
#                 binary we have two positions available, so if the 0th is 1, the
#                 first must be 0, being the 0 counted in the 0th position, but
#                 that again leads to contradiction. So no binary. Similar logic
#                 applies for tertinary, but for quartinary we can construct 2100.
#                 For bases 5 and 6 again we get nothing, but after 6 the pattern:
#
#                         position    value
#                         0           (b-4)
#                         1           2
#                         2           1
#                         ...         0   in quantity (b-7)
#                         (b-3)       1
#                         (b-2)       0
#                         (b-1)       0
#                         b           0
#
#                 so we can build arbitrarily large numbers for bases > 6 by
#                 assembling strings:
#
#                         "(base - 4) displayed in the base" + "21"
#                                         + "(base -7) number of 0s" + "1000"
#
#                 Comparison with the formulaic derivation we can see that the
#                 results are the same.
#
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

use bigint;

## ## ## ## ## MAIN

my $base;

say "derived numbers:";
for $base (7..39){
    printf "%2d     %s\n", $base, self_descriptive($base);
}

say "";

say "assembled numbers:";
for $base (7..39){
    printf "%2d     %s\n", $base, self_descriptive_assembled($base);
}

sub self_descriptive {
## formula for creating self-descriptive numbers in base 10 for a given base ( > 7 )
    my $base = shift;
    my $dec = ($base-4)*($base**($base-1)) + 2*($base**($base-2)) + $base**($base-3) + $base**3;
    my @alphanum = (0..9, 'A'..'Z');
    my $out = "";
    my $rem;
    while ( $dec > 0 ) {
        ($dec, $rem) = (int( $dec/$base ), $dec % $base);
        $out = $alphanum[$rem] . $out;
    }
    return $out;
}

sub self_descriptive_assembled {
## or we can just assemble a graphical representation of a number manually that will fit the bill
    my $base = shift;
    my @alphanum = (0..9, 'A'..'Z');
    my $out = $alphanum[$base-4] . "21" . "0" x ($base-7) . "1000";
    return $out;
}

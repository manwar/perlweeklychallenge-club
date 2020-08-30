#! /usr/bin/perl
use strict;
use warnings;
use feature 'say';
use List::Util 'max';

my @R =  (2, 1, 4, 5, 3, 7);

#  7           #
#  6           #
#  5       #   #
#  4     # #   #
#  3     # # # #
#  2 #   # # # #
#  1 # # # # # #
#  _ _ _ _ _ _ _
#    2 1 4 5 3 7

# Result : 12
my @res;
for my $f (@R) {
    my $s = 0;
    for my $e (@R) {
        if ($e >= $f) {
            $s++
        } else {
            push @res, $s * $f;
            $s = 0;
        }
    }
    push @res, $s * $f;
}

#Will work nicely on values < 10
for my $t (-(max @R) .. -1) {
    print -$t;
    say map { $_ >= -$t ? " #" : "  " } @R
}
say "- " x (@R+1);
say "  @R\n";

say max @res





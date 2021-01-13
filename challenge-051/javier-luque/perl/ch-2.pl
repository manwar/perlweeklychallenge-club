#!/usr/bin/perl
# Test: ./ch-2.pl
use strict;
use warnings;
use feature qw /say/;

my @solutions;
for my $h (2 ... 9) {
    for my $t (2 .. 9) {
        for my $o (2 .. 9) {
            if ( $h * $t != $t * $o &&
                 $h * $t != $h * $t * $o &&
                 $h * $o != $h * $t * $o &&
                 $t * $o != $h * $t * $o) {
                push @solutions, "$h$t$o";
            }
        }
    }
}

say join ' ', @solutions;

#!/usr/bin/env perl

# TASK #2 > Distinct Terms Count
# Submitted by: Mohammad S Anwar
# You are given 2 positive numbers, $m and $n.
#
# Write a script to generate multiplication table and display count of distinct
# terms.

use Modern::Perl;

my($m, $n) = @ARGV or die "Usage: ch-2.pl m n\n";
my %terms;
for my $a (1..$m) {
    for my $b (1..$n) {
        my $prod = $a*$b;
        $terms{$prod} = 1;
    }
}
say scalar(keys %terms);

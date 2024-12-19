#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use Algorithm::Combinatorics qw{ permutations };

sub beautiful_arrangement($n) {
    my $permutator = permutations([1 .. $n]);
    my $count = 0;
  PERMUTATION:
    while (my $perm = $permutator->next) {
        for my $i (1 .. $n) {
            my $p_div_i = $perm->[$i - 1] % $i;
            my $i_div_p = $i % $perm->[$i - 1];
            next PERMUTATION if $p_div_i && $i_div_p;
        }
        ++$count;
    }
    return $count
}

use Test::More tests => 3 + 1;

is beautiful_arrangement(2), 2, 'Example 1';
is beautiful_arrangement(1), 1, 'Example 2';
is beautiful_arrangement(10), 700, 'Example 3';

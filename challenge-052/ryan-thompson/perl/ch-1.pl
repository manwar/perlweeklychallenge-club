#!/usr/bin/env perl
#
# ch-1.pl - Stepping numbers
#
# 2020 Ryan Thompson <rjt@cpan.org>

use 5.010;
use warnings;
use strict;

my @step;
for my $n (1..9) {
    push @step, map { $n . join '',        $n+1..$_   }   $n..9;
    push @step, map { $n . join '', reverse  $_..$n-1 }    0..$n-1;
}

# Only 3-digit results, per problem description
say join ' ', sort { $a <=> $b } grep 3 == length, @step;

# All results, because why not
say join ', ', sort { $a <=> $b } @step;

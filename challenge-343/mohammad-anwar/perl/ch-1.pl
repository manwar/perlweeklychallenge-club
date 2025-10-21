#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;
use List::Util qw/min/;

my @examples = (
    { input => [4, 2, -1, 3, -2],     exp => 1 },
    { input => [-5, 5, -3, 3, -1, 1], exp => 1 },
    { input => [7, -3, 0, 2, -8],     exp => 0 },
    { input => [-2, -5, -1, -8],      exp => 1 },
    { input => [-2, 2, -4, 4, -1, 1], exp => 1 },
);

foreach (@examples) {
    is(zero_friend($_->{input}), $_->{exp});
}

done_testing;

sub zero_friend { my ($nums) = @_; return min map abs, @$nums }

#!/usr/bin/env perl

use v5.38;
use Test::More;
use List::Util qw(sum);

my @examples = (
    { in => [1, 2, 4, 5, 6], out => 7 },
    { in => [-5, -2, -1, 3], out => 1 },
    { in => [1, 2, 3],       out => 4 },
    { in => [2, 3, 7, 8],    out => 6 },
    { in => [1, 1, 1, 10],   out => 4 },
);

is smallest_greater_absent(@{$_->{in}}), $_->{out} foreach @examples;

done_testing;

sub smallest_greater_absent(@arr) {
    my %seen = map { $_ => 1 } @arr;
    my $avg  = sum(@arr) / @arr;
    my $n    = int($avg) + 1;
    $n = 1 if $n < 1;
    $n++ while $seen{$n};
    return $n;
}

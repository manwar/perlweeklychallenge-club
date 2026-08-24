#!/usr/bin/env perl

use v5.38;
use Test::More;

my @examples = (
    { in => "111000", out => 0 },
    { in => "00011",  out => 4 },
    { in => "01011",  out => 3 },
    { in => "010101", out => 3 },
    { in => "00001",  out => 4 },
);

is min_steps($_->{in}), $_->{out} foreach @examples;

done_testing;

sub min_steps {
    my ($str) = @_;
    my $steps = 0;
    $steps++ while $str =~ s/01/10/g;
    return $steps;
}

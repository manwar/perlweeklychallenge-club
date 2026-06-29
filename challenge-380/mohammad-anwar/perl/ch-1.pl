#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;
use List::Util qw(max);

my @examples = (
    {
        in  => "banana",
        out => 5
    },
    {
        in  => "teestett",
        out => 7
    },
    {
        in  => "aeiouuaa",
        out => 3
    },
    {
        in  => "rhythm",
        out => 2
    },
    {
        in  => "x",
        out => 1
    },
);

is sum_of_freq($_->{in}), $_->{out} foreach @examples;

done_testing;

sub sum_of_freq {
    my ($str) = @_;

    my (%v, %c);
    foreach my $char (split //, lc $str) {
        if    ($char =~ /[aeiou]/) { $v{$char}++ }
        elsif ($char =~ /[a-z]/)   { $c{$char}++ }
    }

    return (max(values %v) // 0) + (max(values %c) // 0);
}

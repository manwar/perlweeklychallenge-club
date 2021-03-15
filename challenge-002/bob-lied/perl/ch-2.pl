#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl
#=============================================================================
# Copyright (c) 2021, Bob Lied
#=============================================================================
# Perl Weekly Challenge 002, Task #2 Base 35
# Write a script that can convert integers to and from a base35
# representation, using the characters 0-9 and A-Y.
#=============================================================================

use strict;
use warnings;
use 5.020;

use experimental qw/ signatures /;

my $BASE = 35;

my @BaseDigit = ( 0 .. 9, "A" .. "Z" );
my %BaseVal;
$BaseVal{$_} = $_ for 0..9;
$BaseVal{$_} = 10 + ord($_) - ord("A") for "A" .. "Y";

for ( @ARGV )
{
    if ( m/^\d+$/ )
    {
        say toBase($_, $BASE);
    }
    else
    {
        say fromBase($_, $BASE);
    }
}

# Given a decimal number, represent in base 35.
sub toBase($n, $base)
{
    my @answer;
    while ( $n )
    {
        my $dig = $n % $base;
        $n = ($n - $dig) / $base;
        unshift @answer, $dig;
    }

    return join("", map { $BaseDigit[$_] } @answer);
}

sub fromBase($s, $base)
{
    my $place = $base;

    my @digits = ( reverse split("", $s) );
    my $val = $BaseVal{ shift @digits };
    for my $dig ( @digits )
    {
        $val += $BaseVal{$dig} * $place;
        $place *= $base;
    }
    return $val;
}

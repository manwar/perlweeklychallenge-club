#!/usr/bin/env perl
use strict;
use warnings;

my @numbers = ( 2, 4, 3 );

print("numbers: @numbers\n");

my @n = sort @numbers;

my @pair = ();

for my $i (0 .. $#n) {
    for my $j ($i .. $#n) {
        push @pair, [ $n[$i] , $n[$j] ] unless $n[$i] eq $n[$j];
    }
}

my $bit_sum = 0;

for my $pair (@pair) {
    my $binA = sprintf("%032b", $pair->[0]);
    my $binB = sprintf("%032b", $pair->[1]);
    
    my @binA = split '', $binA;
    my @binB = split '', $binB;
    my $diff = 0;

    for my $idx (0.. $#binA) {
        $diff++ if $binA[$idx] != $binB[$idx];
    }

    printf "%s = %s\n%s = %s\n", $binA, $pair->[0], $binB,$pair->[1];
    printf "f(%s, %s) = %s\n\n", $pair->[0], $pair->[1], $diff;
    $bit_sum += $diff;
}

print "bit sum = $bit_sum\n";

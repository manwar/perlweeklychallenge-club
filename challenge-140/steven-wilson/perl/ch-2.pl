#!/usr/bin/env perl
# Week 140 Task 2
# Multiplication Table

use strict;
use warnings;
use feature qw/ say /;
use Lingua::EN::Numbers::Ordinate;

my ( $i, $j, $k ) = @ARGV;
my @rows;

for ( my $y = 1; $y <= $i; $y++ ) {
    my @row;
    for ( my $x = 1; $x <= $j; $x++ ) {

        push @row, ( $x * $y );
    }
    push @rows, \@row;
}

my @multiples;
map { push @multiples, @{$_} } @rows;
my @sorted_multiples = sort @multiples;

say "Input: \$i = $i, \$j = $j, \$k = $k";
say "Output: $sorted_multiples[$k-1]\n";
say "Since the multiplication of $i x $j is as below:\n";
map { say "\t" . join " ", @{$_} } @rows;
say "\nThe sorted multiplication table:\n";
say "\t" . join " ", @sorted_multiples;
say "\nNow the "
    . ordinate($k)
    . " element in the table is \"$sorted_multiples[$k-1]\".";


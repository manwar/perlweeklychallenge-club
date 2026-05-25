#!/usr/bin/env perl

use strict;
use warnings;
use utf8::all;
use feature "say";
use experimental "signatures";

use Array::Utils 'intersect';

sub main ( $str1, $str2 ) {
    # Turn the two strings into arrays
    my @array1 = split /\s+/, $str1;
    my @array2 = split /\s+/, $str2;

    # Compute the frequency of each word in each array
    my ( %freq1, %freq2 );
    $freq1{$_}++ foreach @array1;
    $freq2{$_}++ foreach @array2;

    # Find the unique words in each freq dict
    my @unique1 = grep { $freq1{$_} == 1 } keys %freq1;
    my @unique2 = grep { $freq2{$_} == 1 } keys %freq2;

    # Print the number of items in both list
    say scalar( intersect( @unique1, @unique2 ) );
}

main(@ARGV);

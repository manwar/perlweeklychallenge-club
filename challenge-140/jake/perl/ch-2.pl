#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

###
# You are given 3 positive integers, $i, $j and $k.
# 
# Write a script to print the $kth element in the sorted multiplication table of $i and $j.
# 
# https://theweeklychallenge.org/blog/perl-weekly-challenge-140/#TASK2
###

# get input
print "height: ";
my $height = <STDIN>;
print "width: ";
my $width = <STDIN>;
print "element to display: ";
my $element = <STDIN>;
chomp ( $height, $width, $element );

# sort multiplication table
my @sorted = sort { $a <=> $b } @{aggregate_multiplication_table ( $height, $width )};

# output desired element
say ( $sorted[$element - 1] );

# container sub so main needs to pass only 2 arguments
sub aggregate_multiplication_table {
    my ( $height, $width ) = @_;
    _aggregate_multiplication_table ( $height, $width, 1 );
}

sub _aggregate_multiplication_table {
    my ( $vertical_range, $horizontal_range, $height_increment, $horizontal_values, $all_values ) = @_;

    # once all lines of the table have been written we can return @all_values
    #push @$all_values,;
    return \@$all_values if $height_increment > $vertical_range;

    # we 'write' the first line of the multiplication table.
    # after that we run over each value in this first adding each new value to the accumulator @all_values.
    # we will repeat this for every line that needs to be added to the table.
    @$horizontal_values = 1 ... $horizontal_range;
    foreach ( @$horizontal_values ) {
        push @$all_values, $_ * $height_increment;
    }

    # we need to increase our line counter upon iteration.
    # this is necessary for our foreach loop to add the next line in the following iteration.
    return _aggregate_multiplication_table ( $vertical_range, $horizontal_range, $height_increment + 1, \@$horizontal_values, \@$all_values );
}
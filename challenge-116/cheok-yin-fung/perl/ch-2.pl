#!/usr/bin/perl
# The Weekly Challenge 116
# Task 2 Sum of Squares 
# Usage: ch-2.pl $N
use strict;
use warnings;

my $N = $ARGV[0];

die "Please input an integer larger or equal to 10.\n"
    unless $N =~ /^\d\d+$/;

print is_a_square_num(sum_of_sq($N));
print "\n";



sub sum_of_sq {
    my $num = $_[0];
    my $sum = 0;
    for (split "", $num) {
        $sum += $_*$_;
    }
    return $sum;
}


sub is_a_square_num {
    my $a = sqrt $_[0];
    return ($a !~ /\./ ? 1 : 0) ;
}


# print ("$_: ", is_a_square_num(sum_of_sq($_)),"\n") for (10..99);  #testing line

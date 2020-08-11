#!/usr/bin/env perl6
#
# Perl Weekly Challenge Week 034 task 1: Raku array slice

my @numbers = <10 20 30 40 50 60 70 80 90>;

my ( $first_number, $last_number ) = @numbers[0, *-1];

put "First number in the array is $first_number";

put "Last number in the array is $last_number";
 
put "First 4 numbers in the array are: @numbers[0 .. 3]";


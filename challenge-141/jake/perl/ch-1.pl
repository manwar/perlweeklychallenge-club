#!/usr/bin/env perl

use warnings;
use strict;
use feature 'say';

my $number_attributes = {
    number => '1',
    divisor_counter => '0',
    subtractor => '0',
};
count_divisors( $number_attributes );
# modulo number n through n, n-1, and so on
# for each modulo 0 increase counter
# when counter hits 8 add number to number array, proceed to next number and increase number counter
# if number counter hits 10 output number array or if array size becomes 10

sub count_divisors {
    say ( $number_attributes->{divisor_counter}, $number_attributes->{subtractor}, $number_attributes->{number} );
    while ( $number_attributes->{divisor_counter} < 9 ) {
    say ( $number_attributes->{divisor_counter}, $number_attributes->{subtractor}, $number_attributes->{number} );
        $number_attributes->{divisor_counter}++ if $number_attributes->{number} % ( $number_attributes->{number} - $number_attributes->{subtractor} ) == 0;
        $number_attributes->{subtractor}++;
        print "div_c: $number_attributes->{divisor_counter}, subtr: $number_attributes->{subtractor}\n";
        $number_attributes->{number}++;
        die if $number_attributes->{number} == 10;
    }
}
#!/usr/bin/env perl
# Author: Steven Wilson
# Date: 2019-04-02
# Challenge #2
# Write a script that can convert integers to and from a base35
# representation, using the characters 0-9 and A-Y. Dave Jacoby came up with
# nice description about base35, in case you needed some background.
#
# Usage: ./week2c2 <number> [enc|dec]
# eg:
# $ ./week2c2 13 enc, encodes 13 in base 10 to D in base 35.
# $ ./week2c2 10 dec, decodes 10 in base 35 to 35 in base 10.

use warnings;
use strict;
use feature qw/ say /;

my @digits = qw / 0 1 2 3 4 5 6 7 8 9 A B C D E F G H I J K L M N O P Q
    R S T U V W X Y /;

my ( $number, $operation ) = @ARGV;

if ( $operation eq "enc" ) {
    say "$number encoded in base 35 is ", base35_encode($number);
}
elsif ( $operation eq "dec" ) {
    say "$number decoded from base 35 is ", base35_decode($number);
}

sub base35_encode {
    my $number = shift;
    my @answer;
    while ( $number > 34 ) {
        unshift @answer, $digits[ $number % 35 ];
        $number = $number / 35;
    }
    unshift @answer, $digits[$number];
    return @answer;
}

sub base35_decode {
    my $number          = shift;
    my @number_as_array = split( //, $number );
    my $number_length   = @number_as_array;
    my $answer          = 0;
    my $counter         = 0;
    my $digit_in_base10;
    for ( my $i = $number_length - 1; $i >= 0; $i-- ) {
        ($digit_in_base10)
            = grep { $digits[$_] eq $number_as_array[$counter] } ( 0 .. 34 );
        $answer += $digit_in_base10 * 35**$i;
        $counter++;
    }
    return $answer;
}

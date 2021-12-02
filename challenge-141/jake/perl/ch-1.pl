#!/usr/bin/env perl

use warnings;
use strict;
use feature 'say';

###
# Write a script to find lowest 10 positive integers having exactly 8 divisors
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-141/#TASK1
###

### number attributes
# num specifies the lowest number to start analysis
# div_required specifies how many divisors we're aiming at
# output specifies how many numbers will be displayed
# all of these values can be adjusted as desired
# corner cases that won't comupte correctly: div_required = 0 and div_required = 1
# also odd div_required may run easily into deep recursion because seemingly they tend to be larger numbers
my $num_atr = {
    num => '1',
    div_required => '8',
    output_required => '10'
};

# output
my $res = collect_numbers();
say join (' ', @$res);

# aggregate required amount of numbers according to output_required
sub collect_numbers {
    my @result = ();

    while ( $#result+1 < $num_atr->{output_required} ) {
        push @result, count_divisors( $num_atr, 1 );
        $num_atr->{num}++;
    }
    return \@result;
}

# starting at 1 we aggregate all divisors in an array
# we also aggregate all corresponding reciprocal values in another array
# if these arrays are symmetric to each other at the position of half our's div_required, we know they have the required amount of divisors
# example for even div_required = 8; num = 24; the divisor arrays are cross-symmetric at div_required / 2
# the axis is between $divisors[3] and $reciprocal[4]
#         <==\\==>
# 24 12  8  6\\4  3  2  1
#  1  2  3  4\\6  8 12 24
#         <==\\==>
#
# example for odd div_required = 9; num = 36; the divisor arrays are cross-symmetric at div_required / 2
# the axis is on $divisors[4] and $reciprocal[4]
#          <==\  \==>
# 36 18 12 09 \06\ 04 03 02 01
# 01 02 03 04 \06\ 09 12 18 36 
#          <==\  \==>

sub count_divisors {
    my ( $spec_num, $divisor) = @_;

    # each iteration needs a fresh set of arrays
    my @divisors = ();
    my @reciprocal = ();

    # in case our divisor gets as large as our number, we stop aggregating our arrays
    # because then we have arrived at the largest and smallest divisors
    while ( $num_atr->{num} / $divisor >= 1 ) {
        
        # finding our divisors
        if ( $num_atr->{num} % $divisor == 0 ) {
            push @divisors, $divisor;
            push @reciprocal, ( $num_atr->{num} / $divisor );
        }

        # if div_required is even we look for the axis between array elements
        if ( $num_atr->{div_required} % 2 == 0 ) {
            return $num_atr->{num} if $divisors[$num_atr->{div_required} / 2] && $divisors[$num_atr->{div_required} / 2] == $reciprocal[$num_atr->{div_required} / 2 - 1];
        }

        # if div_required is odd we look for the axis on an array element
        if ( $num_atr->{div_required} % 2 == 1 ) {
            return $num_atr->{num} if $divisors[int($num_atr->{div_required} / 2)]
                                    && $divisors[int($num_atr->{div_required} / 2)] == $reciprocal[int($num_atr->{div_required} / 2)];
        }

        $divisor++;
    }

    # when ever the current num did not meet the required divisors we need to start over counting them for the next num
    # in this case we must not return num to sub collect_numbers
    $num_atr->{num}++;
    return count_divisors( $num_atr, 1 );
}
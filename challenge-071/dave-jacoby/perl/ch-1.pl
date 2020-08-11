#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say signatures state };
no warnings qw{ experimental };

use Carp;
use Getopt::Long;
use JSON;

my $json = JSON->new->space_after;

# a few interesting things before the solving actual
# things

# you are given a number $n where $n > 1
my @array;
my $n = 1;
GetOptions( 'number=i' => \$n, );

# we CANNOT have an array of unique elements, random or no,
# if the desired size is greater than the pool of numbers.
croak 'N needs to be greater than 1' if $n < 1;
croak 'N needs to be less than 50'   if $n > 50;

# write a script that creates an array of size $n
# with random unique elements between 1 and 50
while ( scalar @array < $n ) {
    my $j = 1 + int rand 50;
    push @array, $j unless grep { $j == $_ } @array;
}

# In the end it should print peak elements in the array, if found.
my @peaks = peak_elements(@array);

# I combine print and say to get the output as written in the
# example

print 'Array: ';
say $json->encode( \@array );
print 'Peak:  ';
say $json->encode( \@peaks );

exit;

# a peak element is one that is larger than it's neighbors.
# in abstract, array[i] > array[i-1] && array[i] > array[i+1]
# but this is entirely the base case. Exceptions include:
#   * array size = 1, so it is a peak in and of itself
#   * first element, which only compares against the next element
#   * last element, which only compares against the previous element
# example results are correct, but order is weird. MY solution 
# adds peaks in order they are found.

# for example:
# Array: [35, 12, 48, 22, 6, 21, 46, 1, 23, 31]
# Peak:  [35,     48,            46,        31]

sub peak_elements ( @array ) {
    return @array if scalar @array == 1;
    my @output;

    for my $i ( 0 .. $#array ) {
        if ( $i == 0 ) {
            push @output, $array[$i] if $array[$i] > $array[ $i + 1 ];
        }
        elsif ( $i == $#array ) {
            push @output, $array[$i] if $array[$i] > $array[ $i - 1 ];
        }
        else {
            push @output, $array[$i]
                if $array[$i] > $array[ $i - 1 ]
                && $array[$i] > $array[ $i + 1 ];
        }
    }

    return @output;
}

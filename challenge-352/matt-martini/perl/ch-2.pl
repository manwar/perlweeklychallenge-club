#!/usr/bin/env perl

# You are given an array, @nums, where each element is either 0 or 1.

# Define xi as the number formed by taking the first i+1 bits of @nums
# (from $nums[0] to $nums[i]) and interpreting them as a binary number,
# with $nums[0] being the most significant bit.
# Write a script to return an array @answer where $answer[i] is true
# if x<sub>i</sub> is divisible by 5, otherwise false.

use 5.018;
use strict;
use warnings;
use Test2::V0;

plan tests => 5;

sub binary_prefix {
    my (@num) = @_;
    print 'Input: @num = (' . join( ', ', @num ) . ")\n";

    my @answer = ();

    MODULUS:
    for my $i ( 0 .. $#num ) {
        my $result = 'false';

        my $binary  = join( '', @num[ 0 .. $i ] );
        my $decimal = oct( '0b' . $binary );
        printf( "%12s: %d\n", $binary, $decimal );

        if ( $decimal % 5 == 0 ) {
            $result = 'true';
        }
        push @answer, $result;
    }

    print 'Output: @answer = (' . join( ', ', @answer ) . ")\n";
    return \@answer;
}

is(
    binary_prefix( ( 0, 1, 1, 0, 0, 1, 0, 1, 1, 1 ) ),
    [      'true', 'false', 'false', 'false', 'false', 'true',
           'true', 'false', 'false', 'false'
    ],
    'example 1'
  );
is(
    binary_prefix( ( 1, 0, 1, 0, 1, 0 ) ),
    [ 'false', 'false', 'true', 'true', 'false', 'false' ],
    'example 2'
  );
is(
    binary_prefix( ( 0, 0, 1, 0, 1 ) ),
    [ 'true', 'true', 'false', 'false', 'true' ],
    'example 3'
  );
is(
    binary_prefix( ( 1, 1, 1, 1, 1 ) ),
    [ 'false', 'false', 'false', 'true', 'false' ],
    'example 4'
  );
is(
    binary_prefix( ( 1, 0, 1, 1, 0, 1, 0, 0, 1, 1 ) ),
    [      'false', 'false', 'true',  'false', 'false', 'true',
           'true',  'true',  'false', 'false'
    ],
    'example 5'
  );

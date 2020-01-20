#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use feature qw{ postderef say signatures state switch };
no warnings
  qw{ experimental::postderef experimental::smartmatch experimental::signatures };

use List::Util qw{sum0};

my $instructions = <<'END';
    https://perlweeklychallenge.org/blog/perl-weekly-challenge-043/

    There are 5 rings in the Olympic Logo as shown below. 
    They are color coded as in Blue, Black, Red, Yellow and Green.

        Olympic Rings

    We have allocated some numbers to these rings as below:
    Blue: 8
    Yellow: 7
    Green: 5
    Red: 9

    The Black ring is empty currently. You are given the numbers 
    1, 2, 3, 4 and 6. Write a script to place these numbers in 
    the rings so that the sum of numbers in each ring is exactly 11.
END

my $commentary = <<'END';

    There is one possible solution to this, so it's more a logic puzzle
    than a math puzzle. It is suitable for brute force, however.

    The tools I use here are permutations and sum0. sum returns undef when
    given an empty list, while sum0 returns 0. This shouldn't matter, but
    I'm using sum0.

    Given the array [1,2,3], the values can be rearranged in six unique ways.

        1, 2, 3
        1, 3, 2
        2, 1, 3
        2, 3, 1
        3, 1, 2
        3, 2, 1

    These are the permutations, and permute_array returns an array 
    containing all possible variations, or permutations. 

    In this, the number within both the red and green ring will 
    be called red/green, the number that's only within the black
    ring will be called black, and so on. 

    The generated solution is this:

        red/green:      2
        black/green:    4
        black/yellow:   1
        purple/yellow:  3
        black:          6

END

my $nums = [ 1 .. 4, 6 ];

my @perms = permute_array($nums);

for my $p (@perms) {
    next unless eleven( 9, $p->[0] );             # red
    next unless eleven( 8, $p->[3] );             # purple
    next unless eleven( 5, $p->[0], $p->[1] );    # green
    next unless eleven( 7, $p->[2], $p->[3] );    # green
    next unless eleven( $p->[1], $p->[2], $p->[4] );
    say <<"END";
        red/green:      $p->[0]
        black/green:    $p->[1]
        black/yellow:   $p->[2]
        purple/yellow:  $p->[3]
        black:          $p->[4]
END
}

sub eleven ( @array ) {
    my $r = sum0 @array;
    my $s = $r == 11 ? 1 : 0;
    return $s;
}

sub permute_array ( $array ) {
    return $array if scalar $array->@* == 1;
    my @response = map {
        my $i        = $_;
        my $d        = $array->[$i];
        my $copy->@* = $array->@*;
        splice $copy->@*, $i, 1;
        my @out = map { unshift $_->@*, $d; $_ } permute_array($copy);
        @out
    } 0 .. scalar $array->@* - 1;
    return @response;
}

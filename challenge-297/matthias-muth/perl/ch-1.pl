#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 297 Task 1: Contiguous Array
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub contiguous_array( @binary ) {

    # Use values -1 and +1 instead of binary values 0 and 1.
    # Then, the sum of the values of a 'contiguous' subarray will be zero,
    # because it has an equal number of -1 and +1,

    # That means that whenever a cumulated sum value occurs twice,
    # there is a 'contiguous' subarray, with an equal number of ups and
    # downs, in between.

    # Walking through the array, mark the index of the
    # first occurrence of each sum value in a hash lookup.
    # For every sum value, the difference between its
    # first occurrence and the current index is the length of a
    # 'contiguous' subarray (which can be zero when the sum appears for the first time).
    # Remember the maximum of the length values while iterating.

    # The sum value of zero appears *before* the first number.
    my $sum = 0;
    my %first_appearance = ( 0 => -1 );

    my $max_length = 0;
    for my $index ( keys @binary ) {
        # Add -1 or +1 to the running sum.
        $sum += $binary[$index] == 0 ? -1 : +1;
        $first_appearance{$sum} //= $index;
        my $length = $index - $first_appearance{$sum};
        $max_length = $length
            if $length > $max_length;
    }
    return $max_length;
}

use Test2::V0 qw( -no_srand );

is contiguous_array( 1, 0 ), 2,
    'Example 1: contiguous_array( 1, 0 ) == 2';
is contiguous_array( 0, 1, 0 ), 2,
    'Example 2: contiguous_array( 0, 1, 0 ) == 2';
is contiguous_array( 0, 0, 0, 0, 0 ), 0,
    'Example 3: contiguous_array( 0, 0, 0, 0, 0 ) == 0';
is contiguous_array( 0, 1, 0, 0, 1, 0 ), 4,
    'Example 4: contiguous_array( 0, 1, 0, 0, 1, 0 ) == 4';

done_testing;

__END__
    my %first_appearance;
    my
    my $max_length = 0;
    for my $index ( 0..$#cumulations ) {
        my $sum_value = $cumulations[$index];
        $first_appearance{$sum_value} //= $index;
        my $length = $index - $first_appearance{$sum_value};
        $max_length = $length
            if $length > $max_length;
    }
    return $max_length;

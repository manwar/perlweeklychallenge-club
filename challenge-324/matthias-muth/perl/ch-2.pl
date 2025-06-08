#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 324 Task 2: Total XOR
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use Algorithm::Combinatorics qw( subsets );
use List::Util qw( reduce );

sub total_xor_AC( @ints ) {
    my $sum = 0;
    my $iterator = subsets( \@ints );
    while ( my $subset = $iterator->next ) {
        $sum += reduce { $a ^ $b } 0, $subset->@*;
    }
    return $sum;
}

sub subset_iterator( $ints ) {
    # The number of all possible subsets $n is 2^^(number of elements).
    # Each bit in the subset order number corresponds to an element in the
    # array. If the bit is 1, the element is included in the subset, if it's 0,
    # it isn't.
    # We use $n to count down the subset order numbers from $n minus 1
    # (all elements included) down to 0 (empty subset).
    my $subset_id = 1 << $ints->@*;
    return sub() {
        # Pre-decrement $n, set it to undef once we have *passed* zero
        # (the empty subset will still be delivered).
        # If still defined, create and return the subset, containing exactly
        # those elements whose bits in the current subset order number are set.
        return defined ( $subset_id ? --$subset_id : undef )
            && [ map $subset_id & 1 << $_ ? $ints->[$_] : (), keys $ints->@* ];
    };
}

sub total_xor( @ints ) {
    my $sum = 0;
    my $iterator = subset_iterator( \@ints );
    while ( my $subset = $iterator->() ) {
        $sum += reduce { $a ^ $b } 0, $subset->@*;
    }
    return $sum;
}

use Test2::V0 qw( -no_srand );

is total_xor( 1, 3 ), 6,
    'Example 1: total_xor( 1, 3 ) == 6';
is total_xor( 5, 1, 6 ), 28,
    'Example 2: total_xor( 5, 1, 6 ) == 28';
is total_xor( 3, 4, 5, 6, 7, 8 ), 480,
    'Example 3: total_xor( 3, 4, 5, 6, 7, 8 ) == 480';

done_testing;

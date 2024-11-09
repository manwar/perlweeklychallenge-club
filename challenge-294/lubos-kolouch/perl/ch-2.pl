#!/usr/bin/perl
use strict;
use warnings;

sub next_permutation {
    my @ints = @_;
    my $n    = scalar @ints;

    # Step 1: Find the largest index i such that ints[i] < ints[i + 1]
    my $i = $n - 2;
    while ( $i >= 0 && $ints[$i] >= $ints[ $i + 1 ] ) {
        $i--;
    }

    if ( $i < 0 ) {

        # The given permutation is the last permutation
        # Return the first permutation (sorted array)
        @ints = sort { $a <=> $b } @ints;
        return @ints;
    }

    # Step 2: Find the largest index j > i such that ints[i] < ints[j]
    my $j = $n - 1;
    while ( $ints[$j] <= $ints[$i] ) {
        $j--;
    }

    # Step 3: Swap ints[i] and ints[j]
    ( $ints[$i], $ints[$j] ) = ( $ints[$j], $ints[$i] );

    # Step 4: Reverse the sub-array from ints[i + 1] to the end
    my @suffix = reverse @ints[ $i + 1 .. $n - 1 ];
    splice @ints, $i + 1, $n - ( $i + 1 ), @suffix;

    return @ints;
}

# Test cases
my @test_cases = (
    { ints => [ 1, 2, 3 ], expected => [ 1, 3, 2 ] },
    { ints => [ 2, 1, 3 ], expected => [ 2, 3, 1 ] },
    { ints => [ 3, 1, 2 ], expected => [ 3, 2, 1 ] },
    { ints => [ 3, 2, 1 ], expected => [ 1, 2, 3 ] },    # Last permutation; returns first
    { ints => [ 1, 1, 5 ], expected => [ 1, 5, 1 ] },
    { ints => [ 1, 5, 1 ], expected => [ 5, 1, 1 ] },
);

foreach my $test (@test_cases) {
    my @result = next_permutation( @{ $test->{ints} } );
    print "Input: \@ints = (" . join( ', ', @{ $test->{ints} } ) . ")\n";
    print "Output: (" . join( ', ', @result ) . ")\n";
    print "Expected: (" . join( ', ', @{ $test->{expected} } ) . ")\n";
    print "-" x 40 . "\n";
}

#!/usr/bin/env perl
use strict;
use warnings;

=head1 NAME

ch-2.pl - Perl Weekly Challenge 333, Task 2: Duplicate Zeros

=head1 DESCRIPTION

Given an array of integers, duplicate each occurrence of zero, shifting the
remaining elements to the right. Elements beyond the original array length are
discarded.

=head1 AUTHOR

[Your Name]

=cut

# Type alias for an array of integers
use constant IntArray => 'ARRAY';

sub duplicate_zeros {
    my (@ints) = @_;

    my @result;
    foreach my $num (@ints) {
        if ( $num == 0 ) {

            # Only add two zeros if there's space within original length
            push @result, 0 if @result < @ints;
            push @result, 0 if @result < @ints;
        }
        else {
            # Add non-zero number if there's space
            push @result, $num if @result < @ints;
        }
    }
    return @result;
}

# Unit Tests
use Test::More tests => 5;

subtest 'Example 1' => sub {
    my @ints     = ( 1, 0, 2, 3, 0, 4, 5, 0 );
    my @expected = ( 1, 0, 0, 2, 3, 0, 0, 4 );
    my @result   = duplicate_zeros(@ints);
    diag("Input: (@ints), Output: (@result)");
    is_deeply( [@result], [@expected], 'Array (1,0,2,3,0,4,5,0) becomes (1,0,0,2,3,0,0,4)' );
};

subtest 'Example 2' => sub {
    my @ints     = ( 1, 2, 3 );
    my @expected = ( 1, 2, 3 );
    my @result   = duplicate_zeros(@ints);
    diag("Input: (@ints), Output: (@result)");
    is_deeply( [@result], [@expected], 'Array (1,2,3) remains (1,2,3)' );
};

subtest 'Example 3' => sub {
    my @ints     = ( 1, 2, 3, 0 );
    my @expected = ( 1, 2, 3, 0 );
    my @result   = duplicate_zeros(@ints);
    diag("Input: (@ints), Output: (@result)");
    is_deeply( [@result], [@expected], 'Array (1,2,3,0) remains (1,2,3,0)' );
};

subtest 'Example 4' => sub {
    my @ints     = ( 0, 0, 1, 2 );
    my @expected = ( 0, 0, 0, 0 );
    my @result   = duplicate_zeros(@ints);
    diag("Input: (@ints), Output: (@result)");
    is_deeply( [@result], [@expected], 'Array (0,0,1,2) becomes (0,0,0,0)' );
};

subtest 'Example 5' => sub {
    my @ints     = ( 1, 2, 0, 3, 4 );
    my @expected = ( 1, 2, 0, 0, 3 );
    my @result   = duplicate_zeros(@ints);
    diag("Input: (@ints), Output: (@result)");
    is_deeply( [@result], [@expected], 'Array (1,2,0,3,4) becomes (1,2,0,0,3)' );
};

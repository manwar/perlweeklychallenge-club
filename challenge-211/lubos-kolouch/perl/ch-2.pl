#!/usr/bin/perl
use strict;
use warnings;
use Algorithm::Combinatorics qw(combinations);

sub can_split_with_same_average {
    my ($nums) = @_;
    my $total = 0;
    $total += $_ for @$nums;
    my $n = scalar @$nums;

    for my $i ( 1 .. $n - 1 ) {
        my $combinations = combinations( $nums, $i );
        while ( my $comb = $combinations->next ) {
            my $sum_comb = 0;
            $sum_comb += $_ for @$comb;
            if ( $sum_comb * ( $n - $i ) == ( $total - $sum_comb ) * $i ) {
                return 1;
            }
        }
    }
    return 0;
}

# Test cases
my @nums1 = ( 1, 2, 3, 4, 5, 6, 7, 8 );
my @nums2 = ( 1, 3 );

# Tests
print can_split_with_same_average( \@nums1 ) ? "true\n" : "false\n";
print can_split_with_same_average( \@nums2 ) ? "true\n" : "false\n";

#!/usr/bin/perl
use strict;
use warnings;
use Test::More tests => 4;

=head1 NAME

check_order.pl - Rearrange an array in increasing order and return differing indices

=head1 SYNOPSIS

  perl check_order.pl

=head1 DESCRIPTION

This script defines a function that accepts an array reference of integers.
It sorts the array in increasing order and returns the indices where the sorted array
differs from the original.

=head2 check_order

  my $diff_indices_ref = check_order($ints_ref);

This function takes an array reference of integers and returns an array reference
containing the indices at which the sorted array differs from the original.

=cut

sub check_order {
    my ($ints_ref) = @_;
    my @original   = @$ints_ref;
    my @sorted     = sort { $a <=> $b } @original;
    my @diff_indices;
    for my $i ( 0 .. $#original ) {
        if ( $original[$i] != $sorted[$i] ) {
            push @diff_indices, $i;
        }
    }
    return \@diff_indices;
}

# Unit tests

my $result;

$result = check_order( [ 5, 2, 4, 3, 1 ] );
is_deeply( $result, [ 0, 2, 3, 4 ], 'Test example 1' );

$result = check_order( [ 1, 2, 1, 1, 3 ] );
is_deeply( $result, [ 1, 3 ], 'Test example 2' );

$result = check_order( [ 3, 1, 3, 2, 3 ] );
is_deeply( $result, [ 0, 1, 3 ], 'Test example 3' );

$result = check_order( [ 1, 2, 3, 4, 5 ] );
is_deeply( $result, [], 'Test already sorted' );

done_testing();

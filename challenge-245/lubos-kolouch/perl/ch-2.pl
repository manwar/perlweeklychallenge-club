#!/usr/bin/env perl
use v5.38;
use warnings;
use List::Util qw(sum);
use Type::Params -sigs;
use Types::Standard qw(ArrayRef Int);
use Test::More;

=head1 NAME

ch-2.pl - Largest of Three

=head1 SYNOPSIS

    perl ch-2.pl

=head1 DESCRIPTION

Solution for The Weekly Challenge 245, Task 2: Largest of Three.
Given an array of non-negative integers, returns the largest number formed by
concatenating some of the given integers in any order that is also a multiple
of 3, or C<-1> if none can be formed.

=head1 FUNCTIONS

=head2 largest_multiple_of_three($ints)

Returns the largest number divisible by 3 formed by concatenating a subset of
C<$ints>, or C<-1> if no valid multiple of 3 exists.

=cut

sub _remove_smallest ( $ints_ref, $remainder ) {
    for ( my $i = $#{$ints_ref} ; $i >= 0 ; $i-- ) {
        if ( $ints_ref->[$i] % 3 == $remainder ) {
            splice @{$ints_ref}, $i, 1;
            return 1;
        }
    }
    return 0;
}

signature_for largest_multiple_of_three => (
    method     => 0,
    positional => [ ArrayRef [Int] ],
);

sub largest_multiple_of_three ($ints) {
    my @sorted = sort { ( $b . $a ) cmp( $a . $b ) } @{$ints};
    return -1 if !@sorted;

    my $total = sum(@sorted) // 0;
    if ( $total % 3 == 1 ) {
        _remove_smallest( \@sorted, 1 )
          || ( _remove_smallest( \@sorted, 2 ) && _remove_smallest( \@sorted, 2 ) );
    }
    elsif ( $total % 3 == 2 ) {
        _remove_smallest( \@sorted, 2 )
          || ( _remove_smallest( \@sorted, 1 ) && _remove_smallest( \@sorted, 1 ) );
    }

    return -1 if !@sorted;
    $total = sum(@sorted) // 0;
    return $total % 3 == 0 ? 0 + join( q{}, @sorted ) : -1;
}

is( largest_multiple_of_three( [ 8, 1, 9 ] ),       981,  'Example 1' );
is( largest_multiple_of_three( [ 8, 6, 7, 1, 0 ] ), 8760, 'Example 2' );
is( largest_multiple_of_three( [1] ),               -1,   'Example 3' );
done_testing();

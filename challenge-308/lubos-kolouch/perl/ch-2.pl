#!/usr/bin/env perl
use strict;
use warnings;
use feature 'say';
use Test::More tests => 3;

=pod

=head1 NAME

xor_decode.pl - Task 2: Decode XOR

=head1 DESCRIPTION

This script decodes an original array from an encoded array based on the following encoding:

    encoded[i] = original[i] XOR original[i+1]

Given the encoded array and an initial value (the first element of original),
the original array is restored.

=head1 FUNCTIONS

=head2 decode_xor

    decode_xor($encoded_array_ref, $initial) => $original_array_ref

Decodes the original array from an encoded array reference and an initial value.

=over 4

=item * C<$encoded_array_ref>: Reference to an array of integers (EncodedArray)

=item * C<$initial>: An integer representing the first element of the original array

=back

Returns a reference to the decoded original array.

=head1 TYPEDEFS

=over

=item * EncodedArray - ArrayRef[Integer]

=item * OriginalArray - ArrayRef[Integer]

=back

=cut

sub decode_xor {
    my ( $encoded_ref, $initial ) = @_;

    # Ensure $encoded_ref is an array reference
    die "First argument must be an array reference"
      unless ref $encoded_ref eq 'ARRAY';

    my @original = ($initial);
    for my $enc (@$encoded_ref) {

        # Bitwise XOR operator in Perl is "^"
        push @original, $original[-1] ^ $enc;
    }
    return \@original;
}

# Unit tests

# Example 1:
my $encoded_ref1  = [ 1, 2, 3 ];
my $initial1      = 1;
my $expected_ref1 = [ 1, 0, 2, 1 ];
is_deeply( decode_xor( $encoded_ref1, $initial1 ),
    $expected_ref1, 'Example 1 decode' );

# Example 2:
my $encoded_ref2  = [ 6, 2, 7, 3 ];
my $initial2      = 4;
my $expected_ref2 = [ 4, 2, 0, 7, 4 ];
is_deeply( decode_xor( $encoded_ref2, $initial2 ),
    $expected_ref2, 'Example 2 decode' );

# Test with an empty encoded array:
my $encoded_ref3  = [];
my $initial3      = 10;
my $expected_ref3 = [10];
is_deeply( decode_xor( $encoded_ref3, $initial3 ),
    $expected_ref3, 'Empty encoded decode' );

done_testing();

1;

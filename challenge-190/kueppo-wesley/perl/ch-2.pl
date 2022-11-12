#!/usr/bin/env perl

use strict;
use warnings;
use feature qw(state current_sub);

use Test::More;
use Test::Deep;

=pod

=head1 PROBLEM

Given C<X> and C<Y>, words from different encodings and C<F>, a function
which transliterates the alphabets between these encodings.
The primary issue is that the results of composed alphabets are also alphabets.

So, get all possible C<Y>s from C<X>.

=head1 SOLUTION

A possible solution to this problem can be to parse the encoded
string to build a tree on which a prefix search generates all the
possible C<Y>s.

=cut

sub decode_string {
    my ( $encoded, $decoded ) = @_;

    state @stack;
    state %maps = map { $_ => ( undef, 'A' .. 'Z' )[ $_ ] } 1 .. 26;

    # Mandatory
    $decoded = [] unless defined $decoded;

    foreach my $len ( 1 .. length $encoded ) {
        my ( $alpha, $rest ) = ( substr( $encoded, 0, $len ), substr( $encoded, $len ) );

        # Check if substr of length `$len' is an alphabet in the formal system
        # of the encoded string.
        if ( grep { $_ eq $alpha } keys %maps ) {

            next if length $rest == 1 and not exists $maps{$rest};
            if ( length $rest > 0 ) {

                # Instead of building a tree to later on perform a prefix search
                # on it, stack the values and print the final results when
                # length $rest == 0
                push @stack, $maps{$alpha};
                __SUB__->( $rest, $decoded );
            }
            else {
                push @$decoded, join '', @stack, $maps{$alpha};
            }
        }
    }
    pop @stack;

    return $decoded;
}

my $expected = [
    [ qw( AAAE AAO AKE KAE KO ) ],
    [ qw( AA K ) ],
    [ qw( ABG LG ) ],
];

cmp_deeply(
    [ map { decode_string( $_ ) } qw(1115 11 127) ],
    $expected,
    "Did you decode them correctly?"
);

done_testing( 1 );

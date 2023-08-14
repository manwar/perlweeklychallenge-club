#!/usr/bin/perl

use strict;
use warnings;
use Test::More;

sub decoded_list {
    my ($s) = @_;
    my @results = _decode($s);
    return sort @results;
}

sub _decode {
    my ($s) = @_;
    return ('') if $s eq '';

    my @decodings;

    # Decode one digit
    if ( substr( $s, 0, 1 ) ne '0' ) {
        my $char = chr( substr( $s, 0, 1 ) + ord('A') - 1 );
        for my $sub_decoding ( _decode( substr( $s, 1 ) ) ) {
            push @decodings, $char . $sub_decoding;
        }
    }

    # Decode two digits
    if ( length($s) > 1 && substr( $s, 0, 2 ) <= 26 ) {
        my $char = chr( substr( $s, 0, 2 ) + ord('A') - 1 );
        for my $sub_decoding ( _decode( substr( $s, 2 ) ) ) {
            push @decodings, $char . $sub_decoding;
        }
    }

    return @decodings;
}

is_deeply( [ decoded_list('11') ],   [qw/AA K/],                'Example 1' );
is_deeply( [ decoded_list('1115') ], [qw/AAAE AAO AKE KAE KO/], 'Example 2' );
is_deeply( [ decoded_list('127') ],  [qw/ABG LG/],              'Example 3' );

done_testing();

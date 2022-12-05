#!/usr/bin/env perl

use strict;
use warnings;
use feature qw/ state current_sub /;

use Test::More;

sub find_bins {
    my ( $size, $partial ) = @_;
    state $solution;

    $partial = '', $solution = undef unless defined $partial;
    if ( $size == 0 ) {
        push @$solution, $partial;
    }
    else {
        __SUB__->( $size - 1, '0' . $partial );
        __SUB__->( $size - 1, '1' . $partial );
    }

    return $solution;
}

subtest 'find_bins' => sub {
	is_deeply(find_bins(3), [ qw( 000 100 010 110 001 101 011 111 ) ], "works for 3?");
	is_deeply(find_bins(2), [ qw( 00 10 01 11 ) ], "works for 2?");
	is_deeply(find_bins(1), [ qw( 0 1 ) ], "works for 1?");
};

done_testing(1);

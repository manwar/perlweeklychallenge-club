#!/usr/bin/env perl

use strict;
use warnings;
use experimental 'for_list';
use builtin      'indexed';
no  warnings     'experimental::builtin';

use Test::More;

sub find_index {
	my $string = shift;
	
	for my ( $index, $char ) ( indexed split //, $string ) {
		return ( $index, $char )
			if index( $string, $char ) == rindex( $string, $char );
	}

	return undef;
}

is( find_index( "Perl Perl Perl" ), undef );
is_deeply( [ find_index( "Perl Weekly Challenge" ) ], [ 0,  "P" ] );
is_deeply( [ find_index( "Long Live Perl" ) ],        [ 1,  "o" ] );
is_deeply( [ find_index( "I Love Perl" ) ],           [ 0,  "I" ] );
is_deeply( [ find_index( "This is Hyper Perly" ) ],   [ 0,  "T" ] );


done_testing( 5 );

#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

sub trim_list {
	my $i = pop;
	return grep { $_ > $i } @_;
}

is_deeply( [ trim_list( 1, 4, 2, 3, 5,        3 ) ], [ 4, 5       ] );
is_deeply( [ trim_list( 9, 0, 6, 2, 3, 8, 5,  4 ) ], [ 9, 6, 8, 5 ] );

done_testing( 2 );

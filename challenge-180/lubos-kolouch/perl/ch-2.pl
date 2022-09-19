package main;
use strict;
use warnings;
use Data::Dumper;

sub trim_list {
    my ( $what, $i ) = @_;

    return grep { $_ > $i } @$what;
}

use Test::More;

is( trim_list( [ 1, 2, 3, 4, 5 ], 3 ), 2 );
is( trim_list( [ 9, 0, 6, 2, 3, 8, 5 ], 4 ), 4 );
done_testing;
1;

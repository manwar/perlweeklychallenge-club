package main;
use strict;
use warnings;

sub my_zip {
    my ( $arr1, $arr2 ) = @_;
    my @output;

    for my $pos ( 0 .. scalar @$arr1 - 1 ) {
        push @output, $$arr1[$pos];
        push @output, $$arr2[$pos];
    }

    return \@output;
}

use Test::More;

is_deeply( my_zip( [ 1, 2, 3 ], [ 'a', 'b', 'c' ] ),
    [ 1, 'a', '2', 'b', '3', 'c' ] );
done_testing;

1;

package main;
use strict;
use warnings;

sub split_array {
    my @input = @_;

    my @list09;
    my @listaz;

    for my $item (@input) {

        my @temp09;
        my @tempaz;

        for my $char ( split / /, $item ) {

            push @temp09, $char if $char =~ /\d/;
            push @tempaz, $char if $char =~ /[a-z]/;

            # ignore if there is some other garbage
        }

        push @list09, \@temp09 if @temp09;
        push @listaz, \@tempaz if @tempaz;
    }
    return [ @list09, @listaz ];
}

use Test::More;

is_deeply(
    split_array( ( 'a 1 2 b 0', '3 c 4 d' ) ),
    [ [ 1, 2, 0 ], [ 3, 4 ], [ 'a', 'b' ], [ 'c', 'd' ] ]
);
is_deeply(
    split_array( ( '1 2', 'p q r', 's 3', '4 5 t' ) ),
    [ [ 1, 2 ], [3], [ 4, 5 ], [ 'p', 'q', 'r' ], ['s'], ['t'] ]
);

done_testing;
1;

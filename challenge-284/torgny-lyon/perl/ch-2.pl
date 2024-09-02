#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 3;

sub sort_relative {
    my @list1 = @{ $_[0] };
    my @list2 = @{ $_[1] };
    my @r;
    foreach my $x (@list2) {
        push @r, grep { $x == $_ } @list1;
    }
    return @r, sort grep { my $x = $_; !grep { $x == $_ } @list2 } @list1;
}

is_deeply(
    [
        sort_relative(
            [ 2, 3, 9, 3, 1, 4, 6, 7, 2, 8, 5 ],
            [ 2, 1, 4, 3, 5, 6 ]
        )
    ],
    [ 2, 2, 1, 4, 3, 3, 5, 6, 7, 8, 9 ]
);

is_deeply([ sort_relative([ 3, 3, 4, 6, 2, 4, 2, 1, 3 ], [ 1, 3, 2 ]) ],
    [ 1, 3, 3, 3, 2, 2, 4, 4, 6 ]);

is_deeply([ sort_relative([ 3, 0, 5, 0, 2, 1, 4, 1, 1 ], [ 1, 0, 3, 2 ]) ],
    [ 1, 1, 1, 0, 0, 3, 2, 4, 5 ]);

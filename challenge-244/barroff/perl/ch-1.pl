#!/usr/bin/env perl

use v5.38;

use Data::Dumper;

sub count_smaller (@ints) {
    my @inner_ints = sort(@ints);
    my %positions;
    while ( my ( $i, $v ) = each(@inner_ints) ) {
        $positions{$v} = $i unless exists $positions{$v};
    }
    my @res = @positions{@ints};
    return \@res;
}

sub MAIN() {
    if (@ARGV) {

        #| Run command line arguments
        say @{ count_smaller(@ARGV) };
    }
    else {
        #| Run test cases
        use Test2::V0 qw( is plan );
        plan 3;

        is count_smaller( 8, 1, 2, 2, 3 ), [ 4, 0, 1, 1, 3 ],
          'works for (8, 1, 2, 2, 3)';
        is count_smaller( 6, 5, 4, 8 ), [ 2, 1, 0, 3 ],
          'works for (6, 5, 4, 8)';
        is count_smaller( 2, 2, 2 ), [ 0, 0, 0 ], 'works for (2, 2, 2)';
    }
}

MAIN();

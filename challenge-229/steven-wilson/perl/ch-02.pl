#!/usr/bin/env perl

use 5.12.0;
use List::Util qw/ uniq /;
use Test2::V0;

my @ex1_1 = ( 1, 1, 2, 4 );
my @ex1_2 = ( 2, 4 );
my @ex1_3 = (4);
my @ex2_1 = ( 4, 1 );
my @ex2_2 = ( 2, 4 );
my @ex2_3 = ( 1, 2 );
is( two_out_of_three( \@ex1_1, \@ex1_2, \@ex1_3 ),
    array {
        item 2;
        item 4;
    },
    "Example 1: returns [ 2, 4 ]"
);
is( two_out_of_three( \@ex2_1, \@ex2_2, \@ex2_3 ),
    array {
        item 1;
        item 2;
        item 4;
    },
    "Example 2: returns [ 1, 2, 4 ]"
);
done_testing();

sub two_out_of_three {
    my @arrays = @_;
    my %counts;
    for (@arrays) {
        my @uniq = uniq @{$_};
        map { $counts{$_}++ } @uniq;
    }
    my @two_out_of_three
        = sort { $a <=> $b } grep { $counts{$_} > 1 } keys %counts;
    return \@two_out_of_three;
}

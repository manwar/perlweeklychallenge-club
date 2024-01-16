# The Weekly Challenge 251
# Task 2 Lucky Number
use v5.30.0;
use warnings;
use List::Util qw/min max first/;

sub ln {
    my $matrix = $_[0];
    my @rows = $matrix->@*;
    for my $r (@rows) {
        my $min = min $r->@*;
        my $min_loc = first {$min == $r->[$_]} 0..$r->$#*;
        my @carr = map {$_->[$min_loc]} @rows;
        return $min if $min == max @carr;
    }
    return -1;
}



use Test2::V0;
is ln([ [ 3,  7,  8],
        [ 9, 11, 13],
        [15, 16, 17] ]), 15;

is ln([ [ 1, 10,  4,  2],
        [ 9,  3,  8,  7],
        [15, 16, 17, 12] ]), 12;

is ln([[7,8],[1,2]]),7;
done_testing;

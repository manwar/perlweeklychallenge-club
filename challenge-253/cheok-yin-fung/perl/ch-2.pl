# The Weekly Challenge 253
# Task 2 Weakest Row
use v5.30.0;
use warnings;

sub wr {
    my $matrix = $_[0];
    my @rows = $matrix->@*;
    my @weight = map {scalar grep {$_} $_->@*} @rows;
    my @ord = sort {$weight[$a] <=> $weight[$b] || $a<=>$b} 0..$#rows;
    return [@ord];
}

use Test2::V0;
is wr([
                   [1, 1, 0, 0, 0],
                   [1, 1, 1, 1, 0],
                   [1, 0, 0, 0, 0],
                   [1, 1, 0, 0, 0],
                   [1, 1, 1, 1, 1]
                 ]
), [2,0,3,1,4];

is wr([
                   [1, 0, 0, 0],
                   [1, 1, 1, 1],
                   [1, 0, 0, 0],
                   [1, 0, 0, 0]
                 ]
), [0,2,3,1];
done_testing();

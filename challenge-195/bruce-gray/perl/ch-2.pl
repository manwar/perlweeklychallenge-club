use v5.36;
use List::Util    qw<min>;
use List::UtilsBy qw<max_by>;

sub task2 (@ns) {
    my %bag;
    $bag{$_}++ for grep { $_ % 2 == 0 } @ns;
    return -1 if not %bag;

    return min max_by { $bag{$_} } keys %bag;
}


my @tests = (
    [ [1,1,2,6,2],  2 ], # Of 2 and 6, 2 appears the most.
    [ [1,3,5,7  ], -1 ], # No even numbers
    [ [6,4,4,6,1],  4 ], # Of 4 and 6, both appear twice, so pick 4 (the smallest).
    
    [ [2,4,4,6,6],  4 ], # Make sure min of evens does not impact min of max-group
);
use Test::More;
plan tests => 0+@tests;
for (@tests) {
    my ($in, $expected) = @{$_};
    is task2(@{$in}), $expected, "task2(@{$in}) == $expected";
}

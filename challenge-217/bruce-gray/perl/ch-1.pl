use v5.36;

sub task1 ( $m ) {
    my ( $first, $second, $third, @rest )
        = sort { $a <=> $b } map { $_->@* } @{$m};

    return $third;
}


my @tests = (
    [ 1, [ [3, 1, 2], [5, 2, 4], [0, 1, 3] ] ],
    [ 4, [ [2, 1   ], [4, 5   ]            ] ],
    [ 0, [ [1, 0, 3], [0, 0, 0], [1, 2, 1] ] ],
);
use Test::More;
plan tests => 0+@tests;
for (@tests) {
    my ( $expected, $in ) = @{$_};
    is task1($in), $expected;
}

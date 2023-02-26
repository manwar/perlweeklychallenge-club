use v5.36;
use List::Util qw<uniq>;
sub task1 ( $ns ) {
    my ( $x1, $x2, $x3 ) = sort { $b <=> $a } uniq @{$ns};
    return $x3 // $x1;
}


my @tests = (
    [ [ 5, 3, 4    ], 3 ], #  5 4 3
    [ [ 5, 6       ], 6 ], #  6 5 * Third highest is missing, so maximum is returned.
    [ [ 5, 4, 4, 3 ], 3 ], #  5 4 3 (Aha! ties!)
);
use Test::More;
plan tests => 0+@tests;
is task1($_->[0]), $_->[1] for @tests;

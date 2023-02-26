use v5.36;
use ntheory    qw<forcomb>;
use List::Util qq<max>;

# See my Raku solution for a faster algorithm.
sub task2 ( @ns ) {
    my $r = 0;

    forcomb {
        $r = max( $r, $ns[$_[0]] ^ $ns[$_[1]] );
    } @ns, 2;

    return $r;
}


my @tests = (
    [ [  1, 2, 3,  4, 5, 6, 7 ],     7 ], #  1 xor 6 =  7
    [ [  2, 4, 1,  3          ],     7 ], #  4 xor 3 =  7
    [ [ 10, 5, 7, 12, 8       ],    15 ], # 10 xor 5 = 15
);
use Test::More;
plan tests => 0+@tests;
is task2(@{$_->[0]}), $_->[1] for @tests;

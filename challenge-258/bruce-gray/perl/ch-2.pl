use v5.36;
use List::Util qw<sum>;

sub pop_count ($n) { sprintf( '%b', $n ) =~ tr/1// }

sub task2 ( $k, @ns ) {
    my @wanted_keys = grep { pop_count($_) == $k } keys @ns;

    return sum @ns[ @wanted_keys ];
}


my @tests = (
    [ 17, 1, [2, 5, 9, 11, 3] ],
    [ 11, 2, [2, 5, 9, 11, 3] ],
    [  2, 0, [2, 5, 9, 11, 3] ],
);
use Test::More; plan tests => 0+@tests;
for (@tests) {
    my ($expected, $in_k, $in_ints) = @{$_};
    is task2($in_k, @{$in_ints}), $expected;
}

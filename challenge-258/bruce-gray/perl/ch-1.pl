use v5.36;
sub task1 ( @ns ) {
    return 0+grep { length(abs $_) % 2 == 0 } @ns;
}


my @tests = (
    [ 3, [  10, 1,   111,  24, 1000 ] ],
    [ 0, [ 111, 1, 11111            ] ],
    [ 1, [   2, 8,  1024, 256       ] ],
);
use Test::More; plan tests => 0+@tests;
for (@tests) {
    my ($expected, $in) = @{$_};
    is task1(@{$in}), $expected;
}

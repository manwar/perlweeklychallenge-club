use v5.36;
use List::Util qw<uniq>;

sub task1 ( $n ) {
    return 0 + grep { length == uniq split '' } 1..$n;
}


my @tests = (
    [ 15, 14 ],
    [ 35, 32 ],

    [            99,        90 ],
    [           200,       162 ],
    [           180,       147 ],
    [         1_000,       738 ],
    [        10_000,     5_274 ],
    [       100_000,    32_490 ],
    [     1_000_000,   168_570 ],
#    [    10_000_000,   712_890 ],
#    [   100_000_000, 2_345_850 ],
#    [ 1_000_000_000, 5_611_770 ],
#    [ 9_876_543_210, 8_877_690 ],
);
use Test::More;
plan tests => 0+@tests;
for (@tests) {
    my ($in, $expected) = @{$_};
    is task1($in), $expected, "task1($in) == $expected";
}

use v5.36;
use Inline 'C';
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
    [    10_000_000,   712_890 ],
    [   100_000_000, 2_345_850 ],
    [ 1_000_000_000, 5_611_770 ],
    [ 9_876_543_210, 8_877_690 ],
);
use Test::More;
plan tests => 0+@tests;
for (@tests) {
    my ($in, $expected) = @{$_};
    is count_special($in), $expected, "count_special($in) == $expected";
}
__END__
__C__
int is_special(long x) {
    int ds[10];
    memset(ds, 0, 10*sizeof(int));
    while (x) {
        if (ds[x % 10]++)
            return 0;
        x /= 10;
    }
    return 1;
}
int count_special(long in) {
    long x = in > 9876543210 ? 9876543210 : in;
    int  r = 0;
    for ( ; x ; x-- ) {
        if ( is_special(x) )
            r++;
    }
    return r;
}

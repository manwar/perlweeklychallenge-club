sub task2 { [~] roundrobin :slip, ($^a, $^b)».comb }

sub task2_before_slip_in_roundrobin_2022_02 ( Str $a, Str $b --> Str ) {
    my @a = $a.comb;
    my @b = $b.comb;

    @a.append: '' xx (@b - @a);
    @b.append: '' xx (@a - @b);

    return [~] @a Z~ @b;
}


use Test; plan +my @tests =
    <abcd  1234  a1b2c3d4>,
    <abc   12345 a1b2c345>,
    <abcde 123   a1b2c3de>,
;
for @tests -> ( $in1, $in2, $expected ) {
    is task2($in1, $in2), $expected;
}

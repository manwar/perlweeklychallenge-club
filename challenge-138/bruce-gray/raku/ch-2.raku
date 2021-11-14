sub can-partition-to-square ( Int $r --> Bool ) {
    # Regex exponential exhaustion FTW! (See blog post)
    return $r ∈ ($r²).match(:ex, /^(.+)+$/).map( *.[0].sum );
}

sub can-partition-to-sqrt ( Int $n --> Bool ) {
    my Int $r = $n.sqrt.narrow;             # `Int` will catch non-perfect-squares
    return can-partition-to-square($r);
}

use Test;
my @tests =
    # From examples in task description:
    81   => True,
    9801 => True,
    36   => False,

    # Regression tests
    72² => False,
    36² => True, # 36² == 1296,  1+29+6 == 36. Finds single-sided insufficient algorithms.
    165607² => False,

    # From the far edge of https://oeis.org/A038206/b038206.txt :
    1028956743² => False,
    1028956744² => True,
    1028956745² => False,
;

constant $use_long_tests = True;
plan @tests + (2 if $use_long_tests);

for @tests -> ( :key($input), :value($expected) ) {
    is can-partition-to-sqrt($input), $expected,
      "can-partition-to-sqrt({$input.fmt('%4d')}) == $expected";
}

if $use_long_tests {
    # The squares for which can-partition-to-sqrt returns True are an OEIS sequence.
    # The square-roots of those squares are also an OEIS sequence.
    # Test all the elements given on the OEIS web pages. (49 elements, and 35 elements).
    constant @A038206 = 0, 1, 9, 10, 36, 45, 55, 82, 91, 99, 100, 235, 297, 369, 370, 379, 414, 657, 675, 703, 756, 792, 909, 918, 945, 964, 990, 991, 999, 1000, 1296, 1702, 1782, 2223, 2728, 3366, 3646, 3682, 4132, 4879, 4906, 4950, 5050, 5149, 5292, 6832, 7191, 7272, 7389;
    constant @A104113 =	0, 1, 81, 100, 1296, 2025, 3025, 6724, 8281, 9801, 10000, 55225, 88209, 136161, 136900, 143641, 171396, 431649, 455625, 494209, 571536, 627264, 826281, 842724, 893025, 929296, 980100, 982081, 998001, 1000000, 1679616, 2896804, 3175524, 4941729, 7441984;

    my @got = grep { can-partition-to-sqrt $_² }, ^Inf;

    is-deeply @got.head(+@A038206),    @A038206, 'Exact match of https://oeis.org/A038206';
    is-deeply @got.head(+@A104113)».², @A104113, 'Exact match of https://oeis.org/A104113';
}

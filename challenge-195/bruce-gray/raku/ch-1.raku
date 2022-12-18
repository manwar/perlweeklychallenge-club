# https://oeis.org/A073531  Number of n-digit positive integers with all digits distinct.
constant @n-digits-distinct     = 0, 9, |( 9 X* [\*] (9...1) );
constant @n-digits-distinct-sum = [\+] @n-digits-distinct;

# See blog post for explanation.
sub task1 ( UInt $n --> UInt ) {
    constant MAX = 9_876_543_210;
    return &?ROUTINE(MAX) if $n > MAX;

    # Knuth's "falling powers"; kfp(9,3) == 9*8*7
    sub kfp ($n, $k) { [*] ( ($n-$k) ^.. $n ) }

    my $nc = $n.chars;
    my @totals;

    push @totals, @n-digits-distinct-sum[$nc - 1];

    my SetHash $used;
    for $n.comb».Numeric.kv -> UInt $k, UInt $digit {

        my UInt $combinations_in_rightward_places = kfp(9 - $k, $nc - $k - 1);

        my Range $space_below_digit = (      0 + (1 if $k == 0   ) )
                                   .. ( $digit - (1 if $k < $nc-1) );

        my Set $using_for_this_digit = $space_below_digit (-) $used;

        push @totals, $using_for_this_digit.elems
                    * $combinations_in_rightward_places;

        $used{$digit}++;
    }

    return @totals.sum;
}
# This version is simpler to understand, but does not perform as well.
# It does the initial optimization to skip over about .log10 places,
# then generates all the combinations with the correct leading digit,
# filters on which ones are less than $n.
sub task1_one_big_skip ( UInt $n --> UInt ) {
    constant MAX = 9_876_543_210;
    return &?ROUTINE(MAX) if $n > MAX;

    my @totals;
    my $lead  = $n.substr(0, 1);
    my $core  = $n.chars - 1;

    push @totals, @n-digits-distinct-sum[$core];

    push @totals, +combinations(9,$core) * ([*] 1..$core) * ($lead-1);

    my $L3 = 0;
    for (0..9).grep(* != $lead).combinations($core) -> @comb {
        $L3 += +@comb.permutations.grep: { ($lead ~ .join) <= $n };
    }
    push @totals, $L3;
    return @totals.sum;
}


my @tests =
    ( 15, 14 ),
    ( 35, 32 ),

    (            99,        90 ),
    (           200,       162 ),
    (           180,       147 ),
    (         1_000,       738 ),
    (        10_000,     5_274 ),
    (       100_000,    32_490 ),
    (     1_000_000,   168_570 ),
    (    10_000_000,   712_890 ),
    (   100_000_000, 2_345_850 ),
    ( 1_000_000_000, 5_611_770 ),
    ( 9_876_543_210, 8_877_690 ),
;
use Test;
plan 1+@tests;

is (map &task1, 1..99),
   (flat (1..10,10..20,20..30,30..40,40..50,50..60,60..70,70..80,80..90,90)),
   "First 99";

for @tests -> ($in, $expected) {
    my $got = task1($in);

    is $got, $expected, "task1($in) == $expected";
}

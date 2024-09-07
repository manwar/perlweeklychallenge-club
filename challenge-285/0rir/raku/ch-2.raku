#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
285-2: Making Change       Submitted by: David Ferrone

Compute the number of ways to make change for given amount in cents. By using the coins e.g. Penny, Nickel, Dime, Quarter and Half-dollar, in how many distinct ways can the total value equal to the given amount? Order of coin selection does not matter.

A penny (P) is equal to 1 cent.
A nickel (N) is equal to 5 cents.
A dime (D) is equal to 10 cents.
A quarter (Q) is equal to 25 cents.
A half-dollar (HD) is equal to 50 cents.
Example 1
Input: $amount = 9
Output: 2

1: 9P
2: N + 4P
Example 2
Input: $amount = 15
Output: 6

1: D + 5P
2: D + N
3: 3N
4: 2N + 5P
5: N + 10P
6: 15P
Example 3
Input: $amount = 100
Output: 292

=end comment

my @Test =
    0,0,                $(1..4),1,          $(5..9),2,
   #$(10..14),4,        $(15..19),6,        $(20..24),9,
    $(25..29),13,       $(30..34),18,       $(35..39),24,
   #$(40..43),31,       $(45..47),39,       $(50..51),50,
    $(55),62,           $(60),77,           $(69),93,
   #$(70),112,          $(75),134,          $(84),159,
    $(85),187,          $(90),218,          $(99),252,
   #$(100),292,         $(105),335,         $(111),384,
   #$(120),494,         $(130),628,         $(141),786,
   #$(150),972,         $(160),1190,       $(171),1440,
   #$(180),1730, $(190),2060,
    201,2435,
   #211,2860,
   #300,9590,
   #504,59576,
;
plan 32;

constant \P = 1;
constant \N = 5;
constant \D = 10;
constant \Q = 25;
constant \H = 50;

multi task( UInt:D $n is copy --> UInt) {
    return 0 if $n == 0;
    return 1 if $n < 5;
    $n -= $n % 5;                      # odd P change doesn't matter
    my @P = 0,  5,  10 … $n;           # P must be subbed as batch
    my @N = 0,  5,  10 … $n;
    my @D = 0, 10,  20 … $n - $n % D;
    my @Q = 0, 25,  50 … $n - $n % Q;
    my @H = 0, 50, 100 … $n - $n % H;
    my $ret;
    for @H -> \h {
        for @Q -> \qu    {             # avoid q quoting construct
            for @D -> \d {
                for @N -> \n {
                    for @P -> \p {
                        if $n == sum p, n, d, qu, h {
                            ++ $ret;
                            last;
    }   }   }   }   }   }
    return $ret;
}

for @Test -> $in, $exp {
    for @$in -> \n {
        my $a = task( n);
        is $a, $exp, "$exp <- { n }";
    }
}

done-testing;

my $amount = 180;
say "\nInput: \$amount = $amount\nOutput: { task $amount }";

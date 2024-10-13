#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
290-2: Luhn’s Algorithm         Submitted by: Andrezgz
You are given a string $str containing digits (and possibly other characters
which can be ignored). The last digit is the payload; consider it separately.
Counting from the right, double the value of the first, third, etc. of
the remaining digits.

For each value now greater than 9, sum its digits.

The correct check digit is that which, added to the sum of all values, would bring the total mod 10 to zero.

Return true if and only if the payload is equal to the correct check digit.

It was originally posted on reddit.

Example 1
Input: "17893729974"
Output: true

Payload is 4.

Digits from the right:

7 * 2 = 14, sum = 5
9 = 9
9 * 2 = 18, sum = 9
2 = 2
7 * 2 = 14, sum = 5
3 = 3
9 * 2 = 18, sum = 9
8 = 8
7 * 2 = 14, sum = 5
1 = 1

Sum of all values = 56, so 4 must be added to bring the total mod 10 to zero. The payload is indeed 4.
Example 2
Input: "4137 8947 1175 5904"
Output: true
Example 3
Input: "4137 8974 1175 5904"
Output: false

Input: "17893729974"
Output: true

Payload is 4.

Digits from the right:

7 * 2 = 14, sum = 5
9 = 9
9 * 2 = 18, sum = 9
2 = 2
7 * 2 = 14, sum = 5
3 = 3
9 * 2 = 18, sum = 9
8 = 8
7 * 2 = 14, sum = 5
1 = 1

Sum of all values = 56, so 4 must be added to bring the total mod 10 to
zero. The payload is indeed 4.
Example 2
Input: "4137 8947 1175 5904"
Output: true
Example 3
Input: "4137 8974 1175 5904"
Output: false

=end comment

my @Test =
    "17893729974",              True,
    "4137 8947 1175 5904",      True,
    "4137 8974 1175 5904",      False,
    "4137lew8a9741175HBI5904",  False,
;
plan @Test ÷ 2;

# Without validation that the last char is a \d.
sub task( Str $in --> Bool) {
say $in;
    my @ary = $in.flip.comb.grep( /<:Nd>/);
    my $load = @ary.shift;
say @ary;
say "load: ", $load;
    return Int unless @ary;

    my $mult;
    my $sum = [+] do for @ary <-> $e {
        $mult = not $mult;
        if $mult {
            $e ×= 2;
        }
        $e = $e < 10 ?? $e !! $e.comb.sum;
    }
    return True if $load == 10 - ($sum % 10);
    False;
}

say task(  "17893729974" );


for @Test -> $in, $exp {
    is task($in), $exp, "$exp <- $in";
}

done-testing;




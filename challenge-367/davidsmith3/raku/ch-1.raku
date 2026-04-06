#! /usr/bin/env raku

=begin pod
=TITLE
=head2 Task 1 Max Odd Binary
Submitted by: Mohammad Sajid Anwar
=CHALLENGE
You are given a binary string that has at least one ‘1’.

Write a script to rearrange the bits in such a way that the resulting binary number is the maximum odd binary number and return the resulting binary string. The resulting string can have leading zeros.

=head3 Example 1:
Input: $str = "1011"
Output: "1101"

"1101" is max odd binary (13).

=head3 Example 2:
Input: $str = "100"
Output: "001"

"001" is max odd binary (1).

=head3 Example 3:
Input: $str = "111000"
Output: "110001"

=head3 Example 4:
Input: $str = "0101"
Output: "1001"

=head3 Example 5:
Input: $str = "1111"
Output: "1111"

=end pod

multi my-sub(Str:D $str where * ~~ / ^ [0|1]* 1 [0|1]* $ / -->Str) {
    my $ones = $str.comb.grep(/ 1 /).elems;
    "1" x ($ones - 1) ~ "0" x ($str.chars - $ones) ~ "1";
}

multi my-sub(Str:D $str  -->Str) {
    die "Unexpected input, received $str";
}

multi MAIN(Str:D $str) {
    say my-sub($str);
}

multi MAIN(Bool:D :$test) {
    use Test;

    my @tests = extract-tests;
    plan +@tests;
    for @tests {
        is my-sub(|.<input>), .<output>, "{.<input>}";
    }
}

sub extract-tests(-->Array[Hash]) {
    my Hash @tests;
    my $string = / '"' <-["]>* '"' /;
    for $=pod -> $pod-item {
        for $pod-item.contents -> $pod-block {
            next unless $pod-block ~~ Pod::Heading && $pod-block.level == 3;
            my $text = $pod-block.contents[0].contents.join;
            if $text ~~ / ($string) .* ($string) / {
                @tests.push(%{ input => $0.EVAL, output => $1.EVAL });
            }
        }
    }
    @tests;
}

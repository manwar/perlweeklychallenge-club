#! /usr/bin/env raku

=begin pod
=TITLE
=head2 Challenge 368 Task 1 Make it Bigger
Submitted by: Mohammad Sajid Anwar
=CHALLENGE
You are given a given a string number and a character digit.

Write a script to remove exactly one occurrence of the given character digit from the given string number, resulting the decimal form is maximised.
=head3 Example 1:
Input: $str = "15456", $char = "5"
Output: "1546"

Removing the second "5" is better because the digit following it (6) is
greater than 5. In the first case, 5 was followed by 4 (a decrease),
which makes the resulting number smaller.
=head3 Example 2:
Input: $str = "7332", $char = "3"
Output: "732"
=head3 Example 3:
Input: $str = "2231", $char = "2"
Output: "231"

Removing either "2" results in the same string here. By removing a "2",
we allow the "3" to move up into a higher decimal place.
=head3 Example 4:
Input: $str = "543251", $char = "5"
Output: "54321"

If we remove the first "5", the number starts with 4. If we remove the
second "5", the number still starts with 5. Keeping the largest possible
digit in the highest place value is almost always the priority.
=head3 Example 5:
Input: $str = "1921", $char = "1"
Output: "921"
=end pod

subset Digits of Str where * ~~ / ^ \d+ $ /;
subset Digit of Str where * ~~ / ^ \d $ /;

sub my-sub(Digits $str, Digit $char -->Str) {
    die "$char cannot equal $str" if $str eq $char;
    my $num-matches = $str.comb(/ ($char) /).elems;
    die "$char must appear within $str" if $num-matches == 0;
    (1..$num-matches).map({ +$str.subst($char, "", :nth($_)) }).max.Str;
}


multi MAIN(Str:D $str, Str:D $char) {
    say my-sub($str, $char);
}

multi MAIN(Bool:D :$test) {
    use Test;

    my @tests = extract-tests;
    @tests.push(%{ input => ("22", "2"), output => "2"});
    @tests.push(%{ input => ("123", "2"), output => "13"});

    my @should-throw;
    @should-throw.push(%{ input => ("foo", "2") });
    @should-throw.push(%{ input => ("123", "20") });
    @should-throw.push(%{ input => ("123", "4") });
    @should-throw.push(%{ input => ("2", "2") });

    plan @tests + @should-throw;
    for @tests {
        is my-sub(|.<input>), .<output>, "{.<input>}";
    }
    for @should-throw {
        dies-ok { my-sub(|.<input>) }, "dies on {.<input>}";
    }
}

sub extract-tests(-->Array[Hash]) {
    my Hash @tests;
    my $string = / '"' <-["]>* '"' /;
    for $=pod -> $pod-item {
        for $pod-item.contents -> $pod-block {
            next unless $pod-block ~~ Pod::Heading && $pod-block.level == 3;
            my $text = $pod-block.contents[0].contents.join;
            if $text ~~ / ($string) .* ($string) .* ($string)  / {
                @tests.push(%{ input => ($0.EVAL, $1.EVAL), output => $2.EVAL });
            }
        }
    }
    @tests;
}

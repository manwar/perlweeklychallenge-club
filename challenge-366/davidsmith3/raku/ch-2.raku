#! /usr/bin/env raku

=begin pod
=TITLE
=head2 Task 1 Alphabet Index Digit Sum
Submitted by: Mohammad Sajid Anwar
=CHALLENGE
You are given a time in the form ‘HH:MM’. The earliest possible time is ‘00:00’ and the latest possible time is ‘23:59’. In the string time, the digits represented by the ‘?’ symbol are unknown, and must be replaced with a digit from 0 to 9.

Write a script to return the count different ways we can make it a valid time.

=head3 Example 1:
Input: $time = "?2:34"
Output: 3

0 -> "02:34" valid
1 -> "12:34" valid
2 -> "22:34" valid

=head3 Example 2:
Input: $time = "?4:?0"
Output: 12

Hours: tens digit ?, ones digit 4 -> can be 04, and 14 (2 possibilities)
Minutes: tens digit ?, ones digit 0 -> tens can be 0-5 (6 possibilities)

Total: 2 × 6 = 12

=head3 Example 3:
Input: $time = "??:??"
Output: 1440

Hours: from 00 to 23 -> 24 possibilities
Minutes: from 00 to 59 -> 60 possibilities

Total: 24 × 60 = 1440

=head3 Example 4:
Input: $time = "?3:45"
Output: 3

If tens digit is 0 or 1 -> any ones digit works, so 03 and 13 are valid
If tens digit is 2 -> ones digit must be 0-3, but here ones digit is 3, so 23 is valid

Therefore: 0,1,2 are all valid -> 3 possibilities

=head3 Example 5:
Input: $time = "2?:15"
Output: 4

Tens digit is 2, so hours can be 20-23
Ones digit can be 0,1,2,3 (4 possibilities)

Therefore: 4 valid times

=end pod

constant HOURS = (0 .. 23).map({ sprintf '%02s', $_ }).List;
constant MINUTES = (0 .. 59).map({ sprintf '%02s', $_ }).List;

subset Time of Str where * ~~ / [\d | '?'] ** 2 ':' [\d | '?'] ** 2 /;

multi my-sub(Time $time -->Int) {
    my ($h, $m) = $time.comb(/ [\d | '?'] ** 2 /).map(*.subst(:g, '?', '\d'));
    HOURS.grep(/ <$h> /).elems * MINUTES.grep(/ <$m> /).elems;
}

multi my-sub(Str:D $time) {
    die "Unexpected input.  Got $time.";
}

multi MAIN(Str:D $time) {
    say my-sub($time);
}

multi MAIN(Bool:D :$test) {
    use Test;

    my @tests = extract-tests;
    plan +@tests;
    for @tests {
        is my-sub( |.<input> ), .<output>, "{.<input>}";
    }
}

sub extract-tests(-->Array[Hash]) {
    my Hash @tests;
    my $string = / '"' .* '"' /;
    my $int = / \d+ /;
    for $=pod -> $pod-item {
        for $pod-item.contents -> $pod-block {
            next unless $pod-block ~~ Pod::Heading && $pod-block.level == 3;
            my $text = $pod-block.contents[0].contents.join;
            if $text ~~ / ($string) .*? ($int) / {
                @tests.push(%{ input => ($0.EVAL), output => +$1 });
            }
        }
    }
    @tests;
}

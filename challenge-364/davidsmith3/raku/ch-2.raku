#! /usr/bin/env raku

=begin pod
=TITLE
=head2 Task 2 Goal Parser
Submitted by: Mohammad Sajid Anwar
You are given a string, $str.

Write a script to interpret the given string using Goal Parser.

The Goal Parser interprets “G” as the string “G”, “()” as the string “o”, and “(al)” as the string “al”. The interpreted strings are then concatenated in the original order.

=CHALLENGE
=head3 Example 1:
Input: $str = "G()(al)"
Output: "Goal"

G    -> "G"
()   -> "o"
(al) -> "al"

=head3 Example 2:
Input: $str = "G()()()()(al)"
Output: "Gooooal"

G       -> "G"
four () -> "oooo"
(al)    -> "al"

=head3 Example 3:
Input: $str = "(al)G(al)()()"
Output: "alGaloo"

(al) -> "al"
G    -> "G"
(al) -> "al"
()   -> "o"
()   -> "o"

=head3 Example 4:
Input: $str = "()G()G"
Output: "oGoG"

() -> "o"
G  -> "G"
() -> "o"
G  -> "G"

=head3 Example 5:
Input: $str = "(al)(al)G()()"
Output: "alalGoo"

(al) -> "al"
(al) -> "al"
G    -> "G"
()   -> "o"
()   -> "o"

=end pod

constant %MAP = '()' => 'o', '(al)' => 'al', 'G' => 'G';

sub my-sub(Str:D $s -->Str) {
    $s.subst(/ @(%MAP.keys) /, { %MAP{$/} }, :g);
}

multi MAIN(Str:D $cipher-text) {
    say my-sub($cipher-text);
}

multi MAIN(Bool:D :$test) {
    use Test;

    my @tests = extract-tests;
    plan +@tests;
    for @tests {
        is my-sub( .<input> ), .<output>, "{.<input>}";
    }
}

sub extract-tests(-->Array[Hash]) {
    my Hash @tests;
    my $string = rx/ \".*\" /;
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

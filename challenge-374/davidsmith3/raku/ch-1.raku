#! /usr/bin/env raku

=begin pod
=TITLE PWC
=head2 Challenge 374 Task 1
Submitted by: Mohammad Sajid Anwar
=CHALLENGE
You are given a string.

Write a script to return all possible vowel substrings in the given string. A vowel substring is a substring that only consists of vowels and has all five vowels present in it.

=head3 Example 1:
Input: $str = "aeiou"
Output: ("aeiou",)

=head3 Example 2:
Input: $str = "aaeeeiioouu"
Output: ("aaeeeiioou", "aaeeeiioouu", "aeeeiioou", "aeeeiioouu")

NOTE: Updated output [2025-05-18]

=head3 Example 3:
Input: $str = "aeiouuaxaeiou"
Output: ("aeiou", "aeiou", "eiouua", "aeiouu", "aeiouua")

NOTE: Updated output [2025-05-18]

=head3 Example 4:
Input: $str = "uaeiou"
Output: ("aeiou", "uaeio", "uaeiou")

=head3 Example 5:
Input: $str = "aeioaeioa"
Output: ()

=end pod

my constant @VOWELS = <a e i o u>;

sub count-vowel(Str:D $str --> Seq) {
    my @candidates = $str.lc.comb(/ @VOWELS+ /).grep(*.chars >= @VOWELS); # remove non-vowels and runs that are too short to contain all vowels
    gather {
        for @candidates -> $c {                                           # for every candidate search all possible substrings
            for ^($c.chars - 1) -> $start {
                last if $c.substr($start).comb.unique.elems < @VOWELS;    # short circuit when current substring cannot yield a result
                for ($start + 1)..^$c.chars -> $end {
                    my $curr = $c.substr($start..$end);
                    take $curr if $curr.comb.unique.elems == @VOWELS;     # all vowels present
                }
            }
        }
    }
}

#| count vowel substrings of str
multi MAIN(Str:D $str) {
    say count-vowel($str);
}

#| run tests
multi MAIN(Bool:D :$test) {
    use Test;

    my @tests = extract-tests;
    @tests.push(%{ input => "", output => [] });
    @tests.push(%{ input => "xyz", output => [] });
    @tests.push(%{ input => "xyza", output => [] });
    @tests.push(%{ input => "xyzaeiouz", output => ["aeiou",] });
    @tests.push(%{ input => "aeiouz", output => ["aeiou",] });
    @tests.push(%{ input => "xyzaeiouu", output => ["aeiou", "aeiouu"] });
    @tests.push(%{ input => "XYZAEIOUU", output => ["aeiou", "aeiouu"] });
    plan +@tests;
    for @tests {
        is count-vowel(.<input>).sort, .<output>.sort, "{ .<input> }";
    }
}

sub extract-tests(--> Array[Hash]) {
    my Hash @tests;
    my $string = / '"' <-["]>* '"' /;
    my $list = / '(' <-[(]>* ')' /;
    for $=pod -> $pod-item {
        for $pod-item.contents -> $pod-block {
            next unless $pod-block ~~ Pod::Heading && $pod-block.level == 3;
            my $text = $pod-block.contents[0].contents.join;
            if $text ~~ / ($string) .* ($list)  / {
                @tests.push(%{ input => $0.EVAL, output => $1.EVAL });
            }
        }
    }
    @tests;
}

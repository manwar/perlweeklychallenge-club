#! /usr/bin/env raku

=begin pod
=TITLE
=head2 Task 1 String Lie Detector
Submitted by: Mohammad Sajid Anwar

You are given a string.

Write a script that parses a self-referential string and determines whether its claims about itself are true. The string will make statements about its own composition, specifically the number of vowels and consonants it contains.
=CHALLENGE
=head3 Example 1:
Input: $str = "aa — two vowels and zero consonants"
Output: true

=head3 Example 2:
Input: $str = "iv — one vowel and one consonant"
Output: true

=head3 Example 3:
Input: $str = "hello - three vowels and two consonants"
Output: false

=head3 Example 4:
Input: $str = "aeiou — five vowels and zero consonants"
Output: true

=head3 Example 5:
Input: $str = "aei — three vowels and zero consonants"
Output: true

=end pod

my constant VOWELS = "aeiou";
my constant @ONES = <zero one two three four five six seven eight nine>;

sub my-sub(Str:D $s -->Bool:D) {
    my $match = $s ~~ / ^ (<[a..z]> ** 1..9) <-[a..z]> ** 3 (@ONES) ' ' vowels? ' and ' (@ONES) ' ' consonants? $ /;
    if not $match {
        die "Unexpected input, received $s";
    }
    my $vowels =  $0.comb.grep({VOWELS.contains($_)}).elems;
    my $consonants = $0.chars - $vowels;
    return @ONES[$vowels] eq ~$1 && @ONES[$consonants] eq ~$2;
}

multi MAIN(Str:D $text-to-test) {
    say my-sub($text-to-test);
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
    my $bool = rx/ true | false /;
    for $=pod -> $pod-item {
        for $pod-item.contents -> $pod-block {
            next unless $pod-block ~~ Pod::Heading && $pod-block.level == 3;
            my $text = $pod-block.contents[0].contents.join;
            if $text ~~ / ($string) .* ($bool) / {
                @tests.push(%{ input => $0.EVAL, output => $1.tc.EVAL });
            }
        }
    }
    @tests;
}

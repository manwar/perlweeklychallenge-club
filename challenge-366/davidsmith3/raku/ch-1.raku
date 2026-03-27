#! /usr/bin/env raku

=begin pod
=TITLE
=head2 Task 1 Count Prefixes
Submitted by: Mohammad Sajid Anwar
=CHALLENGE
You are given an array of words and a string (contains only lowercase English letters).

Write a script to return the number of words in the given array that are a prefix of the given string.

=head3 Example 1:
Input: @array = ("a", "ap", "app", "apple", "banana"), $str = "apple"
Output: 4

=head3 Example 2:
Input: @array = ("cat", "dog", "fish"), $str = "bird"
Output: 0

=head3 Example 3:
Input: @array = ("hello", "he", "hell", "heaven", "he"), $str = "hello"
Output: 4

=head3 Example 4:
Input: @array = ("", "code", "coding", "cod"), $str = "coding"
Output: 3

=head3 Example 5:
Input: @array = ("p", "pr", "pro", "prog", "progr", "progra", "program"), $str = "program"
Output: 7

=end pod

sub my-sub(Array $array, Str:D $str -->Int) {
    $array.grep({$str.match(/ ^ $_ /)}).elems;
}

multi MAIN(Str:D $prefixes, Str:D $str) {
    if $prefixes ~~ / '(' ['"'(.*?)'"']+ % ',' ')' / {
        say my-sub($0, $str);
    } else {
        die "Unexpected input.  Received $prefixes and $str";
    }
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
    my $list = / '(' .* ')' /;
    my $string = / '"' .* '"' /;
    my $int = / \d+ /;
    for $=pod -> $pod-item {
        for $pod-item.contents -> $pod-block {
            next unless $pod-block ~~ Pod::Heading && $pod-block.level == 3;
            my $text = $pod-block.contents[0].contents.join;
            if $text ~~ / ($list) .* ($string) .* ($int)  / {
                @tests.push(%{ input => ($0.EVAL.Array, $1.EVAL), output => +$2 });
            }
        }
    }
    @tests;
}

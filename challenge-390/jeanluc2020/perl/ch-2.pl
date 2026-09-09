#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-390/#TASK2
#
# Task 2: Order Characters
# ========================
#
# You are given a string $s (containing only alphabetic characters) and an
# integer $k > 0.
#
# Write a script to choose one of the first $k letters of given string and
# append it at the end of the string. You keep doing this until you have
# lexicographically smallest string and return the string.
#
## Example 1
##
## Input: $str = "dbca", $k = 1
## Output: "adbc"
##
## Move 1: "bcad"
## Move 2: "cadb"
## Move 3: "adbc"
#
## Example 2
##
## Input: $str = "geeks", $k = 2
## Output: "eegks"
##
## First 2 letters: "g", "e"
##
## Move 1: "gekse" (move second letter "e")
## Move 2: "gksee" (move second letter "e")
## Move 3: "kseeg"
## Move 4: "seegk"
## Move 5: "eegks"
#
## Example 3
##
## Input: $str = "cbaed", $k = 3
## Output: "abcde"
##
## First 3 letters: "c", "b", "a"
##
## Move 1: "cbeda"  (move "a")
## Move 2: "cedab"  (move "b")
## Move 3: "edabc"  (move "c")
## Move 4: "eabcd"  (move "d")
## Move 5: "abcde"  (move "e")
#
## Example 4
##
## Input: $str = "fedcba", $k = 4
## Output: "abcdef"
##
## First 4 letters: "f", "e", "d", "c"
##
## Move 1: "fdcbae" (move "e")
## Move 2: "dcbaef" (move "f")
## Move 3: "dcbefa" (move "a")
## Move 4: "dcefab" (move "b")
## Move 5: "defabc" (move "c")
## Move 6: "efabcd" (move "d")
## Move 7: "fabcde" (move "e")
## Move 8: "abcdef" (move "f")
#
## Example 5
##
## Input: $str = "perl", $k = 1
## Output: "erlp"
##
## Move 1: "erlp" (move "p")
#
## Example 6
##
## Input: $str = "oloolooo", $k = 1
## Output: "looloooo"
#
## Example 7
##
## Input: $str = "oloooolo", $k = 1
## Output: "looloooo"
#
############################################################
##
## discussion
##
############################################################
#
# If k=1, we can pick the lexicographically smallest character in
# the string and move it to the front; if this character appears
# to be in the string multiple times, we can use the lexicographically
# smallest string of all of the options where that character is at
# the front.
# If k=2, we can pick the lowest character and move it to the end,
# then pick the first or second character until the second smallest
# character comes to the front, then we pick the second character
# until the first appears again, then move the smallest and second
# smallest character to the end and pick 1 or 2 until we find the
# third smallest character etc. That way, we can always sort the
# whole string by smallest character.
# If k>2 we can do the same, albeit potentially slightly faster.
# So for k=1, we create all variations with the smallest character
# at the beginning and pick the lexicographically smallest one of
# these options, for k>=2 we sort the characters in the string
# lexicographically.

use v5.36;

order_characters("dbca", 1);
order_characters("geeks", 2);
order_characters("cbaed", 3);
order_characters("fedcba", 4);
order_characters("perl", 1);
order_characters("oloolooo", 1);
order_characters("oloooolo", 1);

sub order_characters($str, $k) {
    say "Input: \"$str\", $k";
    my @chars = sort split //, $str;
    if($k >= 2) {
        return say "Output: \"" . join("", @chars) . "\"";
    }
    my $start_char = $chars[0];
    my @options = ();
    foreach my $i (0..length($str)-1) {
        my $tmp = substr($str, $i, length($str) - $i);
        $tmp .= substr($str, 0, $i) if $i;
        push @options, $tmp;
    }
    my @sorted_options = sort @options;
    say "Output: \"$sorted_options[0]\"";
}

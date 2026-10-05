#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-394/#TASK1
#
# Task 1: Alternate Case
# ======================
#
# You are given a string containing an equal number of uppercase and lowercase English letters.
#
# Write a script to the minimum number of adjacent character swaps needed to
# turn the given string into an alternate case string.
#
## Example 1
##
## Input: $str = "aAbB"
## Output: 0
#
## Example 2
##
## Input: $str = "AAbb"
## Output: 1
##
## Swap 1: "AbAb"
#
## Example 3
##
## Input: $str = "AAAbbb"
## Output: 3
##
## Swap 1: "AAbAbb"
## Swap 2: "AbAAbb"
## Swap 3: "AbAbAb"
#
## Example 4
##
## Input: $str = "aABb"
## Output: 1
##
## Swap 1: "aAbB"
#
## Example 5
##
## Input: $str = "bBBAaa"
## Output: 2
##
## Swap 1: "BbBAaa"
## Swap 2: "BbBaAa"
#
############################################################
##
## discussion
##
############################################################
#
# We have two cases, either we need to swap the first character or we don't.
# We calculate the amount of swaps required for both cases (in the former case
# we need to add the necessary swaps to swap the first character). Then we pick
# the minimum of the two.
# The amount of swaps necessary is simple: Find the next character that doesn't
# match the current character's case, then swap it forward to the place next to
# the current character the appropriate amount of steps. We just speed this up
# by doing that in a single step.
# Repeat this for all characters in the string.

use v5.36;

alternate_case("aAbB");
alternate_case("AAbb");
alternate_case("AAAbbb");
alternate_case("aABb");
alternate_case("bBBAaa");

sub alternate_case($str) {
    say "Input: \"$str\"";
    my $s1 = _alternate_case($str);
    my @chars = split //, $str;
    my $next_other;
    if(isupper($chars[0])) {
        $next_other = find_next_lower(0, @chars);
    } else {
        $next_other = find_next_upper(0, @chars);
    }
    @chars = ($chars[$next_other], @chars[0..$next_other-1], @chars[$next_other+1..$#chars]);
    my $s2 = ($next_other - 1) + _alternate_case(join("", @chars));
    if($s1 > $s2) {
        say "Output: $s2";
    } else {
        say "Output: $s1";
    }
}

sub _alternate_case($str) {
    my @chars = split //, $str;
    my $start_pointer = -1;
    my $next_other;
    my $swaps = 0;
    while($start_pointer < $#chars) {
        $start_pointer++;
        last if $start_pointer >= $#chars;
        if(isupper($chars[$start_pointer])) {
            $next_other = find_next_lower($start_pointer, @chars);
        } else {
            $next_other = find_next_upper($start_pointer, @chars);
        }
        $swaps += ($next_other - $start_pointer - 1);
        @chars = (@chars[0..$start_pointer], $chars[$next_other], @chars[$start_pointer+1..$next_other-1], @chars[$next_other+1..$#chars]);
    }
    return $swaps;
}

sub isupper($char) {
    if(ord($char) >= 64 && ord($char) <= 90) {
        return 1;
    }
    return 0;
}

sub find_next_upper($index, @chars) {
    $index++;
    while(! isupper($chars[$index]) ) {
        $index++;
    }
    return $index;
}

sub find_next_lower($index, @chars) {
    $index++;
    while(isupper($chars[$index]) ) {
        $index++;
    }
    return $index;
}

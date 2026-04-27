#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-371/#TASK1
#
# Task 1: Missing Letter
# ======================
#
# You are given a sequence of 5 lowercase letters, with one letter replaced by
# ‘?’. Each letter maps to its position in the alphabet (‘a = 1’, ‘b = 2’, …,
# ‘z = 26’). The sequence follows a repeating pattern of step sizes between
# consecutive letters. The pattern is either a constant step (e.g., ‘+2, +2,
# +2, +2’) or a simple alternating pattern of two distinct steps (e.g., ‘+2,
# +3, +2, +3’).
#
## Example 1
##
## Input: @seq = qw(a c ? g i)
## Output: e
##
## The pattern of the sequence is +2,+2,+2,+2.
## 1: a
## 3: c
## 5: e
## 7: g
## 9: i
#
## Example 2
##
## Input: @seq = qw(a d ? j m)
## Output: g
##
## The pattern of the sequence is +3,+3,+3,+3.
## 1: a
## 4: d
## 7: g
## 10: j
## 13: m
#
## Example 3
##
## Input: @seq = qw(a e ? m q)
## Output: i
##
## The pattern of the sequence is +4,+4,+4,+4.
## 1: a
## 5: e
## 9: i
## 13: m
## 17: q
#
## Example 4
##
## Input: @seq = qw(a c f ? k)
## Output: h
##
## The pattern of the sequence is +2,+3,+2,+3.
## 1: a
## 3: c
## 6: f
## 8: h
## 11: k
#
## Example 5
##
## Input: @seq = qw(b e g ? l)
## Output: j
##
## The pattern of the sequence is +3,+2,+3,+2.
## 2: b
## 5: e
## 7: g
## 10: j
## 12: l
#
############################################################
##
## discussion
##
############################################################
#
# For each element in the list we check what the difference is to the
# next element - until we have the value of both potentially different
# step sizes (if there is only one step size, this will lead to both
# step sizes to be the same). We then only need keep track of when the '?'
# appeared. In the end, if it appeared in the first place in $seq, we
# calculate it by walking backwards by $s1 from the second element in $seq.
# Otherwise, we walk forward by $s1 or $s2 from the previous element,
# dependent on whether the index of the unknown element is odd or even.
#
use v5.36;

missing_letter( qw(a c ? g i) );
missing_letter( qw(a d ? j m) );
missing_letter( qw(a e ? m q) );
missing_letter( qw(a c f ? k) );
missing_letter( qw(b e g ? l) );

sub missing_letter(@seq) {
    say "Input: (" . join(", ", @seq) . ")";
    my ($s1, $s2, $which_unknown);
    foreach my $i (0..$#seq-1) {
        if($seq[$i] eq '?') {
            $which_unknown = $i;
            next;
        }
        if($i % 2) {
            next if $s2;
            next if $seq[$i+1] eq '?';
            $s2 = ord($seq[$i+1]) - ord($seq[$i]);
        } else {
            next if $s1;
            next if $seq[$i+1] eq '?';
            $s1 = ord($seq[$i+1]) - ord($seq[$i]);
        }
    }
    if($which_unknown == 0) {
        return say "Output: " . chr(ord($seq[1]) - $s1);
    }
    if($which_unknown % 2) {
        say "Output: " . chr(ord($seq[$which_unknown-1]) + $s1);
    } else {
        say "Output: " . chr(ord($seq[$which_unknown-1]) + $s2);
    }
}

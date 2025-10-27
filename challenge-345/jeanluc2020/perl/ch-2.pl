#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-345/#TASK2
#
# Task 2: Last Visitor
# ====================
#
# You are given an integer array @ints where each element is either a positive integer or -1.
#
# We process the array from left to right while maintaining two lists:
#
## @seen: stores previously seen positive integers (newest at the front)
## @ans: stores the answers for each -1
#
# Rules:
#
## If $ints[i] is a positive number -> insert it at the front of @seen
## If $ints[i] is -1:
#
# Let $x be how many -1s in a row we’ve seen before this one.
#
# If $x < len(@seen) -> append seen[x] to @ans
#
# Else -> append -1 to @ans
#
# At the end, return @ans.
#
## Example 1
##
## Input: @ints = (5, -1, -1)
## Output: (5, -1)
##
## @seen = (5)
## First  -1: @ans = (5)
## Second -1: @ans = (5, -1)
#
#
## Example 2
##
## Input: @ints = (3, 7, -1, -1, -1)
## Output: (7, 3, -1)
##
## @seen = (3, 7)
## First  -1: @ans = (7)
## Second -1: @ans = (7, 3)
## Third  -1: @ans = (7, 3, -1)
#
#
## Example 3
##
## Input: @ints = (2, -1, 4, -1, -1)
## Output: (2, 4, 2)
#
#
## Example 4
##
## Input: @ints = (10, 20, -1, 30, -1, -1)
## Output: (20, 30, 20)
#
#
## Example 5
##
## Input: @ints = (-1, -1, 5, -1)
## Output: (-1, -1, 5)
#
############################################################
##
## discussion
##
############################################################
#
# We just implement the rules as layed out in the exercise.
# We use unshift to add at the beginning of @seen if needed,
# otherwise we check our $x and either add $seen[$x] to @ans
# or we add -1. Don't forget to increment $x of course. And
# reset it to 0 if the number we're looking at is > 0.

use v5.36;


last_visitor(5, -1, -1);
last_visitor(3, 7, -1, -1, -1);
last_visitor(2, -1, 4, -1, -1);
last_visitor(10, 20, -1, 30, -1, -1);
last_visitor(-1, -1, 5, -1);

sub last_visitor(@ints) {
    say "Input: (" . join(", ", @ints) . ")";
    my @seen = ();
    my @ans = ();
    my $x = 0;
    foreach my $elem (@ints) {
        if($elem > 0) {
            $x = 0;
            unshift @seen, $elem;
        } else {
            if($x < scalar(@seen)) {
                push @ans, $seen[$x];
            } else {
                push @ans, -1;
            }
            $x++;
        }
    }
    say "Output: (" . join(", ", @ans) . ")";
}

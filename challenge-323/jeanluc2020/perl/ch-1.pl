#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-323/#TASK1
#
# Task 1: Increment Decrement
# ===========================
#
# You are given a list of operations.
#
# Write a script to return the final value after performing the given
# operations in order. The initial value is always 0.
#
# Possible Operations:
# ++x or x++: increment by 1
# --x or x--: decrement by 1
#
#
## Example 1
##
## Input: @operations = ("--x", "x++", "x++")
## Output: 1
##
## Operation "--x" =>  0 - 1 => -1
## Operation "x++" => -1 + 1 =>  0
## Operation "x++" =>  0 + 1 =>  1
#
#
## Example 2
##
## Input: @operations = ("x++", "++x", "x++")
## Output: 3
#
#
## Example 3
##
## Input: @operations = ("x++", "++x", "--x", "x--")
## Output: 0
##
## Operation "x++" => 0 + 1 => 1
## Operation "++x" => 1 + 1 => 2
## Operation "--x" => 2 - 1 => 1
## Operation "x--" => 1 - 1 => 0
#
############################################################
##
## discussion
##
############################################################
#
# Each possible input maps to either +1 or -1, so we just
# fill a hash with those possible inputs as keys and their
# corresponding mappings as values. Then we just need to
# add up all the values for all given operations.

use v5.36;

increment_decrement("--x", "x++", "x++");
increment_decrement("x++", "++x", "x++");
increment_decrement("x++", "++x", "--x", "x--");

sub increment_decrement( @operations ) {
    say "Input: (\"" . join("\", \"", @operations) . "\")";
    my $value = 0;
    my $add = {
        "++x" => 1,
        "x++" => 1,
        "--x" => -1,
        "x--" => -1,
    };
    foreach my $op (@operations) {
        $value += $add->{$op};
    }
    say "Output: $value";
}

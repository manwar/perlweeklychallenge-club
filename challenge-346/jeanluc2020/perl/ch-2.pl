#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-346/#TASK2
#
# Task 2: Magic Expression
# ========================
#
# You are given a string containing only digits and a target integer.
#
# Write a script to insert binary operators +, - and * between the digits in
# the given string that evaluates to target integer.
#
## Example 1
##
## Input: $str = "123", $target = 6
## Output: ("1*2*3", "1+2+3")
#
#
## Example 2
##
## Input: $str = "105", $target = 5
## Output: ("1*0+5", "10-5")
#
#
## Example 3
##
## Input: $str = "232", $target = 8
## Output: ("2*3+2", "2+3*2")
#
#
## Example 4
##
## Input: $str = "1234", $target = 10
## Output: ("1*2*3+4", "1+2+3+4")
#
#
## Example 5
##
## Input: $str = "1001", $target = 2
## Output: ("1+0*0+1", "1+0+0+1", "1+0-0+1", "1-0*0+1", "1-0+0+1", "1-0-0+1")
#
############################################################
##
## discussion
##
############################################################
#
# We recursively build all possible strings with inserted operators. Then we
# evaluate these strings and keep the ones that calculate to the target.

use v5.36;

magic_expression("123", 6);
magic_expression("105", 5);
magic_expression("232", 8);
magic_expression("1234", 10);
magic_expression("1001", 2);

sub magic_expression($str, $target) {
    say "Input: '$str', $target";
    my @parts = split //, $str;
    my @result = find_magic_expressions($target, @parts);
    say "Output: (\"" . join("\", \"", @result) . "\")";
}

sub find_magic_expressions($target, $str, @list) {
    my @result = ();
    if(@list) {
        foreach my $operator ("+", "-", "*", "") {
            if($str =~ m/[-+*]0/ && $operator eq "") {
                next;
            }
            my $tmp_str = $str . $operator . $list[0];
            push @result, find_magic_expressions($target, $tmp_str, @list[1..$#list]);
        }
    } else {
        my $x;
        eval "\$x = $str;";
        if($x == $target) {
            return ($str);
        } else {
            return ();
        }
    }
    return @result;
}

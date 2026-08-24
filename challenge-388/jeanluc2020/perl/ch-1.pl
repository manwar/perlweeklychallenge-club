#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-388/#TASK1
#
# Task 1: Dyck Words
# ==================
#
# A Dyck Word of order $n is a string of length 2x$n consisting of $n ‘U’ (Up)
# characters and $n ‘D’ (Down) characters such that no initial prefix of the
# string contains more ‘D’s than ‘U’s.
#
# Write a script to return a list of all valid Dyck words of length 2x$n,
# sorted in lexicographical (alphabetical) order.
#
## Example 1
##
## Input: $n = 1
## Output: ("UD")
#
## Example 2
##
## Input: $n = 2
## Output: ("UDUD","UUDD")
#
## Example 3
##
## Input: $n = 3
## Output: ("UDUDUD", "UDUUDD", "UUDDUD", "UUDUDD", "UUUDDD")
#
## Example 4
##
## Input: $n = 0
## Output: ("")
#
## Example 5
##
## Input: $n = 4
## Output: ("UDUDUDUD", "UDUDUUDD", "UDUUDDUD", "UDUUDUDD", "UDUUUDDD",
##          "UUDDUDUD", "UUDDUUDD", "UUDUDDUD", "UUDUDUDD", "UUDUUDDD",
##          "UUUDDDUD", "UUUDDUDD", "UUUDUDDD", "UUUUDDDD")
#
############################################################
##
## discussion
##
############################################################
#
# We just calculate all options recursively:
# - We start with an empty string
# - As long as we still have U's or D's available:
#   - recursively create all options starting at the current string:
#     - if there are more U's, create all new results from the current
#       results by adding a "U" and recursively go further with one less U
#     - if there are more D's than U's, create all new results from the current
#       results by adding a "D" and recursively go further with one less D
# When there are no more U's and D's left, return the result.

use v5.36;

sub dyck_words($n) {
    say "Input: $n";
    my @result = find_dyck_words($n, $n, (""));
    say "Output: (" . join(", ", map { "\"$_\"" } @result) . ")";
}

sub find_dyck_words($n1, $n2, @current_result) {
    my @result = ();
    return @current_result if $n1 == 0 and $n2 == 0;
    if($n1 > 0) {
        foreach my $elem (@current_result) {
            push @result, find_dyck_words($n1-1, $n2, ("${elem}U"));
        }
    }
    if($n2 > $n1) {
        foreach my $elem (@current_result) {
            push @result, find_dyck_words($n1, $n2-1, ("${elem}D"));
        }
    }
    return @result;
}

dyck_words(1);
dyck_words(2);
dyck_words(3);
dyck_words(0);
dyck_words(4);

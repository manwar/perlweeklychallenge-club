#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-386/#TASK2
#
# Task 2: Rational Numbers
# ========================
#
# You are given two strings representing non-negative rational numbers.
#
# Write a script to return true if the two given rational numbers are same
# otherwise false.
#
## Example 1
##
## Input: $rat1 = "0.(12)"
##        $rat2 = "0.(121)"
## Output: false
##
## Expansion of "0.(12)"  = 0.12 12 12 12
## Expansion of "0.(121)" = 0.121 121 121
#
## Example 2
##
## Input: $rat1 = "0.1(23)"
##        $rat2 = "0.12(32)"
## Output: true
##
## Expansion of "0.1(23)"  = 0.1 23 23 23
## Expansion of "0.12(32)" = 0.12 32 32 32
#
## Example 3
##
## Input: $rat1 = "0.1(234)"
##        $rat2 = "0.12(342)"
## Output: true
##
## Expansion of "0.1(234)"  = 0.1 234 234 234
## Expansion of "0.12(342)" = 0.12 342 342 342
#
## Example 4
##
## Input: $rat1 = "12.99(99)"
##        $rat2 = "13."
## Output: true
#
## Example 5
##
## Input: $rat1 = "0.(123)"
##        $rat2 = "0.1(231)"
## Output: true
#
############################################################
##
## discussion
##
############################################################
#
# We know that a periodic part of n digits x1 x2 ... xn is the
# same as (x1x2...xn)/99...9, with n 9s. So we just calculate
# the number represented by both "$rat1" and "$rat2" by adding
# - everything before the "." as an integer
# - everything after the "." before starting the periodic just
#   as is: digits x1 x2 ... xn turn into x1x2...xn / 10^m, where
#   m is the amount of digits found in the number
# - the periodic part is (x1x2...xn)/99...9, with n 9s, but also
#   divided by 10^m from the digits before the periodic part
# Once we calculated both numbers this way, we can simply compare
# them.

use v5.36;

rational_numbers( "0.(12)", "0.(121)" );
rational_numbers( "0.1(23)", "0.12(32)" );
rational_numbers( "0.1(234)", "0.12(342)" );
rational_numbers( "12.99(99)", "13." );
rational_numbers( "0.(123)", "0.1(231)" );

sub rational_numbers($rat1, $rat2) {
    say "Input: $rat1, $rat2";
    my $r1 = calculate($rat1);
    my $r2 = calculate($rat2);
    if($r1 == $r2) {
        say "Output: true";
    } else {
        say "Output: false";
    }
}

sub calculate($num) {
    my ($predot, $postdot) = split /\./, $num;
    return $predot + 0.0 unless $postdot;
    if($postdot =~ m/\(/) {
        my ($preperiodic, $periodic) = split /\(/, $postdot;
        $periodic =~ s/\)$//;
        my $periodic_length = length($periodic);
        my $periodic_part = '9'x$periodic_length;
        my $preperiodic_length = length($preperiodic);
        if($preperiodic_length > 0) {
            return $predot + ($preperiodic / (10 ** $preperiodic_length)) +
                ( $periodic / $periodic_part / (10 ** $preperiodic_length) );
        } else {
            return $predot + ( $periodic / $periodic_part );
        }
    } else {
        return $num;
    }
}

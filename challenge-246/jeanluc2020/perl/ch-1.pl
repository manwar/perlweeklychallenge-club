#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-246/#TASK1
#
# Task 1: 6 out of 49
# ===================
#
# 6 out of 49 is a German lottery.
#
# Write a script that outputs six unique random integers from the range 1 to
# 49.
#
## Output
##
## 3
## 10
## 11
## 22
## 38
## 49
#
############################################################
##
## discussion
##
############################################################
#
# Collect random numbers until we have 6 of them. In case we randomly select a
# number that we saw already, discard the number and select another random
# number instead.
#
use strict;
use warnings;

my $result = {};

sub next_rand {
   my $n = int(rand(49)) + 1;
   return $n unless $result->{$n};
   # print "Collision, need another random number!\n";
   return next_rand();
}

foreach(1..6) {
   my $n = next_rand();
   $result->{$n} = 1;
}

print join("\n", sort {$a<=>$b} keys %$result), "\n";


#!/usr/bin/perl

# Peter Campbell Smith - 2022-11-07
# PWC 190 task 1

use v5.28;
use utf8;
use warnings;
binmode(STDOUT, ':utf8');

# You are given a string with alphabetic characters only: A..Z and a..z. Write a script to find out if the usage of 
# capital letters is appropriate if it satisfies at least one of the following rules:
# 1) Only first letter is capital and all others are small.
# 2) Every letter is small.
# 3) Every letter is capital.

# Blog: https://pjcs-pwc.blogspot.com/2022/11/capital-test-and-ambiguous-encoding.html

my (@tests, $test);

@tests = qw[Perl PWC PyThon raku   Byron ShakesSpeare miltoN KEATS 123 6-fold Hello! a A];

# loop over tests
 while ($test = shift @tests) {
 	 say qq[\nInput:  $test\nOutput: ] . ($test =~ m/^[A-Z]?([a-z]*|[A-Z]*)$/ ? 1 : 0);
}

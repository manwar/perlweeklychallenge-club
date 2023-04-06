#!/usr/bin/perl

# Challenge 186
#
# Task 2: Unicode Makeover
# Submitted by: Mohammad S Anwar
#
# You are given a string with possible unicode characters.
#
# Create a subroutine sub makeover($str) that replace the unicode characters with
# ascii equivalent. For this task, let us assume it only contains alphabets.
# Example 1
#
# Input: $str = 'ÃÊÍÒÙ';
# Output: 'AEIOU'
#
# Example 2
#
# Input: $str = 'âÊíÒÙ';
# Output: 'aEiOU'

use utf8;
use Modern::Perl;
use Text::Unidecode;
use Test::More;

is unidecode('ÃÊÍÒÙ'), 'AEIOU';
is unidecode('ãêíòù'), 'aeiou';
done_testing;

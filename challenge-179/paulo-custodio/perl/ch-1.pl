#!/usr/bin/env perl

# Challenge 179
#
# Task 1: Ordinal Number Spelling
# Submitted by: Mohammad S Anwar
#
# You are given a positive number, $n.
#
# Write a script to spell the ordinal number.
#
# For example,
#
# 11 => eleventh
# 62 => sixty-second
# 99 => ninety-ninth

use Modern::Perl;
use Lingua::EN::Numbers 'num2en_ordinal';

say num2en_ordinal(shift);

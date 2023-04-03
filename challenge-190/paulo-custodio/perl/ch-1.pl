#!/usr/bin/perl

# Challenge 190
#
# Task 1: Capital Detection
# Submitted by: Mohammad S Anwar
#
# You are given a string with alphabetic characters only: A..Z and a..z.
#
# Write a script to find out if the usage of Capital is appropriate if it
# satisfies at least one of the following rules:
#
# 1) Only first letter is capital and all others are small.
# 2) Every letter is small.
# 3) Every letter is capital.
#
#
# Example 1
#
# Input: $s = 'Perl'
# Output: 1
#
# Example 2
#
# Input: $s = 'TPF'
# Output: 1
#
# Example 3
#
# Input: $s = 'PyThon'
# Output: 0
#
# Example 4
#
# Input: $s = 'raku'
# Output: 1

use Modern::Perl;

$_=shift;
say /^([A-Z]+|[a-z]+|[A-Z][a-z]*)$/ ? 1 : 0;

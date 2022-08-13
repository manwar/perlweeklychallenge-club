#!/usr/bin/env perl
use v5.36;

# Task 1: Damm Algorithm
# Submitted by: Mohammad S Anwar
#
# You are given a positive number, $n.
#
# Write a script to validate the given number against the included
# check digit.

# from https://en.wikipedia.org/wiki/Damm_algorithm
my @table = (
    [0,3,1,7,5,9,8,6,4,2],
    [7,0,9,2,1,5,4,8,6,3],
    [4,2,0,6,8,7,1,3,5,9],
    [1,7,5,0,9,8,3,4,2,6],
    [6,1,2,3,0,4,5,9,7,8],
    [3,6,7,4,2,0,9,5,8,1],
    [5,8,6,9,7,2,0,1,3,4],
    [8,9,4,5,3,6,2,0,1,7],
    [9,4,3,8,6,1,7,2,0,5],
    [2,5,8,1,4,3,6,7,9,0]
);

my $n = $ARGV[0];
my @digits = split //, $n;
my $interim = 0;
$interim = $table[$interim][$digits[$_]] for 0..$#digits-1;
say $interim == $digits[-1] ? "valid" : "invalid";

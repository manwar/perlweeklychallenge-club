#!/usr/bin/perl

# THE WEEKLY CHALLENGE - 091
# TASK #2: Jump Game
#
# You are given an array of positive numbers @N, where value at each index
# determines how far you are allowed to jump further. Write a script to decide
# if you can jump to the last index. Print 1 if you are able to reach the last
# index otherwise 0.
use strict;
use warnings;

my @N = @ARGV;

my $pos = 0;
while ($pos < $#N && $N[$pos]) {
    $pos += $N[$pos];
}
print((($pos == $#N) ? 1 : 0), "\n");

#! /opt/local/bin/perl
#
#       tiny_numbers_on_the_hillside.pl
#
#         TASK #1 › Smallest Positive Number Bits
#         Submitted by: Mohammad S Anwar
#         You are given unsorted list of integers @N.
# 
#         Write a script to find out the smallest positive number missing.
# 
#         Example 1:
#             Input: @N = (5, 2, -2, 0)
#             Output: 1
#         Example 2:
#             Input: @N = (1, 8, -1)
#             Output: 2
#         Example 3:
#             Input: @N = (2, 0, -1)
#             Output: 1
#
#         method:
#             Map the array into a hash. Start counting up from 1, checking
#             existence. Hashes are fast lookups. Even if all N from 1 to the
#             last is contained in the set, eventually the array will be
#             exhausted and the next natural number will be output. 
#             
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN:

my @input = @ARGV ? @ARGV : (5, 2, -2, 0, 16, 1, 6, 3, -18, 1, 0, 4);
say "input : (", (join ', ', @input), ")";

my %lookup = map { $_ => 1 } @input;
my $num;

while ( ++$num ) {  ## @input is finite so this will end eventually
    say "output:  $num" and exit if ! exists $lookup{$num};
}

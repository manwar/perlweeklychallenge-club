#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-308/#TASK2
#
# Task 2: Decode XOR
# ==================
#
# You are given an encoded array and an initial integer.
#
# Write a script to find the original array that produced the given encoded
# array. It was encoded such that encoded[i] = orig[i] XOR orig[i + 1].
#
## Example 1
##
## Input: @encoded = (1, 2, 3), $initial = 1
## Output: (1, 0, 2, 1)
##
## Encoded array created like below, if the original array was (1, 0, 2, 1)
## $encoded[0] = (1 xor 0) = 1
## $encoded[1] = (0 xor 2) = 2
## $encoded[2] = (2 xor 1) = 3
#
## Example 2
##
## Input: @encoded = (6, 2, 7, 3), $initial = 4
## Output: (4, 2, 0, 7, 4)
#
############################################################
##
## discussion
##
############################################################
#
# Let's have a look at bitwise xor:
# a xor b = c
# 0     0 = 0
# 1     0 = 1
# 0     1 = 1
# 1     1 = 0
# We can see: a xor b = c <=> a = b xor c
# In other words, we can calculate the next numer in the orig array by
# calculating the last found element in the orig array and the corresponding
# element in the encoded array. Since the first element of orig is given,
# the solution is well-defined.

use v5.36;

decode_xor(1, (1, 2, 3));
decode_xor(4, (6, 2, 7, 3));

sub decode_xor {
   my ($initial, @encoded) = @_;
   print "Input: (" . join(", ", @encoded) . "), $initial\n";
   my @result = ($initial);
   foreach my $elem (@encoded) {
      my $last = $result[$#result];
      my $r = $last ^ $elem;
      push @result, $r;
   }
   print "Output: (" . join(", ", @result) . ")\n";
}

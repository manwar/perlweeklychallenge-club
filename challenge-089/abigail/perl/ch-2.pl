#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# Challenge
#
# Write a script to display matrix as below with numbers 1 - 9.
# Please make sure numbers are used once.
#
#    [ a b c ]
#    [ d e f ]
#    [ g h i ]
# 
# So that it satisfies the following:
# 
#    a + b + c = 15
#    d + e + f = 15
#    g + h + i = 15
#    a + d + g = 15
#    b + e + h = 15
#    c + f + i = 15
#    a + e + i = 15
#    c + e + g = 15
#

#
# Well, this is utter trival, and there is absolute nothing to
# calculate.
#
# There is only one 3x3 matrix, 8 if you count rotations
# and reflections.
#
# For those who don't know the 3x3 magic square since childhood,
# and who don't look it up on the internet:
#
# - You need an odd number of odd numbers to sum to 15, so each
#   row, column or diagonal contain 0 or 2 even numbers.
# - There are 5 odd numbers in the range 1-9, and 4 even numbers.
# - Hence, all the corners contain even numbers, the rest are odd.
# - This means, there are 2 triples with all odd numbers; together
#   they contain all the odd numbers, and one odd number (the one
#   in the center) is part of both.
# - The only all odd triplet containing a 9 which sums to 15 is
#   (9, 5, 1). Which means the other triplet must contain a 7 and a 3,
#   and to have that sum to 15, a 5 as well. Which means, 5 is in
#   the center. 
# - Now we can pick any even number (one of four) and place it in a corner.
#   This fixes the number in the opposite corner. We then place the remaining
#   two even numbers in the remaining corners (either possibility works).
# - There is now one way to place the remaining four odd numbers.
#
# This leads to the following solutions (all the others can be 
# obtained by rotations and reflections):
#
#       8 1 6
#       3 5 7
#       4 9 2
#

print << '--';
8 1 6
3 5 7
4 9 2
--

__END__

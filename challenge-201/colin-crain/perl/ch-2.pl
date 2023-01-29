#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       piles-of-pennies.pl
#
#       Penny Piles
#         Submitted by: Robbie Hatley
#         You are given an integer, $n > 0.
# 
#         Write a script to determine the number of ways of putting $n
#         pennies in a row of piles of ascending heights from left to right.
# 
#         Example
#             Input: $n = 5
#             Output: 7
# 
#             Since $n=5, there are 7 ways of stacking 5 pennies in ascending
#             piles:
# 
#                 1 1 1 1 1
#                 1 1 1 2
#                 1 2 2
#                 1 1 3
#                 2 3
#                 1 4
#                 5
# 
#           method:
# 
#             The question is a rephrasing of a number theory problems
#             known as integer partitions. It's a tricky business. We are
#             computing the number of ways to section a positive integer
#             into smaller (positive) integers that sum to the original
#             value. The various orderings are considered multisets, with
#             no implicit ordering, and rearrangements of the same elements
#             are considered equivalent. Element values within the grouping
#             can be duplicated, as illustrated by the example above. 
#             
#             There is no known closed-form solution to the integer partition problem. 
# 
#             Wea are not asked to enumerate the partitions, only count
#             them. But why not? What are they trying to hide? WHAT DON'T
#             THEY WANT US TO KNOW???
# 
#             I SAY, FREE THE PATTERNS!
# 
#             Once we expose the truth, the world will be able to see the
#             patterns for what they are: piles of money, growing higher, a
#             literal stairway to heaven, built on the backs of the
#             proletraiat. 
#
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';

use Math::Prime::Util qw( forpart partitions );



my $value = shift @ARGV // 19;
my $count;

forpart { $count++; say "@_" } $value ;

say "\nfound $count arrangements of pennies";






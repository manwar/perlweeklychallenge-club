#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-210/#TASK2
#
# Task 2: Number Collision
# ========================
#
# You are given an array of integers which can move in right direction if it is
# positive and left direction when negative. If two numbers collide then the
# smaller one will explode. And if both are same then they both explode. We
# take the absolute value in consideration when comparing.
#
# All numbers move at the same speed, therefore any 2 numbers moving in the
# same direction will never collide.
#
# Write a script to find out who survives the collision.
#
## Example 1:
##
## Input: @list = (2, 3, -1)
## Output: (2, 3)
##
## The numbers 3 and -1 collide and -1 explodes in the end. So we are left with (2, 3).
#
## Example 2:
##
## Input: @list = (3, 2, -4)
## Output: (-4)
##
## The numbers 2 and -4 collide and 2 explodes in the end. That gives us (3, -4).
## Now the numbers 3 and -4 collide and 3 explodes. Finally we are left with -4.
#
## Example 3:
##
## Input: @list = (1, -1)
## Output: ()
##
## The numbers 1 and -1 both collide and explode. Nothing left in the end.
#
############################################################
##
## discussion
############################################################
#
# Negative numbers at the left and positive numbers at the right of the array
# are finished moving. Numbers can only move if a negative number is right of a
# positive number.

use strict;
use warnings;

number_collision(2, 3, -1);
number_collision(3, 2, -4);
number_collision(1, -1);

sub number_collision {
   my @list = @_;
   print "Input: (" . join(", ", @list) . ")\n";
   my @result = explode(@list);
   print "Output: (" . join(", ", @result) . ")\n";
}

sub explode {
   my @list = @_;
   my @result = ();
   while(@list && $list[0] < 0) {
      push @result, shift @list;
   }
   my $exploded = 0;
   foreach my $i (0..$#list-1) {
      if($list[$i] >= 0 && $list[$i+1] < 0) {
         if($list[$i] == abs($list[$i+1])) {
            # both explode
            $i++;
            $exploded = 1;
            next;
         } elsif ($list[$i] > abs($list[$i+1])) {
            push @result, $list[$i];
            $i++;
            $exploded = 1;
            next;
         } else {
            push @result, $list[$i+1];
            $i++;
            $exploded = 1;
            next;
         }
      } elsif ($list[$i] == 0 && $list[$i+1] >= 0) {
         push @result, $list[$i];
         next;
      } elsif ($list[$i] > 0 && $list[$i+1] == 0) {
         push @result, $list[$i];
         $i++; # skip the following 0
         $exploded = 1;
         next;
      } elsif($list[$i] > 0 && $list[$i+1] > 0) {
         push @result, $list[$i];
         if($i == $#list - 1) {
            push @result, $list[$i+1];
         }
         next;
      } else { # $list[$i] < 0
         push @result, $list[$i];
         next;
      }
   }
   if($exploded) {
      return explode(@result);
   } else {
      return @result;
   }
}


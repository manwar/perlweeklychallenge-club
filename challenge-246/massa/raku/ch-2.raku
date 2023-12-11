#! /usr/bin/env raku

# Perl Weekly Challenge 
# © 2023 Shimon Bollinger. All rights reserved.
# Last modified: Mon 15 May 2023 09:17:32 PM EDT
# Version 0.0.1

=begin pod
=TITLE
=head2 Task 2: Linear Recurrece of Second Order

=SUBTITLE
=head2 Submitted by massa

=CHALLENGE
=head2

You are given an array @a of five integers.

Write a script to decide whether the given integers form a linear recurrence of
second order with integer factors.

A linear recurrence of second order has the form

   a[n] = p * a[n-2] + q * a[n-1] with n > 1

   where p and q must be integers.

=head3 Example 1:

   Input: @a = (1, 1, 2, 3, 5)
   Output: true

   @a is the initial part of the Fibonacci sequence a[n] = a[n-2] + a[n-1] with
   a[0] = 1 and a[1] = 1.

=head3 Example 2:

   Input: @a = (4, 2, 4, 5, 7)
   Output: false

   a[1] and a[2] are even. Any linear combination of two even numbers with
   integer factors is even, too. Because a[3] is odd, the given numbers cannot
   form a linear recurrence of second order with integer factors.

=head3 Example 3:

   Input: @a = (4, 1, 2, -3, 8)
   Output: true

   a[n] = a[n-2] - 2 * a[n-1]

=SOLUTION

=end pod

# always use the latest version of Raku
use v6.*;

=begin pod

   The solution goes mathematically like this:
   pa₀ + qa₁ = a₂
   pa₁ + qa₂ = a₃
   pa₂ + qa₃ = a₄

   or, in matricial form, for the first two equations:
   | a₀ a₁ |   | p |   | a₂ |
   | a₁ a₂ | * | q | = | a₃ |

   and for the last two:
   | a₁ a₂ |   | p₂ |   | a₃ |
   | a₂ a₃ | * | q₂ | = | a₄ |

   The condition for having an integer-only solution is that p == p₂, q == q₂
   and that p and q are both integers

=end pod

sub det2x2(@a --> Int) {
   @a[1][1]*@a[0][0] - @a[1][0]*@a[0][1]
}

sub SOLUTION(@a) {
  my \D = det2x2 @a[(0, 1), (1, 2)];
  my \p = D R/ det2x2 @a[(2, 1), (3, 2)];
  my \q = D R/ det2x2 @a[(0, 2), (1, 3)];
  my \D2 = det2x2 @a[(1, 2), (2, 3)];
  my \p2 = D2 R/ det2x2 @a[(3, 2), (4, 3)];
  my \q2 = D2 R/ det2x2 @a[(1, 3), (2, 4)];
  p == p2 and q == q2 and p.denominator == 1 and q.denominator == 1
}

multi MAIN (Bool :$test!) {
    use Test;

    my @tests =
        %{ input =>  (1, 1, 2, 3, 5),
           output => (True,) },
        %{ input =>  (4, 2, 3, 4, 7),
           output => (False,) },
        %{ input =>  (4, 1, 2, -3, 8),
           output => (True,) },
    ;

    .<input>.&SOLUTION.deepmap({$_}).&is-deeply: .<output>, .<text> for @tests
} # end of multi MAIN (Bool :$test!)



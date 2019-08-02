use v6;

################################################################################
=begin comment

Perl Weekly Challenge 017
=========================

Task #1
-------

Create a script to demonstrate Ackermann function. The Ackermann function is
defined as below, m and n are positive number:

  A(m, n) = n + 1                  if m = 0
  A(m, n) = A(m - 1, 1)            if m > 0 and n = 0
  A(m, n) = A(m - 1, A(m, n - 1))  if m > 0 and n > 0

Example expansions as shown in
[ https://en.wikipedia.org/wiki/Ackermann_function |wiki page].

  A(1, 2) = A(0, A(1, 1))
          = A(0, A(0, A(1, 0)))
          = A(0, A(0, A(0, 1)))
          = A(0, A(0, 2))
          = A(0, 3)
          = 4

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2019 PerlMonk Athanasius #
#--------------------------------------#

use Memoize;

my UInt constant $DEFAULT-M  = 1;
my UInt constant $DEFAULT-N  = 2;
my UInt          $recursions = 0;

sub MAIN
(
    UInt:D :$m             = $DEFAULT-M,
    UInt:D :$n             = $DEFAULT-N,
    Bool:D :memoize(:$mem) = False,
)
{
    memoize(&ackermann) if $mem;

    say "\nA($m, $n) = { ackermann($m, $n) } (recursions: $recursions with",
         $mem ?? '' !! 'out', ' memoization)';
}

sub ackermann
(
    UInt:D $m,
    UInt:D $n,
--> UInt:D
)
{
    ++$recursions;

    return $n + 1               if $m == 0;

    return ackermann($m - 1, 1) if $n == 0;

    return ackermann($m - 1, ackermann($m, $n - 1));
}

################################################################################

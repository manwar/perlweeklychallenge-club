#!perl

################################################################################
=comment

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

=cut
################################################################################

#--------------------------------------#
# Copyright © 2019 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use Const::Fast;
use Getopt::Long;
use Memoize;

const my @DEFAULT => (1, 2);

my $recs;

MAIN:
{
        $recs   = 0;
    my ($m, $n) = @DEFAULT;
    my  $mem    = 0;

    GetOptions
    (
        'm=i'    => \$m,
        'n=i'    => \$n,
         memoize => \$mem,

    ) or die "\nError in command line arguments\n";

    memoize('A') if $mem;

    printf "\nA(%d, %d) = %d (recursions: %d with%s memoization)\n",
            $m, $n, A($m, $n), $recs, $mem ? '' : 'out';
}

{
    no warnings 'recursion';

    sub A
    {
        my ($m, $n) = @_;

        ++$recs;

        return   $n + 1     if $m == 0;

        return A($m - 1, 1) if $n == 0;

        return A($m - 1, A($m, $n - 1));
    }
}

################################################################################

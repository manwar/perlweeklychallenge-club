#!perl

###############################################################################
=comment

Perl Weekly Challenge 172
=========================

TASK #1
-------
*Prime Partition*

Submitted by: Mohammad S Anwar

You are given two positive integers, $m and $n.

Write a script to find out the Prime Partition of the given number. No dupli-
cates allowed.

For example,

  Input: $m = 18, $n = 2
  Output: 5, 13 or 7, 11

  Input: $m = 19, $n = 3
  Output: 3, 5, 11

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Note
----
If there are no prime partitions of the required size, the output field is left
blank.

Algorithm
---------
1. Find P, the set of all prime numbers <= m
2. For each n-combination C of the elements of P:
   - find s, the sum of the elements of C
   - if s = m, record C as a prime n-partition of m
3. Output the results

Implementation
--------------
1. Prime numbers between 2 and m are found using the primes() routine from the
   CPAN module Math::Prime::Util (aka ntheory).
2. Combinations are found using the combinations() routine from the CPAN module
   Algorithm::Combinatorics.

Reference
---------
[1] "Partition (number theory)", Wikipedia,
     https://en.wikipedia.org/wiki/Partition_(number_theory)

=cut
#==============================================================================

use strict;
use warnings;
use Algorithm::Combinatorics qw( combinations );
use Const::Fast;
use Math::Prime::Util        qw( primes );
use Regexp::Common           qw( number );

const my $USAGE =>
"Usage:
  perl $0 <m> <n>

    <m>    Positive integer: the number to be partitioned
    <n>    Positive integer: the number of partitions required\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 172, Task #1: Prime Partition (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my ($m, $n) = parse_command_line();

    print "Input:  \$m = $m, \$n = $n\n";

    my @prime_parts;
    my $primes = primes( $m );

    if ($n <= scalar @$primes)
    {
        my $iter = combinations( $primes, $n );

        while (my $comb = $iter->next)
        {
            my $sum  = 0;
               $sum += $_ for @$comb;

            push @prime_parts, $comb if $sum == $m;
        }
    }

    printf "Output: %s\n",
        join ', ', map { '(' . join( ', ', @$_ ) . ')' } @prime_parts;
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;
       $args == 2
               or error( "Expected 2 command line arguments, found $args" );

    my ($m, $n) = @ARGV;

    for my $i ($m, $n)
    {
        $i =~ / ^ $RE{num}{int} $ /x
               or error( qq[Argument "$i" is not a valid integer] );

        $i > 0 or error( qq[Argument "$i" is not positive] );
    }

    return ($m, $n);
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################

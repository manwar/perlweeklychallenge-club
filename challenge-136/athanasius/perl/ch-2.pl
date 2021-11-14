#!perl

###############################################################################
=comment

Perl Weekly Challenge 136
=========================

TASK #2
-------
*Fibonacci Sequence*

Submitted by: Mohammad S Anwar

You are given a positive number $n.

Write a script to find how many different sequences you can create using
Fibonacci numbers where the sum of unique numbers in each sequence are the same
as the given number.

    Fibonacci Numbers: 1,2,3,5,8,13,21,34,55,89, …

Example 1

  Input:  $n = 16
  Output: 4

  Reason: There are 4 possible sequences that can be created using Fibonacci
  numbers i.e. (3 + 13), (1 + 2 + 13), (3 + 5 + 8) and (1 + 2 + 5 + 8).

Example 2

  Input:  $n = 9
  Output: 2

  Reason: There are 2 possible sequences that can be created using Fibonacci
  numbers i.e. (1 + 3 + 5) and (1 + 8).

Example 3

  Input:  $n = 15
  Output: 2

  Reason: There are 2 possible sequences that can be created using Fibonacci
  numbers i.e. (2 + 5 + 8) and (2 + 13).

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Interface
---------
Include the flag "--verbose" (or just "-v") on the command line to display an
explanation of the output.

Algorithm
---------
1. Find the set F of Fibonacci numbers less than or equal to $n
2. Calculate the power set P(F) of all subsets of F
3. For each subset S in P(F), sum the elements of S and add S to the solution
   set iff the sum equals $n

Note: This algorithm works well for smaller values of $n, but will not scale
well for larger values.

Implementation
--------------
Calculation of the power set is delegated to the subsets() subroutine of module
Algorithm::Combinatorics. See:
    https://rosettacode.org/wiki/Power_set#Module:_Algorithm::Combinatorics

=cut
#==============================================================================

use strict;
use warnings;
use Algorithm::Combinatorics qw( subsets );
use Const::Fast;
use Getopt::Long;
use Regexp::Common           qw( number );

const my $USAGE =>
"Usage:
  perl $0 [--verbose|-v] <n>

    --verbose    Explain the output?
    <n>          An integer > 0\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 136, Task #2: Fibonacci Sequence (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my ($verbose, $n) = parse_command_line();

    print "Input:  \$n = $n\n";

    my $seqs  = find_fib_seqs( $n );
    my $count = scalar @$seqs;

    print "Output: $count\n";

    if ($verbose)
    {
        if    ($count == 0)
        {
            print  "\nReason: There are no possible sequences summing to $n" .
                   "\n\tthat can be created using unique Fibonacci numbers\n";
        }
        elsif ($count == 1)
        {
            printf "\nReason: There is one possible sequence summing to %d"  .
                   "\n\tthat can be created using unique Fibonacci numbers:" .
                   "\n\t(%s)\n", $n, join ' + ', @{ $seqs->[ 0 ] };
        }
        else
        {
            printf "\nReason: There are %d possible sequences summing to %d" .
                   "\n\tthat can be created using unique Fibonacci numbers:\n",
                    $count, $n;

            printf "\t(%s)\n", join ' + ', @$_ for @$seqs;
        }
    }
}

#------------------------------------------------------------------------------
sub find_fib_seqs
#------------------------------------------------------------------------------
{
    my ($n)   = @_;
    my  @seqs;
    my  $fibs = get_fib_nums( $n );
    my  $iter = subsets( $fibs );

    while (my $p = $iter->next)
    {
        my $sum  = 0;
           $sum += $_ for @$p;

        push @seqs, $p if $sum == $n;
    }

    return \@seqs;
}

#------------------------------------------------------------------------------
sub get_fib_nums
#------------------------------------------------------------------------------
{
    my ($n)     = @_;
    my  @fibs   = (1);
    my ($x, $y) = (1, 1);

    while ($fibs[ -1 ] < $n)
    {
        my $z = $x + $y;
        push @fibs, $z;
        $x = $y;
        $y = $z;
    }

    pop @fibs if $fibs[ -1 ] > $n;

    return \@fibs;
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $verbose = 0;

    GetOptions( verbose => \$verbose )
              or error( 'Invalid command line flag' );

    my $args = scalar @ARGV;
       $args == 1
              or error( "Expected 1 command line argument, found $args" );

    my $n = $ARGV[ 0 ];

       $n =~ / ^ $RE{num}{int} $ /x
              or error( qq["$n" is not a valid integer] );

       $n > 0 or error( qq["$n" is not greater than zero] );

    return ($verbose, $n);
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################

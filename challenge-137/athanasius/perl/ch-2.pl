#!perl

###############################################################################
=comment

Perl Weekly Challenge 137
=========================

TASK #2
-------
*Lychrel Number*

Submitted by: Mohammad S Anwar

You are given a number, 10 <= $n <= 1000.

Write a script to find out if the given number is Lychrel number. To keep the
task simple, we impose the following rules:

 a. Stop if the number of iterations reached 500.
 b. Stop if you end up with number >= 10_000_000.

[UPDATED][2021-11-01 16:20:00]: If you stop because of any of the above two
rules then we expect 1 as an output.

According to [ https://en.wikipedia.org/wiki/Lychrel_number |wikipedia]:

A Lychrel number is a natural number that cannot form a palindrome through the
iterative process of repeatedly reversing its digits and adding the resulting
numbers.

Example 1

  Input: $n = 56
  Output: 0

  After 1 iteration, we found palindrome number.
  56 + 65 = 121

Example 2

  Input: $n = 57
  Output: 0

  After 2 iterations, we found palindrome number.
   57 +  75 = 132
  132 + 231 = 363

Example 3

  Input: $n = 59
  Output: 0

  After 3 iterations, we found palindrome number.
   59 +  95 =  154
  154 + 451 =  605
  605 + 506 = 1111

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Definitions
-----------
1. Let rev(N) be defined as the integer formed by reversing the digits of N (as
   represented in decimal notation). Where the least significant digit(s) of N
   are 0s (zeros), rev(N) has fewer digits than N. For example, rev(1200) =
   "0021" = 21.
2. Let an _Iteration_ be defined as the production of a new term from the
   previous term as follows: term[N+1] = term[N] + rev(term[N])
3. Let a Lychrel number be defined as a number N such that no finite series of
   _Iterations_ beginning with term[0] = N results in a term which is a
   palindrome.

Notes:

(i) "In base ten, no Lychrel numbers have been yet proved to exist, but many,
     including 196, are suspected on heuristic and statistical grounds."
     (Wikipedia). An output of 1 is therefore an indication that the given $n
     is *probably* a Lychrel number.

(ii) There is an ambiguity in the definition of Lychrel numbers: how are we to
     treat the degenerative case in which term[0] is a palindrome, but no
     term[x: x > 0] is a palindrome?

     (a) If a finite series of _Iterations_ is taken to mean *one or more*,
         then a palindromic N might be a Lychrel number (OEIS A088753)
     (b) Otherwise -- i.e., if a finite series is *zero or more* -- then a
         palindromic N is by definition NOT a Lychrel number (OEIS A023108).

     The first palindromic value of N to otherwise satisfy Definition 3 is
     9999. Since this is greater than the maximum value of 1000 specified in
     the Task Description, I have simply assumed interpretation (b) and
     included up-front a test to eliminate palindromic values of N as non-
     Lychrel numbers.

Interface
---------
By default, the solution below displays the result (0 = $n is not a Lychrel
number, 1 = $n is probably a Lychrel number) followed by an explanation of how
this result was reached. The explanation may be omitted by including the flag
--terse (or just -t) on the command line.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Getopt::Long;
use Regexp::Common qw( number );

const my $MIN_N    =>         10;
const my $MAX_N    =>      1_000;
const my $MAX_ITER =>        500;
const my $MAX_TERM => 10_000_000;
const my $USAGE    =>
"Usage:
  perl $0 [--terse|-t] <n>

    --terse    Omit the explanation?
    <n>        A decimal integer between 10 and 1000 inclusive\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 137, Task #2: Lychrel Number (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my ($n, $terse) = parse_command_line();

    print "Input:  \$n = $n\n";

    my $is_lychrel = 0;
    my $explanation;

    if (is_palindrome( $n ))
    {
        $explanation = '$n is already a palindrome';
    }
    else
    {
       ($is_lychrel, $explanation) = iterate( $n );
    }

    print "Output: $is_lychrel\n";

    print "\nExplanation: $explanation\n" unless $terse;
}

#------------------------------------------------------------------------------
sub iterate
#------------------------------------------------------------------------------
{
    my ($n)          =  @_;
    my  $is_lychrel  =  1;
    my  $explanation = "Reached the limit of $MAX_ITER iterations without " .
                       'finding a palindrome';
    my  $term        =  $n;

    for my $i (1 .. $MAX_ITER)
    {
        # Reverse then add

        my @digits  = split '', $term;
        my $reverse = join  '', reverse @digits;
           $term   += $reverse;

        if (is_palindrome( $term ))
        {
            $is_lychrel  = 0;
            $explanation = sprintf 'Palindrome %d found after %d iteration%s',
                                    $term, $i, $i == 1 ? '' : 's';
            last;
        }

        if ($term >= $MAX_TERM)
        {
            $explanation = sprintf 'Term %d too large after %d iteration%s',
                                    $term, $i, $i == 1 ? '' : 's';
            last;
        }
    }

    return ($is_lychrel, $explanation);
}

#------------------------------------------------------------------------------
sub is_palindrome
#------------------------------------------------------------------------------
{
    my ($n)      = @_;
    my  @digits  = split '', $n;
    my  $reverse = join  '', reverse @digits;

    return $reverse == $n;
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $terse = 0;

    GetOptions( terse => \$terse )
                  or error( 'Invalid command line flag' );

    my $args = scalar @ARGV;
       $args == 1 or error( "Expected 1 command line argument, found $args" );

    my $n = $ARGV[ 0 ];

    $n =~ / ^ $RE{num}{int} $ /x
                  or error( qq["$n" is not a valid integer] );

    $n >= $MIN_N  or error( "$n is too small (must be >= $MIN_N)" );
    $n <= $MAX_N  or error( "$n is too large (must be <= $MAX_N)" );

    return ($n, $terse);
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################

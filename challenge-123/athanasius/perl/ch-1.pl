#!perl

###############################################################################
=comment

Perl Weekly Challenge 123
=========================

TASK #1
-------
*Ugly Numbers*

Submitted by: Mohammad S Anwar

You are given an integer $n >= 1.

Write a script to find the $nth element of Ugly Numbers.

        Ugly numbers are those number whose prime factors are 2, 3 or 5. For
        example, the first 10 Ugly Numbers are 1, 2, 3, 4, 5, 6, 8, 9, 10, 12.

Example

 Input: $n = 7
 Output: 8

 Input: $n = 10
 Output: 12

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Definition and Algorithm
------------------------
So-called "ugly numbers", more correctly 5-smooth, regular, or Hamming numbers,
are positive integers of the form:

    2^i × 3^j × 5^k     where i, j, k are integers ≥ 0

The set H of all Hamming numbers can be defined inductively:
    (1) 1 ∊ H                                                [Base case]
    (2) (∀n)(n ∊ H → (2n ∊ H ∧ 3n ∊ H ∧ 5n ∊ H))             [Inductive clause]
    (3) H is the intersection of all sets satisfying (1) and (2)
                                                             [Extremal  clause]

This gives a straightforward method for producing the set of Hamming numbers:

    Let H = { 1 }
    Repeat:
      For each element h of H not previously processed, add 2h, 3h, and 5h to H

The drawback of this method is that it generates Hamming numbers out of order,
and adds duplicates:

    Correct (sorted) order: 1, 2, 3, 4, 5, 6,  8, 9, 10, 12 ...
    Generated order:        1, 2, 3, 5, 4, 6, 10, 6,  9, 15, 8, 12, 20 ...

This can be remedied by filtering candidate values of h as follows:
 (a) ensure that the next h is always the *smallest* of the remaining (unused)
     Hamming numbers generated so far; and
 (b) remember the last value of h, and discard the next candidate if it's a
     duplicate
The order in which h values are *selected* for processing is the correct (i.e.,
sorted) order of the Hamming numbers.

In the implementation below, the CPAN module Array::Heap is used to store the
pool of Hamming numbers generated so far (i.e., the candidate values of h).
Because heap elements are stored in priority order (the smallest value has the
highest priority), the pop_heap() function  always returns the smallest
candidate, thereby satisfying condition (a).

References
----------
Mark Jason Dominus, "Infinite lists in Perl",
    https://perl.plover.com/Stream/stream.html (28 July, 2021)

N. J. A. Sloane, editor, The On-Line Encyclopedia of Integer Sequences,
    "A051037  5-smooth numbers, i.e., numbers whose prime divisors are all <=
     5.", https://oeis.org/A051037 (28 July, 2021)

Wikipedia, "Regular Number",
    https://en.wikipedia.org/wiki/Regular_number (28 July, 2021)

=cut
#==============================================================================

use strict;
use warnings;
use Array::Heap;
use Const::Fast;
use Regexp::Common qw( number );

const my $USAGE =>
"Usage:
  perl $0 <n>

    <n>    A non-zero positive integer\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 123, Task #1: Ugly Numbers (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $n = parse_command_line();

    print "Input:  \$n = $n\n";

    my @heap   = 1;
    my $last_h = 0;
    my $count  = 0;
    my $hamming;

    while ($count++ < $n)
    {
        do
        {
            $hamming = pop_heap @heap;

        } while ($hamming == $last_h);                     # Discard duplicates

        $last_h = $hamming;

        push_heap @heap, $_ * $hamming for 2, 3, 5;
    }

    printf "Output: %d\n", $hamming;
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;
       $args == 1 or error( "Expected 1 command line argument, found $args" );

    my $n = $ARGV[ 0 ] + 0;    # Normalize

       $n =~ / ^ $RE{num}{int} $ /x
                  or error( qq["$n" is not a valid integer] );

       $n >= 1    or error( qq["$n" is too small] );

    return $n;
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################

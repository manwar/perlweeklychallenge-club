#!perl

###############################################################################
=comment

Perl Weekly Challenge 157
=========================

TASK #2
-------
*Brazilian Number*

Submitted by: Mohammad S Anwar

You are given a number $n > 3.

Write a script to find out if the given number is a Brazilian Number.

    A positive integer number N has at least one natural number B where 1 < B <
    N-1 where the representation of N in base B has same digits.

Example 1:

  Input: $n = 7
  Output: 1

  Since 7 in base 2 is 111.

Example 2:

  Input: $n = 6
  Output: 0

  Since 6 in base 2 is 110,
        6 in base 3 is 30 and
        6 in base 4 is 12.

Example 3:

  Input: $n = 8
  Output: 1

  Since 8 in base 3 is 22.

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Interface
---------
1. If the $SHORTCUT constant (false by default) is set to a true value, an even
   number 8 or above will be automatically identified as a Brazilian Number,
   and the verbose output (if enabled) will report that it is 22 in base (N/2 -
   1). From [2]:

     "All even integers 2p >=8 are Brazilian numbers (A125134), because
      2p=2(p-1)+2 is written 22 in base p-1 if p-1>2, that is true if p >=4."

2. If the $VERBOSE constant is set to a true value (the default), the output is
   followed by an explanation. If N is a Brazilian Number, this is proven by
   showing N as a repdigit in a base B in the range 1 < B < n-1. If N is not a
   Brazilian Number, this is spelled out but not proven, because enumeration of
   N's value in all possible bases would be impractical for large values of N.

3. For bases greater than 10, it is customary to represent digit values of 10
   and above using letters. However, this does not work for bases greater than
   95, as there are only 95 printable ASCII characters. I have chosen to
   instead represent these digits using decimal numbers, as in IP4 addresses.
   For bases above 10, the digits are separated by dot characters. For example,
   the decimal number 1,000 is a repdigit in base 39, and is represented as
   "25.25".

Algorithm
---------
For each base B in the range 1 < B < N-1, N's representation in B is tested: if
it is a repdigit, N is known to be a Brazilian Number and the search ends.
Otherwise, the search continues until all possible bases have been tried.

For further investigation: there may be considerable scope for optimization by
reducing the range of bases to search.

Subroutine repdigit_in_base() tests whether a given integer N is a repdigit in
a given base B. Let the representation of N in base B be denoted n_base.
1. A table of powers of B is created, until the last power is greater than n.
2. n is divided by p, the largest power of B less than or equal to n, and the
   result of this integer division is stored as d0, the most significant digit
   of n_base. R, the remaining part of n to be represented, is calculated by
   subtracting d0 * p from n.
3. The process is repeated, dividing R by the next lower power of B, until
   either:
    (i) the latest digit found is not equal to d0, in which case n_base is now
        known to NOT be a repdigit, and the subroutine returns the empty string
   (ii) the powers of B are exhausted, in which case n_base IS a repdigit and
        the subroutine returns a string representation of the repdigit.

References
----------
[1] 'A125134  "Brazilian" numbers...', OEIS, https://oeis.org/A125134
[2] 'A257521  Odd Brazilian numbers.', OEIS, https://oeis.org/A257521
[3] 'Repdigit', Wikipedia, https://en.wikipedia.org/wiki/Repdigit

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );

const my $SHORTCUT => 0;
const my $VERBOSE  => 1;
const my $USAGE    =>
"Usage:
  perl $0 <n>

    <n>    A natural number greater than 3\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 157, Task #2: Brazilian Number (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $n = parse_command_line();

    print "Input:  \$n = $n\n";

    my  $end_range    = $n - 2;
    my  $is_brazilian = 0;
    my ($base, $n_base)                                            if $VERBOSE;

    if ($SHORTCUT && $n % 2 == 0 && $n >= 8)
    {
        $is_brazilian   = 1;
       ($base, $n_base) = ($n / 2 - 1, '22')                       if $VERBOSE;
    }
    else
    {
        for my $b (2 .. int($n / 2))
        {
            if (my $nb = repdigit_in_base( $n, $b ))
            {
                $is_brazilian   =  1;
               ($base, $n_base) = ($b, $nb)                        if $VERBOSE;
                last;
            }
        }
    }

    printf "Output: %d\n",    $is_brazilian ? 1 : 0;
    printf "\nSince $n %s\n", $is_brazilian ? "in base $base is $n_base" :
           "is not a repdigit in any base in the range 2 to $end_range"
                                                                   if $VERBOSE;
}

#------------------------------------------------------------------------------
sub repdigit_in_base
#------------------------------------------------------------------------------
{
    my  ($n, $base) = @_;
    my   @powers    = (1);
    push @powers, $powers[ -1 ] * $base while $powers[ -1 ] <= $n;
    my   $remainder = $n;
    my   @n_base;

    for my $i (reverse( 0 .. $#powers - 1 ))
    {
        my $digit = int( $remainder / $powers[ $i ] );
        push @n_base, $digit;

        return '' if $digit != $n_base[ 0 ];

        $remainder -= $digit * $powers[ $i ];
    }

    return join +($base < 10 ? '' : '.'), @n_base;
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;
       $args == 1 or error( "Expected 1 command line argument, found $args" );

    my $n = $ARGV[ 0 ];

    $n =~ / ^ $RE{num}{int} $ /x
                  or error( qq["$n" is not a valid integer] );

    $n > 3        or error( 'n must be greater than 3' );

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

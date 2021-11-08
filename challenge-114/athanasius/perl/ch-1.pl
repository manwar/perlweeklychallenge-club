#!perl

###############################################################################
=comment

Perl Weekly Challenge 114
=========================

TASK #1
-------
*Next Palindrome Number*

Submitted by: Mohammad S Anwar

You are given a positive integer $N.

Write a script to find out the next Palindrome Number higher than the given
integer $N.

Example

 Input: $N = 1234
 Output: 1331

 Input: $N = 999
 Output: 1001

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Algorithm
---------

Let N have digits abc...klm[n]opq...xyz, where m is the middle digit (if N has
an odd number of digits), or the first of 2 middle digits mn (if N has an even
number of digits).

First, we form the palindromic number S:

    S = abc...klm[m]lk...cba

by reversing the first (i.e., left, or most significant) half of N's digits. If
S > N, it must be the solution since it has been constructed as the smallest
palindromic number > N.

If S <= N, it will be necessary to increment one of the digits abc...klm. To
form the smallest number, we begin with the the least significant digit, namely
m. If m < 9, M = m + 1 is guaranteed to produce a palindromic number T greater
than N but smaller than any other palindromic number greater than N:

    T = abc...klM[M]lk...cba

If m = 9, we set m = 0 and increment l (L = l + 1) to form U:

    U = abc...kL0[0]Lk...cba

But if L is also 9, we increment k; and so on down to c, b, a. Finally, if a
solution has still not been found and a is also 9, we need to construct a new
palindromic number V with one more digit than N. The smallest such palindromic
number has the form:

    V = 1000...0001

with the first and last digits set to 1 and all other digits set to 0.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );

const my $USAGE =>
"Usage:
  perl $0 <N>

    <N>    A positive integer\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 114, Task #1: Next Palindrome Number (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $N        = parse_command_line();

    print "Input: \$N = $N\n";

    my @digits   = split //, $N;
    my $num_digs = scalar @digits;
    my $is_even  = $num_digs % 2 == 0;
    my $mid_i    = int( ($num_digs / 2) + ($is_even ? -0.5 : 0) );
    my $mid_j    = $is_even ? $mid_i : $mid_i - 1;
    my @mirror   = ( @digits[ 0 .. $mid_i ], reverse @digits[ 0 .. $mid_j ] );
    my $solution = join '', @mirror;

    if ($solution <= $N)
    {
        for my $i (reverse 0 .. $mid_i)
        {
            my $j = $#digits - $i;

            if (++$mirror[ $i ] > 9)
            {
                $mirror[ $i ] = $mirror[ $j ] = 0;
            }
            else
            {
                $mirror[ $j ] = $mirror[ $i ];
                last;
            }
        }

        $solution = ($mirror[ 0 ] == 0) ? '1' . '0' x ($num_digs - 1) . '1'
                                        :  join '', @mirror;
    }

    print "Output:     $solution\n";
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;
       $args == 1 or error( "Expected 1 command line argument, found $args" );

    my $N = $ARGV[0] + 0;                     # Normalize (e.g. 010 becomes 10)

    $N =~ / ^ $RE{num}{int} $ /x
                  or error( qq["$N" is not an integer] );
    $N >= 0       or error( qq["$N" is not positive] );

    return $N;
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################

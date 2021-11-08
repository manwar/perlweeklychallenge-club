#!perl

###############################################################################
=comment

Perl Weekly Challenge 116
=========================

TASK #2
-------
*Sum of Squares*

Submitted by: Mohammad Meraj Zia

You are given a number $N >= 10.

Write a script to find out if the given number $N is such that sum of squares
of all digits is a perfect square. Print 1 if it is otherwise 0.

Example

 Input: $N = 34
 Output: 1 as 3^2 + 4^2 => 9 + 16 => 25 => 5^2

 Input: $N = 50
 Output: 1 as 5^2 + 0^2 => 25 + 0 => 25 => 5^2

 Input: $N = 52
 Output: 0 as 5^2 + 2^2 => 25 + 4 => 29

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Input Argument $N
-----------------
Although it is probably intended that $N be an integer, this is not explicitly
stated in the Task Description and is not really necessary. This script accepts
any real number >= 10, and includes any digits following the decimal point
along with the digits that come before. The decimal point (if any) is ignored.
For example:

    Input:  $N = 14.22
    Output: 1 as 1^2 + 4^2 + 2^2 + 2^2 = 1 + 16 + 4 + 4 = 25 = 5^2

Output
------
The required output (1 or 0) is followed by an explanation as per the Examples.
If this explanation is not wanted, the constant $SHOW should be set to a false
value.

Algorithm
---------
This is straightforward: split $N into its component digits, square each digit,
and sum the squares. The sum is itself a perfect square if and only if its
square root is an integer.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );

const my $SHOW  => 1;
const my $USAGE =>
"Usage:
  perl $0 <N>

    <N>    A number greater than or equal to 10\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 116, Task #2: Sum of Squares (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $N       = parse_command_line();

    print "Input:  \$N = $N\n";

    my @digits  = grep { !/\./ } split //, $N;
    my @squares = map { $_ * $_ } @digits;
    my $sum     = 0;
       $sum    += $_ for @squares;
    my $root    = perfect_square_root( $sum );

    printf 'Output: %d', $root ? 1 : 0;

    if ($SHOW)
    {
        my $terms   = join ' + ', map { "$_^2" } @digits;
        my $squares = join ' + ',                @squares;

        print ' as ' . join( ' = ', $terms, $squares, $sum ) . 
              ($root ? " = $root^2" : ' which is not a perfect square');
    }

    print "\n";
}

#------------------------------------------------------------------------------
sub perfect_square_root
#------------------------------------------------------------------------------
{
    my ($N)   = @_;
    my  $root = int( sqrt( $N ) + 0.5 );

    # Return the square root if $N is a perfect square, or undef otherwise

    return ($root * $root) == $N ? $root : undef;
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;
       $args == 1 or error( "Expected 1 command line argument, found $args" );

    my $N = $ARGV[ 0 ];
       $N =~ / ^ $RE{num}{real} $ /x
                  or error( qq["$N" is not a valid real number] );
       $N +=  0;                                  # Normalize: e.g., 010 --> 10
       $N >= 10   or error( "$N is less than 10" );

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

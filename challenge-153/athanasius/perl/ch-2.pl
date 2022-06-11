#!perl

###############################################################################
=comment

Perl Weekly Challenge 153
=========================

TASK #2
-------
*Factorions*

Submitted by: Mohammad S Anwar

You are given an integer, $n.

Write a script to figure out if the given integer is factorion.

    A factorion is a natural number that equals the sum of the factorials of
    its digits.

Example 1:

 Input: $n = 145
 Output: 1

     Since 1! + 4! + 5! => 1 + 24 + 120 = 145

Example 2:

 Input: $n = 125
 Output: 0

     Since 1! + 2! + 3! => 1 + 2 + 6 <> 123

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Output
------
If the constant $VERBOSE is set to a true value (the default), an explanation
like those given in the Examples is added to the output.

Algorithm
---------
Using a look-up for the factorials of numbers 0 to 9 [1], the factorials of the
digits of $n are summed and the result compared with $n.

Reference
---------
[1] Wikipedia article "Factorial" (https://en.wikipedia.org/wiki/Factorial)

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );

const my %FACTORIAL => (0 =>       1,
                        1 =>       1,
                        2 =>       2,
                        3 =>       6,
                        4 =>      24,
                        5 =>     120,
                        6 =>     720,
                        7 =>   5_040,
                        8 =>  40_320,
                        9 => 362_880);
const my $VERBOSE   =>  1;
const my $USAGE     =>
"Usage:
  perl $0 <n>

    <n>    An integer\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 153, Task #2: Factorions (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $n      = parse_command_line();
    my $sign   = $n >= 0 ? 1 : -1;
    my $n_abs  = $n =~ s/ ^ [+-] //rx;          # Remove initial sign  (if any)
       $n_abs *= 1;                             # Remove initial zeros (if any)

    printf "Input:  \$n = %d\n", $n_abs * $sign;

    my @digits   = split '', $n_abs;
    my $sum      = 0;
       $sum     += $_ for map { $FACTORIAL{ $_ } } @digits;
    my $is_factn = $sum == $n;

    printf "Output: %d\n", $is_factn ? 1 : 0;

    if ($VERBOSE)
    {
        if (length $n_abs == 1)
        {
            printf "\n    Since %s! = %d\n", $n_abs, $sum;
        }
        else
        {
            printf "\n    Since %s! = %s = %d\n", join( '! + ', @digits ),
                join( ' + ', map { $FACTORIAL{ $_ } } @digits ), $sum;
        }
    }
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;
       $args == 1 or error( "Expected 1 command line argument, found $args" );

    my $n = $ARGV[ 0 ];

    $n =~ / ^ $RE{num}{int} $ /x
                  or error( qq["$_" is not a valid integer] );

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

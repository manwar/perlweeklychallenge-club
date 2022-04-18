#!perl

###############################################################################
=comment

Perl Weekly Challenge 160
=========================

TASK #1
-------
*Four Is Magic*

Submitted by: Mohammad S Anwar

You are given a positive number, $n < 10.

Write a script to generate english text sequence starting with the English
cardinal representation of the given number, the word 'is' and then the English
cardinal representation of the count of characters that made up the first word,
followed by a comma. Continue until you reach four.

Example 1:

  Input: $n = 5
  Output: Five is four, four is magic.

Example 2:

  Input: $n = 7
  Output: Seven is five, five is four, four is magic.

Example 3:

  Input: $n = 6
  Output: Six is three, three is five, five is four, four is magic.

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Assumption
----------
I take "a positive number" < 10 to be an integer in the range 0 to 9 inclusive.
(Should an input of zero be allowed? The answer depends on one's definition of
"positive". I interpret "positive" here as "non-negative", and therefore allow
zero as an input value.)

Output
------
What should the output be when $n = 4? Taking the Task description literally,
it should be: "Four is four, four is magic.", but this seems redundant. Since
there is no obviously correct answer to this question, I give the longer output
as the default, but provide the constant $SHORT: if it is set to a true value,
the output is shortened to just "Four is magic." when $n = 4.

Algorithm
---------
Since there are only 10 cases to consider, I've pre-computed the word lengths:
the name and length of each digit are stored against that digit's index in the
constant array @DIGITS.

The algorithm proceeds by finding the length of the current number's name in
characters (by table lookup) and printing that number's name, "is", the name of
that number's length, and a comma. That length then becomes the current number,
and the process repeats until the current number is 4, at which point the
algorithm ends by printing "four is magic."

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );

const my @DIGITS =>
(
    [ zero => 4 ], [ one => 3 ], [ two   => 3 ], [ three => 5 ], [ four => 4 ],
    [ five => 4 ], [ six => 3 ], [ seven => 5 ], [ eight => 5 ], [ nine => 4 ],
);
const my $MAX    => 9;
const my $SHORT  => 0;                # Print just "Four is magic." when $n = 4
const my $USAGE  =>
"Usage:
  perl $0 <n>

    <n>    An integer between 0 and $MAX inclusive\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 160, Task #1: Four Is Magic (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $n = parse_command_line();

    print "Input:  \$n = $n\n";

    if ($SHORT && $n == 4)
    {
        print  "Output: Four is magic.\n";
    }
    else
    {
        my $name   = $DIGITS[ $n ][ 0 ];
        my $length = $DIGITS[ $n ][ 1 ];

        printf "Output: %s is %s, ", ucfirst( $name ), $DIGITS[ $length ][ 0 ];

        until ($length == 4)
        {
            $name   = $DIGITS[ $length ][ 0 ];
            $length = $DIGITS[ $length ][ 1 ];

            printf "%s is %s, ", $name, $DIGITS[ $length ][ 0 ];
        }

        print "four is magic.\n";
    }
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;
       $args == 1 or error( "Expected 1 command line argument, found $args" );

    my $n =  $ARGV[ 0 ];

       $n =~ / ^ $RE{num}{int} $ /x
                  or error( qq["$n" is not a valid integer] );

       $n >= 0    or error( 'n must be greater than or equal to 0' );
       $n <= $MAX or error( "n must be less than $MAX" );

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

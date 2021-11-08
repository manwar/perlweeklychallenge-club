#!perl

###############################################################################
=comment

Perl Weekly Challenge 118
=========================

TASK #1
-------
*Binary Palindrome*

Submitted by: Mohammad S Anwar

You are given a positive integer $N.

Write a script to find out if the binary representation of the given integer is
Palindrome. Print 1 if it is otherwise 0.

Example

 Input: $N = 5
 Output: 1 as binary representation of 5 is 101 which is Palindrome.

 Input: $N = 4
 Output: 0 as binary representation of 4 is 100 which is NOT Palindrome.

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Algorithm
---------

1. Convert $N to binary using sprintf '%b' -- see:
   https://perldoc.perl.org/perlfaq4#How-do-I-convert-between-numeric-
   representations%2Fbases%2Fradixes%3F

2. Determine whether the binary representation of $N is a palindrome or not by
   comparing the first digit with the last, the second digit with the second-
   last, and so on. (The middle digit, if any, is ignored.)

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
    print "\nChallenge 118, Task #1: Binary Palindrome (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $N = parse_command_line();

    print "Input:  \$N = $N\n";

    # Make an array of the digits in the binary representation of $N

    my @binary = split '', sprintf( '%b', $N );

    # Assume the binary representation is a palindrome unless and until we find
    # a non-matched pair of binary digits (counting inwards from either end)

    my $is_palindrome = 1;

    for my $i (0 .. int( scalar @binary / 2 ))
    {
        if ($binary[ $i ] ne $binary[ $#binary - $i ])
        {
            $is_palindrome = 0;
            last;
        }
    }

    printf "Output: %d as the binary representation of %d is %s\n" .
           "          which is %sa palindrome\n",
        $is_palindrome ?  1 :    0,  $N,  join( '', @binary ),
        $is_palindrome ? '' : 'NOT ';
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;
       $args == 1 or error( "Expected 1 command line argument, found $args" );

    my $N = $ARGV[ 0 ];
       $N =~ / ^ $RE{num}{int} $ /x
                  or error( qq["$N" is not a valid integer] );
       $N += 0;                                   # Normalize: e.g., 010 --> 10
       $N >= 0    or error( "$N is less than 0" );

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

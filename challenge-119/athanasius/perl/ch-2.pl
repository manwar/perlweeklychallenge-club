#!perl

###############################################################################
=comment

Perl Weekly Challenge 119
=========================

TASK #2
-------
*Sequence without 1-on-1*

Submitted by: Cheok-Yin Fung

Write a script to generate sequence starting at 1. Consider the increasing
sequence of integers which contain only 1’s, 2’s and 3’s, and do not have any
doublets of 1’s like below. Please accept a positive integer $N and print the
$Nth term in the generated sequence.

    1, 2, 3, 12, 13, 21, 22, 23, 31, 32, 33, 121, 122, 123, 131, …

Example

 Input: $N = 5
 Output: 13

 Input: $N = 10
 Output: 32

 Input: $N = 60
 Output: 2223

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Algorithm
---------
1. Generate the series *with* doublets of '1' digits by:
   (a) Producing each successive term by incrementing the previous term by 1.
   (b) Converting any '4' digit that results to a 1 with a left-carry. This
       conversion continues from least- to most-significant digit until all of
       the '4' digits have been eliminated.
2. Filter out any term that contains adjacent 1 digits.
3. Continue until the number of terms generated equals $N. The final term to be
   generated is the solution.

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
    print "\nChallenge 119, Task #2: Sequence without 1-on-1 (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $N = parse_command_line();

    print "Input:  \$N = $N\n";

    my $term = generate_series( $N );

    print "Output: $term\n";
}

#------------------------------------------------------------------------------
sub generate_series
#------------------------------------------------------------------------------
{
    my ($N)    = @_;
    my  $term  = 1;
    my  $terms = 1;

    while ($terms < $N)           # Continue until $N terms have been generated
    {
        if (++$term =~ /4/)       # Handle overflow: 4 -> (+1)1
        {
            my @digits = split //, $term;

            for my $i (reverse( 1 .. $#digits ))
            {
                if ($digits[ $i ] == 4)
                {
                    $digits[ $i     ] = 1;
                  ++$digits[ $i - 1 ];
                }
            }

            if ($digits[ 0 ] ==  4)
            {
                $digits[ 0 ]  =  1;
                unshift @digits, 1;
            }

            $term = join '', @digits;
        }

        ++$terms unless $term =~ /11/;       # Filter out terms containing '11'
    }

    return $term;
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;
       $args == 1 or error( "Expected 1 command line argument, found $args" );

    my $N =  $ARGV[ 0 ];
       $N =~ / ^ $RE{num}{int} $ /x
                  or error( qq["$N" is not a valid integer] );
       $N += 0;                                   # Normalize: e.g., 010 --> 10
       $N >  0    or error( "$N is not greater than 0" );

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

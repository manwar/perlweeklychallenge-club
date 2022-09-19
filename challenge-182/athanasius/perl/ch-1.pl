#!perl

###############################################################################
=comment

Perl Weekly Challenge 182
=========================

TASK #1
-------
*Max Index*

Submitted by: Mohammad S Anwar

You are given a list of integers.

Write a script to find the index of the first biggest number in the list.

Example

  Input: @n = (5, 2, 9, 1, 7, 6)
  Output: 2 (as 3rd element in the list is the biggest number)


  Input: @n = (4, 2, 3, 1, 5, 0)
  Output: 4 (as 5th element in the list is the biggest number)

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Configuration
-------------
Set the constant $VERBOSE to a true value to add an explanation to the output,
as per the Examples.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );

const my $VERBOSE => 1;
const my $USAGE   =>
"Usage:
  perl $0 [<n> ...]

    [<n> ...]    A non-empty list of integers\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 182, Task #1: Max Index (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my @n = parse_command_line();

    printf "Input:  \@n = (%s)\n", join ', ', @n;

    my ($index, $max) = (0, $n[ 0 ]);

    for my $i (1 .. $#n)
    {
        if ($n[ $i ] > $max)
        {
            $index = $i;
            $max   = $n[ $i ];
        }
    }

    if ($VERBOSE)
    {
        printf 'Output: %d (as %d, the %s element in the list, is the ' .
               "largest)\n", $index, $max, ordinal( $index + 1 );
    }
    else
    {
        print  "Output: $index\n";
    }
}

#------------------------------------------------------------------------------
sub ordinal
#------------------------------------------------------------------------------
{
    my ($n)     = @_;
    my  $ones   = $n % 10;
    my  $tens   = int( $n / 10 ) % 10;
    my  $suffix = $tens == 1 ? 'th' :
                  $ones == 1 ? 'st' :
                  $ones == 2 ? 'nd' :
                  $ones == 3 ? 'rd' : 'th';

    return $n . $suffix;
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    scalar @ARGV > 0 or error( 'No command line arguments found' );

    for my $n (@ARGV)
    {
        $n =~ / ^ $RE{num}{int} $ /x
                     or error( qq["$n" is not a valid integer] );
    }

    return @ARGV;
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################

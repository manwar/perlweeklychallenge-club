#!perl

###############################################################################
=comment

Perl Weekly Challenge 108
=========================

TASK #2
-------
*Bell Numbers*

Submitted by: Mohammad S Anwar

Write a script to display top 10 *Bell Numbers*. Please refer to
[ https://en.wikipedia.org/wiki/Bell_number |wikipedia page] for more informa-
tions.

Example:

B0: 1 as you can only have one partition of zero element set
B1: 1 as you can only have one partition of one element set {a}.
B2: 2
       {a}{b}
       {a,b}
B3: 5
       {a}{b}{c}
       {a,b}{c}
       {a}{b,c}
       {a,c}{b}
       {a,b,c}
B4: 15
       {a}{b}{c}{d}
       {a,b,c,d}
       {a,b}{c,d}
       {a,c}{b,d}
       {a,d}{b,c}
       {a,b}{c}{d}
       {a,c}{b}{d}
       {a,d}{b}{c}
       {b,c}{a}{d}
       {b,d}{a}{c}
       {c,d}{a}{b}
       {a}{b,c,d}
       {b}{a,c,d}
       {c}{a,b,d}
       {d}{a,b,c}

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Algorithm
---------
From OEIS A000110: Bell or exponential numbers...

"Triangle (addition) scheme to produce terms, derived from the recurrence, from
Oscar Arevalo (loarevalo(AT)sbcglobal.net), May 11 2005:
    1
    1  2
    2  3  5
    5  7 10 15
   15 20 27 37 52
   ..."

(1) The first row contains the number 1 only
(2) The first number of each new row is the last number of the previous row
(3) The remaining numbers in the row are calculated as follows:
        entry[i][j] = entry[i][j-1] + entry[i-1][j-1]
    where i is the row number and j is the column number

Command Line Argument
---------------------
Although the Task is to display the "top 10 Bell Numbers" -- which I interpret
to mean the *first* 10 Bell Numbers -- the implementation below allows the user
to (optionally) specify the number of Bell Numbers to calculate. If no number
is provided, it defaults to 10.

Note on "use bigint"
--------------------
This pragma is included to facilitate the calculation of a larger number of
Bell Numbers than the 10 required for the Task. Its inclusion does not appreci-
ably impact performance.

=cut
#==============================================================================

use strict;
use warnings;
use bigint;
use Const::Fast;
use Regexp::Common qw( number );

const my $TARGET => 10;
const my $USAGE  =>
"Usage:
  perl $0 [<target>]

    [<target>]    How many Bell numbers are to be displayed?\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 108, Task #2: Bell Numbers (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $target   =  parse_command_line();
    my $row      =  0;
    my @triangle = [1];

    if ($target == 1)
    {
        printf "The first Bell number:\n    B0: %d\n", $triangle[0][0];
    }
    else
    {
        for (2 .. $target - 1)
        {
            $triangle[$row + 1] = [ $triangle[$row][$row] ];

            for my $col (1 .. ++$row)
            {
                push $triangle[$row    ]->@*,
                     $triangle[$row    ][$col - 1] +
                     $triangle[$row - 1][$col - 1];
            }
        }

        my   @bell;
        push @bell, $triangle[$_][ 0] for 0 .. $#triangle;
        push @bell, $triangle[-1][-1];

        print "The first $target Bell numbers:\n";

        my $i_width = length( $target - 1 );

        for my $i (0 .. $target - 1)
        {
            print "    B$i: ", ' ' x ($i_width - length $i), $bell[$i], "\n";
        }
    }
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;

    0 <= $args <= 1
        or error( "Expected 0 or 1 command line arguments, found $args" );

    my $target = ($args == 1) ? $ARGV[0] : $TARGET;

    $target =~ / ^ $RE{num}{int} $ /x
        or error( qq["$target" is not an integer] );

    $target > 0
        or error( 'The target must be greater than zero' );

    return $target;
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################

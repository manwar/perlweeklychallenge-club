#!perl

###############################################################################
=comment

Perl Weekly Challenge 109
=========================

TASK #2
-------
*Four Squares Puzzle*

Submitted by: Mohammad S Anwar

You are given four squares as below with numbers named a,b,c,d,e,f,g.

              (1)                    (3)
        ╔══════════════╗      ╔══════════════╗
        ║              ║      ║              ║
        ║      a       ║      ║      e       ║
        ║              ║ (2)  ║              ║  (4)
        ║          ┌───╫──────╫───┐      ┌───╫─────────┐
        ║          │   ║      ║   │      │   ║         │
        ║          │ b ║      ║ d │      │ f ║         │
        ║          │   ║      ║   │      │   ║         │
        ║          │   ║      ║   │      │   ║         │
        ╚══════════╪═══╝      ╚═══╪══════╪═══╝         │
                   │       c      │      │      g      │
                   │              │      │             │
                   │              │      │             │
                   └──────────────┘      └─────────────┘

Write a script to place the given unique numbers in the square box so that sum
of numbers in each box is the same.

Example

 Input: 1,2,3,4,5,6,7

 Output:

     a = 6
     b = 4
     c = 1
     d = 5
     e = 2
     f = 3
     g = 7

     Box 1: a + b = 6 + 4 = 10
     Box 2: b + c + d = 4 + 1 + 5 = 10
     Box 3: d + e + f = 5 + 2 + 3 = 10
     Box 4: f + g = 3 + 7 = 10

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Algorithm
---------
A sequence of 7 unique numbers can be arranged in 7! = 5040 different ways. For
a computer, that is a small search space; therefore, the algorithm used is a
simple search.

Note that a given input of 7 numbers may produce zero solutions, or many:

    Input                               Solutions
     1,   2, 3,   4, 5,   6,  7             8
     1,   2, 3,   4, 5,   6, 17             0
    -1.5, 0, 1.5, 3, 4.5, 6,  7.5          10

=cut
#==============================================================================

use strict;
use warnings;
use Algorithm::Loops qw( NextPermute );
use Const::Fast;
use List::Util       qw( uniqnum );
use Regexp::Common   qw( number );

const my $ARGUMENTS => 7;
const my $USAGE     =>
"Usage:
  perl $0 -- Default: 1 .. 7
  perl $0 [<numbers> ...]

    [<numbers> ...]    A list of 7 unique real numbers\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 109, Task #2: Four Squares Puzzle (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my @numbers = parse_command_line();

    printf "Input: %s\n\nOutput:\n\n", join ', ', @numbers;

       @numbers   = sort { $a <=> $b } @numbers;
    my $solutions = 0;

    do
    {{
        my ($a, $b, $c, $d, $e, $f, $g) = @numbers;
        my  $box1 = $a + $b;

        next unless $b + $c + $d == $box1 &&
                    $d + $e + $f == $box1 &&
                    $f + $g      == $box1;

        ++$solutions;

        print "  Solution $solutions: a = $a, b = $b, c = $c, d = $d, " .
              "e = $e, f = $f, g = $g\n    Each box sums to $box1\n\n";

    }} while (NextPermute( @numbers ));

    printf "  %s solution%s found\n", $solutions == 0 ? 'No' : $solutions,
                                      $solutions == 1 ? ''   : 's';
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;

    $args == 0 || $args == $ARGUMENTS
            or error( "Expected 0 or $ARGUMENTS command line arguments, " .
                      "found $args" );

    my @numbers = ($args == 0) ? 1 .. $ARGUMENTS : @ARGV;

    for (@numbers)
    {
        / ^ $RE{num}{real} $ /x
            or error( qq["$_" is not a real number] );
    }

    scalar uniqnum( @numbers ) == $ARGUMENTS
            or error( 'The arguments must be unique' );

    return @numbers;
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################

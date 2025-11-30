#!perl

################################################################################
=comment

Perl Weekly Challenge 349
=========================

TASK #2
-------
*Meeting Point*

Submitted by: Mohammad Sajid Anwar

You are given instruction string made up of U (up), D (down), L (left) and R
(right).

Write a script to return true if following the instruction, you meet (0,0) at
any point along the sequence.

Example 1

  Input: $path = "ULD"
  Output: false

  (-1,1) <- (0,1)
     |        ^
     v        |
  (-1,0)    (0,0)

Example 2

  Input: $path = "ULDR"
  Output: true

   (-1,1) <- (0,1)
      |        ^
      v        |
   (-1,0) -> (0,0)

Example 3

  Input: $path = "UUURRRDDD"
  Output: false

  (0,3) -> (1,3) -> (2,3) -> (3,3)
    ^                          |
    |                          v
  (0,2)                      (3,2)
    ^                          |
    |                          v
  (0,1)                      (3,1)
    ^                          |
    |                          v
  (0,0)                      (3,0)

Example 4

  Input: $path = "UURRRDDLLL"
  Output: true

  (0,2) -> (1,2) -> (2,2) -> (3,2)
    ^                          |
    |                          v
  (0,1)                      (3,1)
    ^                          |
    |                          v
  (0,0) <- (1,0) <- (1,1) <- (3,0)

Example 5

  Input: $path = "RRUULLDDRRUU"
  Output: true

  (0,2) <- (1,2) <- (2,2)
    |                 ^
    v                 |
  (0,1)             (2,1)
    |                 ^
    v                 |
  (0,0) -> (1,0) -> (2,1)

=cut
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A single string is entered on the command-line. The string contains only the
   instructions "U" (up), "D" (down), "L" (left), and "R" (right).

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use Const::Fast;
use Switch::Plain;
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <path>
  perl $0

    <path>    An instruction string made up of U, D, L, and R
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 349, Task #2: Meeting Point (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my $argc = scalar @ARGV;

    if    ($argc == 0)
    {
        run_tests();
    }
    elsif ($argc == 1)
    {
        my $path =  $ARGV[0];
           $path =~ / ^ [UDLR]* $ /x or error( qq[Invalid path: "$path"] );

        print  qq[Input:  \$path = "$path"\n];

        my $found = find_meeting_point( $path );

        printf "Output: %s\n", $found ? 'true' : 'false';
    }
    else
    {
        error( "Expected 1 or 0 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub find_meeting_point
#-------------------------------------------------------------------------------
{
    my ($path)  =  @_;
        $path   =~ / ^ [UDLR]* $ /x or die 'Invalid path';
    my ($x, $y) = (0, 0);

    for my $dir (split //, $path)
    {
        sswitch ($dir)
        {
            case 'U': { ++$y }      # Up
            case 'D': { --$y }      # Down
            case 'L': { --$x }      # Left
            case 'R': { ++$x }      # Right
            default:  { die qq[Impossible case: "$dir"] }
        }

        return 1 if $x == 0 && $y == 0;
    }

    return 0;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $path, $expected) = split / \| /x, $line;

        for ($test_name, $path, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $found = find_meeting_point( $path ) ? 'true' : 'false';

        is $found, $expected, $test_name;
    }

    done_testing;
}

#-------------------------------------------------------------------------------
sub error
#-------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

################################################################################

__DATA__
Example 1|ULD         |false
Example 2|ULDR        |true
Example 3|UUURRRDDD   |false
Example 4|UURRRDDLLL  |true
Example 5|RRUULLDDRRUU|true
Empty    |            |false

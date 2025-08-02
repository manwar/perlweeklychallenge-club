#!perl

################################################################################
=comment

Perl Weekly Challenge 282
=========================

TASK #2
-------
*Changing Keys*

Submitted by: Mohammad Sajid Anwar

You are given an alphabetic string, $str, as typed by user.

Write a script to find the number of times user had to change the key to type
the given string. Changing key is defined as using a key different from the last
used key. The shift and caps lock keys won't be counted.

Example 1

  Input: $str = 'pPeERrLl'
  Output: 3

  p -> P : 0 key change
  P -> e : 1 key change
  e -> E : 0 key change
  E -> R : 1 key change
  R -> r : 0 key change
  r -> L : 1 key change
  L -> l : 0 key change

Example 2

  Input: $str = 'rRr'
  Output: 0

Example 3

  Input: $str = 'GoO'
  Output: 1

=cut
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A single, alphabetic, string is entered on the command-line.

=cut
#===============================================================================

use v5.32;          # Enables strictures and warnings
use Const::Fast;
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <str>
  perl $0

    <str>    An alphabetic string
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 282, Task #2: Changing Keys (Perl)\n\n";
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
        my $str =  $ARGV[ 0 ];
           $str =~ / ^ [A-Za-z]* $ /x or error( 'Invalid input string' );

        print qq[Input:  \$str = "$str"\n];

        my $key_changes = count_key_changes( $str );

        print "Output: $key_changes\n";
    }
    else
    {
        error( "Expected 1 or 0 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub count_key_changes
#-------------------------------------------------------------------------------
{
    my ($str)    = @_;
    my  $changes = 0;
    my  @chars   = split //, $str;

    for my $i (1 .. $#chars)
    {
        ++$changes unless lc $chars[ $i - 1 ] eq lc $chars[ $i ];
    }

    return $changes;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $str, $expected) = split / \| /x, $line;

        for ($test_name, $str, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $key_changes = count_key_changes( $str );

        is $key_changes, $expected, $test_name;
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
Example 1|pPeERrLl|3
Example 2|rRr     |0
Example 3|GoO     |1
Empty    |        |0

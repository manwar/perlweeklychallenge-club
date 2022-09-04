#!perl

###############################################################################
=comment

Perl Weekly Challenge 180
=========================

TASK #1
-------
*First Unique Character*

Submitted by: Mohammad S Anwar

You are given a string, $s.

Write a script to find out the first unique character in the given string and
print its index (0-based).

Example 1

  Input: $s = "Perl Weekly Challenge"
  Output: 0 as 'P' is the first unique character

Example 2

  Input: $s = "Long Live Perl"
  Output: 1 as 'o' is the first unique character

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Assumptions
-----------
1. "Characters" are LETTERS only; whitespace, punctuation, and digits are
    ignored.
2.  Matching of characters (i.e., letters) is case-INsensitive.

Interface
---------
1. If no string argument is provided on the command line, a small test suite is
   run.
2. If the constant $VERBOSE is set to a true value, a short explanation is
   appended to the output (as per the Examples).

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Test::More;

const my $VERBOSE => 1;
const my $USAGE   =>
"Usage:
  perl $0 <s>
  perl $0

    <s>    A non-empty string containing at least one letter\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 180, Task #1: First Unique Character (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $args = scalar @ARGV;

    if    ($args == 0)
    {
        run_tests();
    }
    elsif ($args == 1)
    {
        my $s =  $ARGV[ 0 ];
           $s =~ / [[:alpha:]] /x or error( 'No letters in the input string' );

        solve( $s );
    }
    else
    {
        error( "Expected 0 or 1 command line arguments, found $args" );
    }
}

#------------------------------------------------------------------------------
sub solve
#------------------------------------------------------------------------------
{
    my ($s) = @_;

    print qq[Input:  \$s = "$s"\n];

    my $index = find_index( $s );

    if ($VERBOSE)
    {
        if (defined $index)
        {
            printf qq[Output: %s (as "%s" is the first unique letter)\n],
                   $index, substr( $s, $index, 1 );
        }
        else
        {
            print "Output: None (as no letters are unique)\n";
        }
    }
    else
    {
        printf "Output: %s\n", defined $index ? $index : 'None';
    }
}

#------------------------------------------------------------------------------
sub find_index
#------------------------------------------------------------------------------
{
    my ($s) = @_;
    my  %chars;

    for my $char (split //, $s)
    {
        ++$chars{ lc $char } if $char =~ / ^ [[:alpha:]] $ /x;
    }

    my $index;

    for my $i (0 .. length( $s ) - 1)
    {
        my $key = lc substr( $s, $i, 1 );

        if (exists $chars{ $key } && $chars{ $key } == 1)
        {
            $index = $i;
            last;
        }
    }

    return $index;
}

#------------------------------------------------------------------------------
sub run_tests
#------------------------------------------------------------------------------
{
    my @tests =
    (
        [ 'Perl Weekly Challenge',     0 ],
        [ 'Long Live Perl',            1 ],
        [ 'AaBbCcDdEeFfGgHhIiJj',  undef ],   # All letters are duplicated
        [ 'AaBbCcDdEeFfGgHhIiJjK',    20 ],
        [ ' abB',                      1 ],   # Ignore space because not letter
    );

    for my $test (@tests)
    {
        my $test_name = '"' . $test->[ 0 ] . '"';

        is find_index( $test->[ 0 ] ), $test->[ 1 ], $test_name;
    }

    done_testing;
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################

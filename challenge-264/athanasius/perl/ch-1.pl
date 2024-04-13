#!perl

################################################################################
=comment

Perl Weekly Challenge 264
=========================

TASK #1
-------
*Greatest English Letter*

Submitted by: Mohammad Sajid Anwar

You are given a string, $str, made up of only alphabetic characters [a..zA..Z].

Write a script to return the greatest english letter in the given string.

    A letter is greatest if it occurs as lower and upper case. Also letter 'b'
    is greater than 'a' if 'b' appears after 'a' in the English alphabet.

Example 1

  Input: $str = 'PeRlwEeKLy'
  Output: L

  There are two letters E and L that appears as lower and upper.
  The letter L appears after E, so the L is the greatest english letter.

Example 2

  Input: $str = 'ChaLlenge'
  Output: L

Example 3

  Input: $str = 'The'
  Output: ''

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
2. A single string, containing alphabetic characters only, is given on the
   command-line.

=cut
#===============================================================================

use v5.32.1;       # Enables strictures
use warnings;
use Const::Fast;
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <str>
  perl $0

    <str>    A string containing alphabetic characters (A-Z, a-z) only
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 264, Task #1: Greatest English Letter (Perl)\n\n";
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
        my $str = $ARGV[ 0 ];

        $str =~ / ^ [[:alpha:]]* $ /x
            or error( qq[Invalid input string "$str"] );

        print "Input:  \$str = '$str'\n";

        my $gel = find_greatest_English_letter( $str );

        print "Output: '$gel'\n";
    }
    else
    {
        error( qq[Expected 1 or 0 command-line arguments, found $argc] );
    }
}

#-------------------------------------------------------------------------------
sub find_greatest_English_letter
#-------------------------------------------------------------------------------
{
    my ($str) = @_;
    my  %letters;
      ++$letters{ $_ } for split //, $str;

    my $gel = '';
    my @uc  = grep { / ^ [[:upper:]] $ /x } keys %letters;

    for (sort { $b cmp $a } @uc)        # Sort descending
    {
        if (exists $letters{ lc() })
        {
            $gel = $_;
            last;
        }
    }

    return $gel;
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

        my $gel = find_greatest_English_letter( $str );

        is $gel, $expected, $test_name;
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
Example 1|PeRlwEeKLy|L
Example 2|ChaLlenge |L
Example 3|The       |

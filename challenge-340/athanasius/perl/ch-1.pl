#!perl

################################################################################
=comment

Perl Weekly Challenge 340
=========================

TASK #1
-------
*Duplicate Removals*

Submitted by: Mohammad Sajid Anwar

You are given a string, $str, consisting of lowercase English letters.

Write a script to return the final string after all duplicate removals have been
made. Repeat duplicate removals on the given string until we no longer can.

    A duplicate removal consists of choosing two adjacent and equal letters and
    removing them.

Example 1

  Input: $str = 'abbaca'
  Output: 'ca'

  Step 1: Remove 'bb' => 'aaca'
  Step 2: Remove 'aa' => 'ca'

Example 2

  Input: $str = 'azxxzy'
  Output: 'ay'

  Step 1: Remove 'xx' => 'azzy'
  Step 2: Remove 'zz' => 'ay'

Example 3

  Input: $str = 'aaaaaaaa'
  Output: ''

  Step 1: Remove 'aa' => 'aaaaaa'
  Step 2: Remove 'aa' => 'aaaa'
  Step 3: Remove 'aa' => 'aa'
  Step 4: Remove 'aa' => ''

Example 4

  Input: $str = 'aabccba'
  Output: 'a'

  Step 1: Remove 'aa' => 'bccba'
  Step 2: Remove 'cc' => 'bba'
  Step 3: Remove 'bb' => 'a'

Example 5

  Input: $str = 'abcddcba'
  Output: ''

  Step 1: Remove 'dd' => 'abccba'
  Step 2: Remove 'cc' => 'abba'
  Step 3: Remove 'bb' => 'aa'
  Step 4: Remove 'aa' => ''

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
2. A single string of lowercase English letters is entered on the command-line.

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use Const::Fast;
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <str>
  perl $0

    <str>    A string of lowercase English letters
END
#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 340, Task #1: Duplicate Removals (Perl)\n\n";
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
        my $str = $ARGV[0];

        $str =~ / ^ [a-z]* $ /x or error( 'Invalid input string' );

        print "Input:  \$str = '$str'\n";

        my $no_dups = remove_duplicates( $str );

        print "Output: '$no_dups'\n";
    }
    else
    {
        error( "Expected 1 or 0 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub remove_duplicates
#-------------------------------------------------------------------------------
{
    my ($str) = @_;

    1 while $str =~ s/ (.) \1 //x;

    return $str;
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

        my $no_dups = remove_duplicates( $str );

        is $no_dups, $expected, $test_name;
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
Example 1|abbaca  |ca
Example 2|azxxzy  |ay
Example 3|aaaaaaaa|
Example 4|aabccba |a
Example 5|abcddcba|

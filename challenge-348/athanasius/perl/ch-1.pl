#!perl

################################################################################
=comment

Perl Weekly Challenge 348
=========================

TASK #1
-------
*String Alike*

Submitted by: Mohammad Sajid Anwar

You are given a string of even length.

Write a script to find out whether the given string can be split into two halves
of equal lengths, each with the same non-zero number of vowels.

Example 1

  Input: $str = "textbook"
  Output: false

  1st half: "text" (1 vowel)
  2nd half: "book" (2 vowels)

Example 2

  Input: $str = "book"
  Output: true

  1st half: "bo" (1 vowel)
  2nd half: "ok" (1 vowel)

Example 3

  Input: $str = "AbCdEfGh"
  Output: true

  1st half: "AbCd" (1 vowel)
  2nd half: "EfGh" (1 vowel)

Example 4

  Input: $str = "rhythmmyth"
  Output: false

  1st half: "rhyth" (0 vowel)
  2nd half: "mmyth" (0 vowel)

Example 5

  Input: $str = "UmpireeAudio"
  Output: false

  1st half: "Umpire" (3 vowels)
  2nd half: "eAudio" (5 vowels)

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
2. A string of even length is entered on the command-line.

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

    <str>    A string of even length
END
#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 348, Task #1: String Alike (Perl)\n\n";
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

        length( $str ) % 2 == 0 or error( qq[String "$str" is of odd length] );

        print  qq[Input:  \$str = "$str"\n];

        my $alike = string_alike( $str );

        printf "Output: %s\n", $alike ? 'true' : 'false';
    }
    else
    {
        error( "Expected 1 or 0 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub string_alike
#-------------------------------------------------------------------------------
{
    my ($str)      = @_;
    my  $str_len   = length $str;
        $str_len % 2 == 0 or die qq[String "$str" is of odd length];
    my  $half_len  =  $str_len / 2;
    my  $lhs       =  substr $str, 0, $half_len;
    my  $lhs_count = ($lhs =~ tr/AEIOUaeiou//);
    my  $rhs       =  substr $str, $half_len;
    my  $rhs_count = ($rhs =~ tr/AEIOUaeiou//);

    return $lhs_count > 0 && $lhs_count == $rhs_count;
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

        my $alike     = string_alike( $str );
        my $alike_str = $alike ? 'true' : 'false';

        is $alike_str, $expected, $test_name;
    }

    done_testing;
}

#-------------------------------------------------------------------------------
sub error
#-------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "\nERROR: $message\n$USAGE";
}

################################################################################

__DATA__
Example 1|textbook    |false
Example 2|book        |true
Example 3|AbCdEfGh    |true
Example 4|rhythmmyth  |false
Example 5|UmpireeAudio|false

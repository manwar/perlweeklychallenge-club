#!perl

################################################################################
=comment

Perl Weekly Challenge 240
=========================

TASK #1
-------
*Acronym*

Submitted by: Mohammad S Anwar

You are given an array of strings and a check string.

Write a script to find out if the check string is the acronym of the words in
the given array.

Example 1

  Input: @str = ("Perl", "Python", "Pascal")
         $chk = "ppp"
  Output: true

Example 2

  Input: @str = ("Perl", "Raku")
         $chk = "rp"
  Output: false

Example 3

  Input: @str = ("Oracle", "Awk", "C")
         $chk = "oac"
  Output: true

=cut
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
If no command-line arguments are given, the test suite is run.

=cut
#===============================================================================

use v5.32.1;
use warnings;
use Const::Fast;
use Getopt::Long;
use Test::More;

const my $USAGE =>
"Usage:
  perl $0 [--chk=<Str>] [<str> ...]
  perl $0

    --chk=<Str>    Check string
    [<str> ...]    A list of strings\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 240, Task #1: Acronym (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    if (scalar @ARGV == 0)
    {
        run_tests();
    }
    else
    {
        my $chk;

        GetOptions( 'chk=s' => \$chk )
            or error( 'Invalid command line argument' );

        defined $chk
            or error( 'The check string is missing from the input' );

        my @str = @ARGV;

        printf qq[Input:  \@str = (%s)\n], join ', ', map { qq["$_"] } @str;
        print  qq[        \$chk =  "$chk"\n];

        printf qq[Output: %s\n], is_acronym( \@str, $chk ) ? 'true' : 'false';
    }
}

#-------------------------------------------------------------------------------
sub is_acronym
#-------------------------------------------------------------------------------
{
    my ($str, $chk) = @_;
    my  $acronym    = join '', map { substr $_, 0, 1 } @$str;

    return lc $acronym eq lc $chk;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $strs, $chk, $expected) = split / \| /x, $line;

        for ($test_name, $strs, $chk, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @str    = split / \s+ /x, $strs;
        my $result = is_acronym( \@str, $chk ) ? 'true' : 'false';

        is $result, $expected, $test_name;
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
Example 1|Perl   Python Pascal|ppp|true
Example 2|Perl   Raku         |rp |false
Example 3|Oracle Awk C        |oac|true

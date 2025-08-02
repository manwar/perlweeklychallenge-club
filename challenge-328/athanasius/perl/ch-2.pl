#!perl

################################################################################
=comment

Perl Weekly Challenge 328
=========================

TASK #2
-------
*Good String*

Submitted by: Mohammad Sajid Anwar

You are given a string made up of lower and upper case English letters only.

Write a script to return the good string of the given string. A string is called
good string if it doesn’t have two adjacent same characters, one in upper case
and other is lower case.

UPDATE [2025-07-01]: Just to be explicit, you can only remove pair if they are
same characters, one in lower case and other in upper case, order is not
important.

Example 1

  Input: $str = "WeEeekly"
  Output: "Weekly"

  We can remove either, "eE" or "Ee" to make it good.

Example 2

  Input: $str = "abBAdD"
  Output: ""

  We remove "bB" first: "aAdD"
  Then we remove "aA": "dD"
  Finally remove "dD".

Example 3

  Input: $str = "abc"
  Output: "abc"

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
2. A string made up of lower and upper case English letters only is entered on
   the command-line.

=cut
#===============================================================================

use v5.32;         # Enables strictures
use warnings;
use Const::Fast;
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <str>
  perl $0

    <str>    A string made up of lower and upper case English letters only
END

my $pair_rx;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 328, Task #2: Good String (Perl)\n\n";
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
           $str =~ / ([^A-Za-z]) /x and error( qq[Invalid character "$1"] );

        print qq[Input: \$str = "$str"\n];

        my $good_str = get_good_str( $str );

        print qq[Output:       "$good_str"\n];
    }
    else
    {
        error( "Expected 1 or 0 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    my @pairs;

    push @pairs, $_ . uc, uc . $_ for 'a' .. 'z';

    $pair_rx = join '|', @pairs;
}

#-------------------------------------------------------------------------------
sub get_good_str
#-------------------------------------------------------------------------------
{
    my ($str) =  @_;
        $str  =~ / ^ [A-Za-z]* $ /x or die 'Invalid character';

    1 while $str =~ s/ $pair_rx //x;

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

        my $good_str = get_good_str( $str );

        is $good_str, $expected, $test_name;
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
Example 1|WeEeekly|Weekly
Example 2|abBAdD  |
Example 3|abc     |abc

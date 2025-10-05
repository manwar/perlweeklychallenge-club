#!perl

################################################################################
=comment

Perl Weekly Challenge 341
=========================

TASK #1
-------
*Broken Keyboard*

Submitted by: Mohammad Sajid Anwar

You are given a string containing English letters only and also you are given
broken keys.

Write a script to return the total words in the given sentence can be typed
completely.

Example 1

  Input: $str = 'Hello World', @keys = ('d')
  Output: 1

  With broken key 'd', we can only type the word 'Hello'.

Example 2

  Input: $str = 'apple banana cherry', @keys = ('a', 'e')
  Output: 0

Example 3

  Input: $str = 'Coding is fun', @keys = ()
  Output: 3

  No keys broken.

Example 4

  Input: $str = 'The Weekly Challenge', @keys = ('a','b')
  Output: 2

Example 5

  Input: $str = 'Perl and Python', @keys = ('p')
  Output: 1

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
2. A string is entered on the command-line, followed by a list of broken keys.
   The string comprises English letters and whitespace; each broken key is a
   single English letter.

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use Const::Fast;
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <str> [<keys> ...]
  perl $0

    <str>           A single string of English letters (with whitespace)
    [<keys> ...]    A list of broken keys
END
#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 341, Task #1: Broken Keyboard (Perl)\n\n";
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
        my ($str, @keys) = @ARGV;

        $str =~  / ^ [A-Za-z\s]* $ /x or error( qq[Invalid string "$str"] );

        for my $key (@keys)
        {
            $key =~ / ^ [A-Za-z] $ /x or error( qq[Invalid key "$key"] );
        }

        printf "Input:  \$str = '$str', \@keys = (%s)\n",
                join ', ', map { "'$_'" } @keys;

        my $count = count_typeable_words( $str, \@keys );

        print  "Output: $count\n";
    }
}

#-------------------------------------------------------------------------------
sub count_typeable_words
#-------------------------------------------------------------------------------
{
    my ($str, $keys) = @_;
    my  $count       = 0;
    my  @words       = split / \s+ /x, $str;

    L_WORDS:
    for my $word (@words)
    {
        for my $key (@$keys)
        {
            next L_WORDS if $word =~ / $key /ix;
        }

        ++$count;
    }

    return $count;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $str, $keys_str, $expected) = split / \| /x, $line;

        for ($test_name, $str, $keys_str, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @keys  = split / \s+ /x, $keys_str;
        my $count = count_typeable_words( $str, \@keys );

        is $count, $expected, $test_name;
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
Example 1|Hello World         |d  |1
Example 2|apple banana cherry |a e|0
Example 3|Coding is fun       |   |3
Example 4|The Weekly Challenge|a b|2
Example 5|Perl and Python     |p  |1

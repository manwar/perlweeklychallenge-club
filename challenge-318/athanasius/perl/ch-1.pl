#!perl

################################################################################
=comment

Perl Weekly Challenge 318
=========================

TASK #1
-------
*Group Position*

Submitted by: Mohammad Sajid Anwar

You are given a string of lowercase letters.

Write a script to find the position of all groups in the given string. Three or
more consecutive letters form a group. Return "" if none found.

Example 1

  Input: $str = "abccccd"
  Output: "cccc"

Example 2

  Input: $str = "aaabcddddeefff"
  Output: "aaa", "dddd", "fff"

Example 3

  Input: $str = "abcdd"
  Output: ""

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
2. A string of lowercase letters is entered on the command-line.
3. Output: The Task is titled "Group Position", but no positions are given in
   the Example output. This solution includes the starting index of each group,
   so the output of Example 2 is:

        Output: "aaa" (0), "dddd" (5), "fff" (11)

   -- showing that, e.g., group "dddd" begins at index 5 of the input string.

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

    <str>    A string of lowercase letters
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 318, Task #1: Group Position (Perl)\n\n";
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
        my $str    =  $ARGV[ 0 ];
           $str    =~ / ^ [a-z]* $ /x or error( 'Invalid character(s)' );
        my $groups =  find_groups( $str );
        my @out;

        if (scalar @$groups > 0)
        {
            for my $group (@$groups)
            {
                $group =~ / ^ (\d+) (\w+) $ /x;
                push @out, qq["$2" ($1)];
            }
        }
        else
        {
            push @out, qq[""];
        }

        printf "Output: %s\n", join ', ', @out;
    }
    else
    {
        error( 'Expected 1 or 0 command-line arguments, found $argc' );
    }
}

#-------------------------------------------------------------------------------
sub find_groups
#-------------------------------------------------------------------------------
{
    my ($str) =  @_;
        $str  =~ / ^ [a-z]* $ /x or die 'Invalid character(s)';
    my  @groups;

    if (length $str > 0)
    {
        my @chars = split //, $str;
        my $char  = $chars[ 0 ];
        my $idx   = 0;
        my $count = 1;

        for my $i (1 .. $#chars)
        {
            my $next = $chars[ $i ];

            if ($next eq $char)
            {
                ++$count;
            }
            else
            {
                push @groups, $idx . $char x $count if $count >= 3;
                $char  = $next;
                $count = 1;
                $idx   = $i;
            }
        }

        push @groups, $idx . $char x $count if $count >= 3;
    }

    return \@groups;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $str, $expected_str) = split / \| /x, $line;

        for ($test_name, $str, $expected_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $groups   = find_groups( $str );
        my @expected = split / \s+ /x, $expected_str;

        is_deeply $groups, \@expected, $test_name;
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
Example 1|abccccd       |2cccc
Example 2|aaabcddddeefff|0aaa 5dddd 11fff
Example 3|abcdd         |

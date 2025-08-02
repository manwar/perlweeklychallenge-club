use v6d;

################################################################################
=begin comment

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

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A string of lowercase letters is entered on the command-line.
3. Output: The Task is titled "Group Position", but no positions are given in
   the Example output. This solution includes the starting index of each group,
   so the output of Example 2 is:

        Output: "aaa" (0), "dddd" (5), "fff" (11)

   -- showing that, e.g., group "dddd" begins at index 5 of the input string.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 318, Task #1:  (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $str where { / ^ <[ a .. z ]>* $ / }  #= A string of lowercase letters
)
#===============================================================================
{
    qq[Input:  \$str = "$str"].put;

    my Str @groups = find-groups( $str );
    my Str @out;

    if @groups.elems > 0
    {
        for @groups -> Str $group
        {
            $group ~~ / ^ (\d+) (\w+) $ /;

            @out.push: qq["%s" (%d)].sprintf: ~$1, $0.Int;
        }
    }
    else
    {
        @out.push: qq[""];
    }

    "Output: %s\n".printf: @out.join: ', ';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-groups( Str:D $str where { / ^ <[ a .. z ]>* $ / } --> List:D[Str:D] )
#-------------------------------------------------------------------------------
{
    my Str @groups;

    if $str.chars > 0
    {
        my Str  @chars = $str.split: '', :skip-empty;
        my Str  $char  = @chars[ 0 ];
        my UInt $idx   = 0;
        my UInt $count = 1;

        for 1 .. @chars.end -> UInt $i
        {
            my Str $next = @chars[ $i ];

            if $next eq $char
            {
                ++$count;
            }
            else
            {
                @groups.push: $idx ~ $char x $count if $count >= 3;
                $char  = $next;
                $count = 1;
                $idx   = $i;
            }
        }

        @groups.push: $idx ~ $char x $count if $count >= 3;
    }

    return @groups;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $str, $expected-str) = $line.split: / \| /;

        for     $test-name, $str, $expected-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str @groups   = find-groups( $str );
        my Str @expected = $expected-str.split: / \s+ /, :skip-empty;

        is-deeply @groups, @expected, $test-name;
    }

    done-testing;
}

#-------------------------------------------------------------------------------
sub USAGE()
#-------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s:g/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

#-------------------------------------------------------------------------------
sub test-data( --> Str:D )
#-------------------------------------------------------------------------------
{
    return q:to/END/;
        Example 1|abccccd       |2cccc
        Example 2|aaabcddddeefff|0aaa 5dddd 11fff
        Example 3|abcdd         |
        END
}

################################################################################

use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 369
=========================

TASK #1
-------
*Valid Tag*

Submitted by: Mohammad Sajid Anwar

You are given a [...] string caption for a video.

Write a script to generate [a] tag for the given string caption in three steps
as mentioned below:

  1. Format as camelCase
  Starting with a lower-case letter and capitalising the first letter of each
  subsequent word.
  Merge all words in the caption into a single string starting with a #.
  2. Sanitise the String
  Strip out all characters that are not English letters (a-z or A-Z).
  3. Enforce Length
  If the resulting string exceeds 100 characters, truncate it so it is
  exactly 100 characters long.

Example 1

  Input: $caption = "Cooking with 5 ingredients!"
  Output: "#cookingWithIngredients"

Example 2

  Input: $caption = "the-last-of-the-mohicans"
  Output: "#thelastofthemohicans"

Example 3

  Input: $caption = "  extra spaces here"
  Output: "#extraSpacesHere"

Example 4

  Input: $caption = "iPhone 15 Pro Max Review"
  Output: "#iphoneProMaxReview"

Example 5

  Input: $caption = "Ultimate 24-Hour Challenge: Living in a Smart Home controll
  ed entirely by Artificial Intelligence and Voice Commands in the year 2026!"
  Output: "#ultimateHourChallengeLivingInASmartHomeControlledEntirelyByArtificia
  lIntelligenceAndVoiceCommandsIn"

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumptions
-----------
1. Words are delineated by spaces, but not by hyphens (see Example 2).
2. Following the first letter, all subsequent letters in each word must be put
   into lower-case (see Example 4, "iPhone" becomes "iphone").

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A single string is entered on the command-line.

=end comment
#===============================================================================

use Test;

our UInt constant MAX-LEN = 100;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 369, Task #1: Valid Tag (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $caption               #= A string caption for a video
)
#===============================================================================
{
    qq[Input:  \$caption = "$caption"].put;

    my Str $tag = generate-tag( $caption );

    qq[Output: "$tag"].put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub generate-tag( Str:D $caption --> Str:D )
#-------------------------------------------------------------------------------
{
    my Str @words = $caption.split: / \s+ /, :skip-empty;

    for 0 .. @words.end -> UInt $i
    {
        @words[$i] ~~ s:g/ <-[ A..Z a..z ]> //;
        @words[$i] .= lc;
        @words[$i] .= tc if $i > 0;
    }

    my Str $tag  = '#' ~ @words.join;
           $tag .= substr: 0 .. MAX-LEN - 1;

    return $tag;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $caption, $expected) = $line.split: / \| /;

        for     $test-name, $caption, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str $tag = generate-tag( $caption );

        is $tag, $expected, $test-name;
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
        Example 1|Cooking with 5 ingredients!|#cookingWithIngredients
        Example 2|the-last-of-the-mohicans|#thelastofthemohicans
        Example 3|  extra spaces here|#extraSpacesHere
        Example 4|iPhone 15 Pro Max Review|#iphoneProMaxReview
        Example 5|Ultimate 24-Hour Challenge: Living in a Smart Home controlled entirely by Artificial Intelligence and Voice Commands in the year 2026!|#ultimateHourChallengeLivingInASmartHomeControlledEntirelyByArtificialIntelligenceAndVoiceCommandsIn
        END
}

################################################################################

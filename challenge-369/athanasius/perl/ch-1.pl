#!perl

################################################################################
=comment

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

=cut
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumptions
-----------
1. Words are delineated by spaces, but not by hyphens (see Example 2).
2. Following the first letter, all subsequent letters in each word must be put
   into lower-case (see Example 4, "iPhone" becomes "iphone").

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A single string is entered on the command-line.

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use Const::Fast;
use Test::More;

const my $MAX_LEN => 100;
const my $USAGE   => <<END;
Usage:
  perl $0 <caption>
  perl $0

    <caption>    A string caption for a video
END
#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 369, Task #1: Valid Tag (Perl)\n\n";
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
        my $caption = $ARGV[0];

        print qq[Input:  \$caption = "$caption"\n];

        my $tag = generate_tag( $caption );

        print qq[Output: "$tag"\n];
    }
    else
    {
        error( "Expected 1 or 0 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub generate_tag
#-------------------------------------------------------------------------------
{
    my ($caption) = @_;
    my  @words    = grep { length > 0 } split / \s+ /x, $caption;

    for my $i (0 .. $#words)
    {
        $words[$i] =~ s/ [^A-Za-z] //gx;
        $words[$i] =  lc $words[$i];
        $words[$i] =~ s/ ^ (.) / uc($1) /egx if $i > 0;
    }

    my $tag = '#' . join '', @words;
       $tag = substr $tag, 0, $MAX_LEN;

    return $tag;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my ($test_name, $caption, $expected) = split / \| /x, $line;

        my $tag = generate_tag( $caption );

        is $tag, $expected, $test_name;
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
Example 1|Cooking with 5 ingredients!|#cookingWithIngredients
Example 2|the-last-of-the-mohicans|#thelastofthemohicans
Example 3|  extra spaces here|#extraSpacesHere
Example 4|iPhone 15 Pro Max Review|#iphoneProMaxReview
Example 5|Ultimate 24-Hour Challenge: Living in a Smart Home controlled entirely by Artificial Intelligence and Voice Commands in the year 2026!|#ultimateHourChallengeLivingInASmartHomeControlledEntirelyByArtificialIntelligenceAndVoiceCommandsIn

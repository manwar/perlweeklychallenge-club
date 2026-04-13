#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 369 Task 1  Valid Tag
#=============================================================================
# You are given a given a string caption for a video.
# Write a script to generate tag for the given string caption in three
# steps as mentioned below:
#   1. Format as camelCase.  Starting with a lower-case letter and
#   capitalising the first letter of each subsequent word.
#   Merge all words in the caption into a single string starting with a #.
#   2. Sanitise the String.  Strip out all characters that are not English
#   letters (a-z or A-Z).
#   3. Enforce Length.  If the resulting string exceeds 100 characters,
#   truncate it so it is exactly 100 characters long.
# Example 1 Input: $caption = "Cooking with 5 ingredients!"
#			Output: "#cookingWithIngredients"
# Example 2 Input: $caption = "the-last-of-the-mohicans"
#			Output: "#thelastofthemohicans"
# Example 3 Input: $caption = "  extra spaces here"
#			Output: "#extraSpacesHere"
# Example 4 Input: $caption = "iPhone 15 Pro Max Review"
#			Output: "#iphoneProMaxReview"
# Example 5 Input: $caption = "Ultimate 24-Hour Challenge: Living in a Smart Home controlled entirely by Artificial Intelligence and Voice Commands in the year 2026!"
#			Output: "#ultimateHourChallengeLivingInASmartHomeControlledEntirelyByArtificialIntelligenceAndVoiceCommandsIn"
#=============================================================================

use v5.42;


use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
my $logger;
{
    use Log::Log4perl qw(:easy);
    Log::Log4perl->easy_init({ level => ($Verbose ? $DEBUG : $INFO ),
            layout => "%d{HH:mm:ss.SSS} %p{1} %m%n" });
    $logger = Log::Log4perl->get_logger();
}
#=============================================================================

exit(!runTest()) if $DoTest;

say enTag("@ARGV");

#=============================================================================
sub enTag($caption, $maxLength = 100)
{
    # my @word = split(" ", $caption);
    # @word = map { lc } @word ;
    # @word = map { s/[^[:alpha:]]+//gr } @word;
    # @word = map { ucfirst } @word;
    # my $str = join("", @word);
    # $str = lcfirst($str);
    # return substr("#$str", 0, $maxLength);

    return substr('#' . lcfirst
        join("", map { ucfirst(lc($_) =~ s/[^[:alpha:]]+//gr) } split(" ", $caption)),
        0, $maxLength);
}

sub runTest
{
    use Test2::V0;

    is( enTag("Cooking with 5 ingredients!"), "#cookingWithIngredients", "Example 1");
    is( enTag("the-last-of-the-mohicans"), "#thelastofthemohicans", "Example 2");
    is( enTag("  extra spaces here"), "#extraSpacesHere", "Example 3");
    is( enTag("iPhone 15 Pro Max Review"), "#iphoneProMaxReview", "Example 4");
    is( enTag("Ultimate 24-Hour Challenge: Living in a Smart Home controlled entirely by Artificial Intelligence and Voice Commands in the year 2026!"), "#ultimateHourChallengeLivingInASmartHomeControlledEntirelyByArtificialIntelligenceAndVoiceCommandsIn", "Example 5");

    done_testing;
}

#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solution in Perl for The Weekly Challenge 369-1,
written by Robbie Hatley on Tue Apr 14, 2026.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 369-1: Valid Tag
Submitted by: Mohammad Sajid Anwar
You are given a given a string caption for a video. Write a
script to generate tag for the given string caption in three
steps as mentioned below:

1. Format as camelCase
Starting with a lower-case letter and capitalising the first
letter of each subsequent word. Merge all words in the caption
into a single string starting with a #.

2. Sanitise the String
Strip out all characters that are not English letters (a-z or
A-Z).

3. Enforce Length
If the resulting string exceeds 100 characters, truncate it
so it is exactly 100 characters long.

Example #1:
Input: $caption = "Cooking with 5 ingredients!"
Output: "#cookingWithIngredients"

Example #2:
Input: $caption = "the-last-of-the-mohicans"
Output: "#thelastofthemohicans"

Example #3:
Input: $caption = "  extra spaces here"
Output: "#extraSpacesHere"

Example #4:
Input: $caption = "iPhone 15 Pro Max Review"
Output: "#iphoneProMaxReview"

Example #5:
Input: $caption = "Ultimate 24-Hour Challenge: Living in a Smart
Home controlled entirely by Artificial Intelligence and Voice
Commands in the year 2026!"
Output: "#ultimateHourChallengeLivingInASmartHomeControlled\
         EntirelyByArtificialIntelligenceAndVoiceCommandsIn"

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
The answer given for Example 2 by the "theweeklychallenge.org" web site seems wrong to me. However, let us not
be hasty. If we construe "largely-intact" as being "one hyphenated compound word", then it's one word. So I'll
construe "word characters" as being "[a-zA-Z-]", then strip-out the hyphens later, AFTER adjusting case.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of double-quoted strings, in proper Perl syntax, like so:

./ch-1.pl '("Donald Trump sucks", "Stand up for science!", "Ga go ga.")'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;

   # Convert a string to a camel-case hashtag:
   sub camel ( $x ) {
      # Remove leading and trailing non-word chars:
      $x =~ s/^[^a-zA-Z-]*(.+)[^a-zA-Z-]*$/$1/;
      # Split into (possibly-hyphenated) words:
      my @words = split /[^a-zA-Z-]+/, $x;
      # Remove all non-letter characters:
      s/[^a-zA-Z]//g for @words;
      # Convert all words to all-lower-case:
      s/^(.+)$/\L$1\E/ for @words;
      # UC first letter of all but first word:
      s/^(.)(.+)$/\u$1$2/ for @words[1..$#words];
      # Join words and tack '#' on left:
      my $out = '#'.join '', @words;
      # Force length <= 100:
      $out =~ s/^(.{1,100}).*$/$1/;
      # Return result:
      return $out;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @strings = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 input:
   "Cooking with 5 ingredients!",
   # Expected output: "#cookingWithIngredients"

   # Example 2 input:
   "the-last-of-the-mohicans",
   # Expected output: "#thelastofthemohicans"

   # Example 3 input:
   "  extra spaces here",
   # Expected output: "#extraSpacesHere"

   # Example 4 input:
   "iPhone 15 Pro Max Review",
   # Expected output: "#iphoneProMaxReview"

   # Example 5 input:
   "Ultimate 24-Hour Challenge: Living in a Smart Home controlled entirely by Artificial Intelligence and Voice Commands in the year 2026!",
   # Expected output: "#ultimateHourChallengeLivingInASmartHomeControlledEntirelyByArtificialIntelligenceAndVoiceCommandsIn"
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $string (@strings) {
   say '';
   say "Original string = \"$string\"";
   my $c = camel($string);
   say "Camel    string = \"$c\"";
}

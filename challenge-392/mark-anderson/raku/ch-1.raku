#!/usr/bin/env raku
use Test;

is convert-palindrome("pinnipeds"),  "sdepinnipeds";
is convert-palindrome("abcd"),       "dcbabcd";
is convert-palindrome("bananas"),    "sananabananas";
is convert-palindrome("dissident"),  "tnedissident";
is convert-palindrome("cailliachs"), "shcailliachs";
is convert-palindrome("racecar"),    "racecar";

sub convert-palindrome($str)
{
    my @m = $str ~~ m:g/ (.*) <?{ $0 eq $0.flip }> /;
    @m[1..*].join.flip ~ @m.head ~ @m[1..*].join
}

#!/usr/bin/env tclsh
#
# Task 1: Valid Tag
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a given a string caption for a video.  Write a script to generate
# tag for the given string caption in three steps as mentioned below:
# 
#     1. Format as camelCase
#         Starting with a lower-case letter and capitalising the first letter of each
#         subsequent word.  Merge all words in the caption into a single string starting
#         with a #.
#     2. Sanitise the String
#         Strip out all characters that are not English letters (a-z or A-Z).
#     3. Enforce Length
#         If the resulting string exceeds 100 characters, truncate it so it is
#         exactly 100 characters long.
# 
# Example 1
# 
#     Input: $caption = "Cooking with 5 ingredients!"
#     Output: "#cookingWithIngredients"
# 
# Example 2
# 
#     Input: $caption = "the-last-of-the-mohicans"
#     Output: "#thelastofthemohicans"
# 
# Example 3
# 
#     Input: $caption = "  extra spaces here"
#     Output: "#extraSpacesHere"
# 
# Example 4
# 
#     Input: $caption = "iPhone 15 Pro Max Review"
#     Output: "#iphoneProMaxReview"
# 
# Example 5
# 
#     Input: $caption = "Ultimate 24-Hour Challenge: Living in a Smart Home controlled entirely by Artificial Intelligence and Voice Commands in the year 2026!"
#     Output: "#ultimateHourChallengeLivingInASmartHomeControlledEntirelyByArtificialIntelligenceAndVoiceCommandsIn"
# 

package require Tcl 8.6
package require tcltest

set cases {
    {"Cooking with 5 ingredients!" "#cookingWithIngredients" "Example 1"}
    {"the-last-of-the-mohicans"    "#thelastofthemohicans"   "Example 2"}
    {"  extra spaces here"         "#extraSpacesHere"        "Example 3"}
    {"iPhone 15 Pro Max Review"    "#iphoneProMaxReview"     "Example 4"}
    {"Ultimate 24-Hour Challenge: Living in a Smart Home\
controlled entirely by Artificial Intelligence and Voice\
Commands in the year 2026!"
     "#ultimateHourChallengeLivingInASmartHomeControlledEntirelyByArtificialIntelligenceAndVoiceCommandsIn" "Example 5"}
}

proc valid_tag {caption} {
    set caption [regsub -all {[^a-zA-Z\s]} $caption {}]
    set words [split $caption]
    set tag "#"
    foreach word $words {
        if {$tag eq "#"} {
            append tag [string tolower $word]
        } else {
            append tag [string totitle $word]
        }
    }
    return [string range $tag 0 99]

}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        valid_tag [lindex $case 0]
    } [lindex $case 1]
}

exit 0


#!/usr/bin/env tclsh
#
# Task 1: Max Words
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given an array of sentences.
# 
# Write a script to return the maximum number of words that appear in a single
# sentence.
# 
# Example 1
# 
#     Input: @sentences = ("Hello world", "This is a test", "Perl is great")
# 
#     Output: 4
# 
# Example 2
# 
#     Input: @sentences = ("Single")
# 
#     Output: 1
# 
# Example 3
# 
#     Input: @sentences = ("Short", "This sentence has seven words in total", "A
#     B C", "Just four words here")
# 
#     Output: 7
# 
# Example 4
# 
#     Input: @sentences = ("One", "Two parts", "Three part phrase", "")
# 
#     Output: 3
# 
# Example 5
# 
#     Input: @sentences = ("The quick brown fox jumps over the lazy dog", "A",
#     "She sells seashells by the seashore", "To be or not to be that is the
#     question")
# 
#     Output: 10
# 

package require Tcl 8.6
package require tcltest

set cases {
    {{"Hello world" "This is a test" "Perl is great"}
        4 "Example 1"}
    {{"Single"}
        1 "Example 2"}
    {{"Short" "This sentence has seven words in total"
      "A B C" "Just four words here"}
        7 "Example 3"}
    {{"One" "Two parts" "Three part phrase" ""}
        3 "Example 4"}
    {{"The quick brown fox jumps over the lazy dog" "A"
      "She sells seashells by the seashore"
      "To be or not to be that is the question"}
       10 "Example 5"}
}

proc max_words {sents} {
    set max 0
    foreach s $sents {
        set count [llength [split $s]]
        if {$count > $max} {
            set max $count
        }
    }
    return $max
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        max_words [lindex $case 0]
    } [lindex $case 1]
}

exit 0


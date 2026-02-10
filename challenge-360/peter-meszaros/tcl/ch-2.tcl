#!/usr/bin/env tclsh
#
# Task 2: Word Sorter
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are give a sentence.  Write a script to order words in the given sentence
# alphabetically but keeps the words themselves unchanged.
# 
# Example 1
# 
#     Input: $str = "The quick brown fox"
#     Output: "brown fox quick The"
# 
# Example 2
# 
#     Input: $str = "Hello    World!   How   are you?"
#     Output: "are Hello How World! you?"
# 
# Example 3
# 
#     Input: $str = "Hello"
#     Output: "Hello"
# 
# Example 4
# 
#     Input: $str = "Hello, World! How are you?"
#     Output: "are Hello, How World! you?"
# 
# Example 5
# 
#     Input: $str = "I have 2 apples and 3 bananas!"
#     Output: "2 3 and apples bananas! have I"
# 

package require Tcl 8.6
package require tcltest

set cases {
    {"The quick brown fox"              "brown fox quick The"            "Example 1"}
    {"Hello    World!   How   are you?" "are Hello How World! you?"      "Example 2"}
    {"Hello"                            "Hello"                          "Example 3"}
    {"Hello World! How are you?"        "are Hello How World! you?"      "Example 4"}
    {"I have 2 apples and 3 bananas!"   "2 3 and apples bananas! have I" "Example 5"}
}

proc word_sorter {str} {
    regsub -all {\s+} $str " " str
    set words [split $str]
    set sorted [lsort -dictionary -nocase $words]
    return [join $sorted " "]
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        word_sorter [lindex $case 0]
    } [lindex $case 1]
}

exit 0


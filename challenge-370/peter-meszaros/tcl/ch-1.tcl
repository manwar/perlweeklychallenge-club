#!/usr/bin/env tclsh
#
# Task 1: Popular Word
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a string paragraph and an array of the banned words.  Write a
# script to return the most popular word that is not banned. It is guaranteed
# there is at least one word that is not banned and the answer is unique. The
# words in paragraph are case-insensitive and the answer should be in lowercase.
# The words can not contain punctuation symbols.
# 
# Example 1
# 
#     Input: $paragraph = "Bob hit a ball, the hit BALL flew far after it was hit."
#            @banned = ("hit")
#     Output: "ball"
# 
#     After removing punctuation and converting to lowercase, the word "hit"
#     appears 3 times, and "ball" appears 2 times.  Since "hit" is on the banned
#     list, we ignore it.
# 
# Example 2
# 
#     Input: $paragraph = "Apple? apple! Apple, pear, orange, pear, apple, orange."
#            @banned = ("apple", "pear")
#     Output: "orange"
# 
#     "apple"  appears 4 times.
#     "pear"   appears 2 times.
#     "orange" appears 2 times.
# 
#     "apple" and "pear" are both banned.  Even though "orange" has the same
#     frequency as "pear", it is the only non-banned word with the highest
#     frequency.
# 
# Example 3
# 
#     Input: $paragraph = "A. a, a! A. B. b. b."
#            @banned = ("b")
#     Output: "a"
# 
#     "a" appears 4 times.
#     "b" appears 3 times.
# 
#     The input has mixed casing and heavy punctuation.  The normalised, "a" is
#     the clear winner, since "b" is banned, "a" is the only choice.
# 
# Example 4
# 
#     Input: $paragraph = "Ball.ball,ball:apple!apple.banana"
#            @banned = ("ball")
#     Output: "apple"
# 
#     Here the punctuation acts as a delimiter.
#     "ball"   appears 3 times.
#     "apple"  appears 2 times.
#     "banana" appears 1 time.
# 
# Example 5
# 
#     Input: $paragraph = "The dog chased the cat, but the dog was faster than the cat."
#            @banned = ("the", "dog")
#     Output: "cat"
# 
#     "the" appears 4 times.
#     "dog" appears 2 times.
#     "cat" appears 2 times.
# 
#     "chased", "but", "was", "faster", "than" appear 1 time each.
#     "the" is the most frequent but is banned.
#     "dog" is the next most frequent but is also banned.
#     The next most frequent non-banned word is "cat".
# 

package require Tcl 8.6
package require tcltest

set cases {
    {{"Bob hit a ball the hit BALL flew far after it was hit." {"hit"}}
        "ball"   "Example 1"}
    {{"Apple? apple! Apple pear orange pear apple orange." {"apple" "pear"}}
        "orange" "Example 2"}
    {{"A. a a! A. B. b. b." {"b"}}
        "a"      "Example 3"}
    {{"Ball.ballball:apple!apple.banana" {"ball"}}
        "apple"  "Example 4"}
    {{"The dog chased the cat but the dog was faster than the cat." {"the" "dog"}}
        "cat"    "Example 5"}
}

proc popular_word {p} {
    set paragraph [lindex $p 0]
    set banned    [lindex $p 1]

    array set count {}
    set banneddict {}
    foreach w $banned {
        dict set banneddict $w true
    }

    foreach w [regexp -all -inline {\w+} $paragraph] {
        set word [string tolower $w]
        if {![dict exists $banneddict $word]} {
            incr count($word)
        }
    }

    set popular ""
    set max 0
    foreach word [array names count] {
        if {$count($word) > $max} {
            set popular $word
            set max $count($word)
        }
    }
    return $popular
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        popular_word [lindex $case 0]
    } [lindex $case 1]
}

exit 0


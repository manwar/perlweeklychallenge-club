#!/usr/bin/env tclsh
#
# Task 1: Acronyms
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given an array of words and a word.
# 
# Write a script to return true if concatenating the first letter of each word in
# the given array matches the given word, return false otherwise.
# 
# Example 1
# 
#     Input: @array = ("Perl", "Weekly", "Challenge")
#            $word  = "PWC"
#     Output: true
# 
# Example 2
# 
#     Input: @array = ("Bob", "Charlie", "Joe")
#            $word  = "BCJ"
#     Output: true
# 
# Example 3
# 
#     Input: @array = ("Morning", "Good")
#            $word  = "MM"
#     Output: false
# 

package require tcltest

set cases {
    {{{"Perl" "Weekly" "Challenge"} "PWC"} 1 "Example 1"}
    {{{"Bob" "Charlie" "Joe"}       "BCJ"} 1 "Example 2"} 
    {{{"Morning" "Good"}             "MM"} 0 "Example 3"}
}

proc acronyms {p} {
    set words [lindex $p 0]
    set word  [lindex $p 1]

    if {[join [lmap c $words { set c [string index $c 0] }] {}] == $word} {
        return 1
    } else {
        return 0
    }
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        acronyms [lindex $case 0]
    } [lindex $case 1]
}

exit 0



sub acronyms
{
    my ($words, $word) = @{$_[0]};

    return join('', map { substr($_, 0, 1) } @$words) eq $word ? 1 : 0;
}


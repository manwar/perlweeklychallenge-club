#!/usr/bin/env tclsh
#
# Task 1: Duplicate Removals
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a string, $str, consisting of lowercase English letters.
# 
# Write a script to return the final string after all duplicate removals have
# been made. Repeat duplicate removals on the given string until we no longer
# can.
# 
#     A duplicate removal consists of choosing two adjacent and equal letters and
#     removing them.
# 
# Example 1
# 
#     Input: $str = 'abbaca'
#     Output: 'ca'
# 
#     Step 1: Remove 'bb' => 'aaca'
#     Step 2: Remove 'aa' => 'ca'
# 
# Example 2
# 
#     Input: $str = 'azxxzy'
#     Output: 'ay'
# 
#     Step 1: Remove 'xx' => 'azzy'
#     Step 2: Remove 'zz' => 'ay'
# 
# Example 3
# 
#     Input: $str = 'aaaaaaaa'
#     Output: ''
# 
#     Step 1: Remove 'aa' => 'aaaaaa'
#     Step 2: Remove 'aa' => 'aaaa'
#     Step 3: Remove 'aa' => 'aa'
#     Step 4: Remove 'aa' => ''
# 
# Example 4
# 
#     Input: $str = 'aabccba'
#     Output: 'a'
# 
#     Step 1: Remove 'aa' => 'bccba'
#     Step 2: Remove 'cc' => 'bba'
#     Step 3: Remove 'bb' => 'a'
# 
# Example 5
# 
#     Input: $str = 'abcddcba'
#     Output: ''
# 
#     Step 1: Remove 'dd' => 'abccba'
#     Step 2: Remove 'cc' => 'abba'
#     Step 3: Remove 'bb' => 'aa'
#     Step 4: Remove 'aa' => ''
# 

package require tcltest

set cases {
    {"abbaca"   "ca" "Example 1"}
    {"azxxzy"   "ay" "Example 2"}
    {"aaaaaaaa" ""   "Example 3"}
    {"aabccba"  "a"  "Example 4"}
    {"abcddcba" ""   "Example 5"}
}

proc duplicate_removals {str} {
    while {[regexp {(.)\1} $str]} {
        regsub -all {(.)\1} $str {} str
    }
    return $str
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
       duplicate_removals [lindex $case 0]
    } [lindex $case 1]
}

exit 0


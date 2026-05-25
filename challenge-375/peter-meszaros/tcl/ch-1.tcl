#!/usr/bin/env tclsh
#
# Task 1: Single Common Word
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given two array of strings.  Write a script to return the number of
# strings that appear exactly once in each of the two given arrays. String
# comparison is case sensitive.
# 
# Example 1
# 
#     Input: @array1 = ("apple", "banana", "cherry")
#            @array2 = ("banana", "cherry", "date")
#     Output: 2
# 
# Example 2
# 
#     Input: @array1 = ("a", "ab", "abc")
#            @array2 = ("a", "a", "ab", "abc")
#     Output: 2
# 
#     "a" appears once in @array1 but appears twice in @array2, therefore, not counted.
# 
# Example 3
# 
#     Input: @array1 = ("orange", "lemon")
#            @array2 = ("grape", "melon")
#     Output: 0
# 
# Example 4
# 
#     Input: @array1 = ("test", "test", "demo")
#            @array2 = ("test", "demo", "demo")
#     Output: 0
# 
# Example 5
# 
#     Input: @array1 = ("Hello", "world")
#            @array2 = ("hello", "world")
#     Output: 1
# 
#     String comparison is case sensitive.
# 

package require Tcl 8.6
package require tcltest

set cases {
    {{{"apple" "banana" "cherry"} {"banana" "cherry" "date"}} 2 "Example 1"}
    {{{"a" "ab" "abc"}            {"a" "a" "ab" "abc"}}       2 "Example 2"}
    {{{"orange" "lemon"}          {"grape" "melon"}}          0 "Example 3"}
    {{{"test" "test" "demo"}      {"test" "demo" "demo"}}     0 "Example 4"}
    {{{"Hello" "world"}           {"hello" "world"}}          1 "Example 5"}
}

proc single_common_word {p} {
    set array1 [lindex $p 0]
    set array2 [lindex $p 1]

    array set count1 {}
    foreach word $array1 {
        incr count1($word)
    }

    array set count2 {}
    foreach word $array2 {
        incr count2($word)
    }

    set result 0
    foreach word [array names count1] {
        if {$count1($word) == 1 && [info exists count2($word)] && $count2($word) == 1} {
            incr result
        }
    }

    return $result
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        single_common_word [lindex $case 0]
    } [lindex $case 1]
}

exit 0


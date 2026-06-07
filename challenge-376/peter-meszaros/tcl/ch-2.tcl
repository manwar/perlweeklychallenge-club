#!/usr/bin/env tclsh
#
# Task 2: Doubled Words
# 
# Submitted by: Matt Martini
# 
# You are given a string (which may contain embedded newlines) which is taken
# from a page on a website. The string will not contain brackets qw{ [ ] }.
# Write a script that will find doubled words (such as "this this") and highlight
# (wrap in brackets) each doubled word. The script should:
# 
#     - Work across lines, even finding situations where a word at the end of
#       one line is repeated at the beginning of the next.
# 
#     - Find doubled words despite capitalization differences, such as with
#       'The the...', as well as allow differing amounts of whitespace (spaces,
#       tabs, newlines, and the like) to lie between the words.
# 
#     - Find doubled words even when separated by HTML tags. For example, to
#       make a word bold: '...it is <B>very</B> very important...'. Only show
#       lines containing doubled words.
# 
# Adapted from Mastering Regular Expressions, Third Edition by Jeffrey E. F. Friedl
# 
# Example 1
# 
#     Input: $str = "you're given the job of checking the pages on a\nweb server for doubled words (such as 'this this'), a common problem\nwith documents subject to heavy editing."
#     Output: "web server for doubled words (such as '[this] [this]'), a common problem"
# 
# Example 2
# 
#     Input: $str = "Find doubled words despite capitalization differences, such as with 'The\nthe...', as well as allow differing amounts of whitespace (spaces,\ntabs, newlines, and the like) to lie between the words."
#     Output: "Find doubled words despite capitalization differences, such as with '[The]\n[the]...', as well as allow differing amounts of whitespace (spaces,"
# 
# Example 3
# 
#     Input: $str = "to make a word bold: '...it is <B>very</B> very important...'."
#     Output: "to make a word bold: '...it is <B>[very]</B> [very] important...'."
# 
# Example 4
# 
#     Input: $str = "Perl officially stands for Practical Extraction and Report Language, except when it doesn't."
#     Output: ""
# 
# Example 5
# 
#     Input: $str = "There's more than one one way to do it.\nEasy things should be easy and hard things should be possible."
#     Output: "There's more than [one] [one] way to do it."
# 

package require Tcl 8.6
package require tcltest

set cases {
    {"you're given the job of checking the pages on a\nweb server for doubled words (such as 'this this') a common problem\nwith documents subject to heavy editing."
        "web server for doubled words (such as '\[this] \[this]') a common problem"
        "Example 1"}
    {"Find doubled words despite capitalization differences such as with 'The\nthe...' as well as allow differing amounts of whitespace (spaces\ntabs newlines and the like) to lie between the words."
        "Find doubled words despite capitalization differences such as with '\[The]\n\[the]...' as well as allow differing amounts of whitespace (spaces"
        "Example 2"}
    {"to make a word bold: '...it is <B>very</B> very important...'."
        "to make a word bold: '...it is <B>\[very]</B> \[very] important...'."
        "Example 3"}
    {"Perl officially stands for Practical Extraction and Report Language except when it doesn't."
        ""
        "Example 4"}
    {"There's more than one one way to do it.\nEasy things should be easy and hard things should be possible."
        "There's more than \[one] \[one] way to do it."
        "Example 5"}
}

proc doubled_words {str} {
    set result [regsub -all -nocase {\m([a-z]+)\M((?:\s|<[^>]+>)+)\m(\1)\M} $str {[\1]\2[\3]}]
    set lines [split $result "\n"]
    set output {}
    foreach line $lines {
        if {[string first "\[" $line] >= 0} {
           lappend output $line
        }
    }
    return [join $output "\n"]
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        doubled_words [lindex $case 0]
    } [lindex $case 1]
}

exit 0


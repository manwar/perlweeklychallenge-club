#!/usr/bin/env tclsh

# Treat the string as a list, instead of using regular expressions
# like the perl version
proc task1 {S} {
    set words [lrange [split $S] 1 end-1]
    set totlen 0
    foreach word $words {
        incr totlen [string length $word]
    }
    puts $totlen
}

task1 "The Weekly Challenge"
task1 "The purpose of our lives is to be happy"


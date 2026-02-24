#!/usr/bin/env tclsh
#
# Task 2: Spellbound Sorting
# 
# Submitted by: Peter Campbell Smith
# 
# You are given an array of integers.  Write a script to return them in
# alphabetical order, in any language of your choosing. Default language is
# English.
# 
# Example 1
# 
#     Input: (6, 7, 8, 9 ,10)
#     Output: (8, 9, 7, 6, 10)
# 
#     eight, nine, seven, six, ten
# 
# Example 2
# 
#     Input: (-3, 0, 1000, 99)
#     Output: (-3, 99, 1000, 0)
# 
#     minus three, ninety-nine, one thousand, zero
# 
# Example 3
# 
#     Input: (1, 2, 3, 4, 5)
# 
#     Output: (5, 2, 4, 3, 1) for French language
#     cinq, deux, quatre, trois, un
# 
#     Output: (5, 4, 1, 3, 2) for English language
#     five, four, one, three, two
# 
# Example 4
# 
#     Input: (0, -1, -2, -3, -4)
#     Output: (-4, -1, -3, -2, 0)
# 
#     minus four, minus one, minus three, minus two, zero
# 
# Example 5
# 
#     Input: (100, 101, 102)
#     Output: (100, 101, 102)
# 
#     one hundred, one hundred and one, one hundred and two
# 

package require Tcl 8.6
package require tcltest

set cases {
    {{  6   7    8  9 10} {8 9 7 6 10}    "Example 1"}
    {{ -3   0 1000 99}    {-3 99 1000 0}  "Example 2"}
    {{  1   2    3  4  5} {5 4 1 3 2}     "Example 3"}
    {{  0  -1   -2 -3 -4} {-4 -1 -3 -2 0} "Example 4"}
    {{100 101  102}       {100 101 102}   "Example 5"}
}

proc spellbound_sorting {ints} {
    proc int2word {num} {
        set units {zero one two three four five six seven eight nine}
        set teens {ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen}
        set tens  {zero ten twenty thirty forty fifty sixty seventy eighty ninety}
        set scales {zero thousand million billion trillion}

        if {$num < 0} {
            return "minus [int2word [expr -1 * $num]]"
        } elseif {$num < 10} {
            return [lindex $units $num]
        } elseif {$num < 20} {
            return [lindex $teens [expr $num - 10]]
        } elseif {$num < 100} {
            set tenPart [expr int($num / 10)]
            set unitPart [expr $num % 10]
            return "[lindex $tens $tenPart][expr {$unitPart ? "-[lindex $units $unitPart]" : ""}]"
        } elseif {$num < 1000} {
            set hundredPart [expr int($num / 100)]
            set restPart [expr $num % 100]
            return "[lindex $units $hundredPart] hundred[expr {$restPart > 0 ? " and [int2word $restPart]" : ""}]"
        } else {
            set scaleIndex [expr int(log($num) / log(1000))]
            set scaleValue [expr pow(1000, $scaleIndex)]
            set majorPart [expr int($num / $scaleValue)]
            set restPart [expr $num % int($scaleValue)]
            return "[int2word $majorPart] [lindex $scales $scaleIndex][expr {$restPart > 0 ? " [int2word $restPart]" : ""}]"
        }
    }

    proc range {from to} {
        if {$to > $from} {
            concat [range $from [incr to -1]] $to
        }
    }

    proc compare_words {a b} {
        upvar words words
        return [string compare [lindex $words $a] [lindex $words $b]]
    }

    set words {}
    foreach num $ints {
        lappend words [int2word $num]
    }

    set sortedIndices [lsort -command compare_words [range 0 [llength $ints]]]
    
    set result {}
    foreach idx $sortedIndices {
        lappend result [lindex $ints $idx]
    }
    return $result
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        spellbound_sorting [lindex $case 0]
    } [lindex $case 1]
}

exit 0


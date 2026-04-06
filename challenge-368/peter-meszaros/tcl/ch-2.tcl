#!/usr/bin/env tclsh
#
# Task 2: Big and Little Omega
# 
# Submitted by: Roger Bell_West
# 
# You are given a positive integer $number and a mode flag $mode. If the mode
# flag is zero, calculate little omega (the count of all distinct prime factors
# of that number). If it is one, calculate big omega (the count of all prime
# factors including duplicates).
# 
# Example 1
# 
#     Input: $number = 100061
#            $mode = 0
#     Output: 3
# 
#     Prime factors are 13, 43, 179. Count is 3.
# 
# Example 2
# 
#     Input: $number = 971088
#            $mode = 0
#     Output: 3
# 
#     Prime factors are 2, 2, 2, 2, 3, 20231. Count of distinct numbers is 3.
# 
# Example 3
# 
#     Input: $number = 63640
#            $mode = 1
#     Output: 6
# 
#     Prime factors are 2, 2, 2, 5, 37, 43. Count including duplicates is 6.
# 
# Example 4
# 
#     Input: $number = 988841
#            $mode = 1
#     Output: 2
# 
# Example 5
# 
#     Input: $number = 211529
#            $mode = 0
#     Output: 2
# 

package require Tcl 8.6
package require tcltest

set cases {
    {{100061 0} 3 "Example 1"}
    {{971088 0} 3 "Example 2"}
    {{ 63640 1} 6 "Example 3"}
    {{988841 1} 2 "Example 4"}
    {{211529 0} 2 "Example 5"}
}

proc big_and_little_omega {p} {
    proc  prime_factors {n} {
        set factors {}
        for {set i 2} {$i <= sqrt($n)} {incr i} {
            while {$n % $i == 0} {
                lappend factors $i
                set n [expr $n / $i]
            }
        }
        if {$n > 1} {
            lappend factors $n
        }
        return $factors
    }

    set number [lindex $p 0]
    set mode   [lindex $p 1]

    set big_omega [prime_factors $number]
    set little_omega {}
    foreach k $big_omega v 1 {
        dict lappend little_omega $k $v
    }
    set little_omega [dict keys $little_omega]
    return [expr $mode ? [llength $big_omega] : [llength $little_omega]]
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        big_and_little_omega [lindex $case 0]
    } [lindex $case 1]
}

exit 0


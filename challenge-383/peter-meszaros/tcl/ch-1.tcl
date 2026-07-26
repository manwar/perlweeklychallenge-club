#!/usr/bin/env tclsh
#
# Task 1: Similar List
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given three list of strings.  Write a script to find out if the first
# two list are similar with the help the third list. The third list contains the
# similar words map.
# 
# Example 1
# 
#     Input: $list1 = ("great", "acting")
#            $list2 = ("fine", "drama")
#            $list3 = (["great", "fine"], ["acting", "drama"])
#     Output: true
# 
# Example 2
# 
#     Input: $list1 = ("apple", "pie")
#            $list2 = ("banana", "pie")
#            $list3 = (["apple", "peach"], ["peach", "banana"])
#     Output: false
# 
# Example 3
# 
#     Input: $list1 = ("perl4", "python")
#            $list2 = ("raku", "python")
#            $list3 = (["perl4", "perl5", "raku"])
#     Output: true
# 
# Example 4
# 
#     Input: $list1 = ("enjoy", "challenge")
#            $list2 = ("love", "weekly", "challenge")
#            $list3 = (["enjoy", "love"])
#     Output: false
# 
# Example 5
# 
#     Input: $list1 = ("fast", "car")
#            $list2 = ("quick", "vehicle")
#            $list3 = (["quick", "fast"], ["vehicle", "car"])
#     Output: true
# 

package require Tcl 8.6
package require tcltest

set cases {
    {{{"great" "acting"}
      {"fine" "drama"}
      {{"great" "fine"} {"acting" "drama"}}}
      true
      "Example 1"
    }
    {{{"apple" "pie"}
      {"banana" "pie"}
      {{"apple" "peach"} {"peach" "banana"}}}
      false
      "Example 2"
    }
    {{{"perl4" "python"}
      {"raku" "python"}
      {{"perl4" "perl5" "raku"}}}
      true
      "Example 3"
    }
    {{{"enjoy" "challenge"}
      {"love" "weekly" "challenge"}
      {{"enjoy" "love"}}}
      false
      "Example 4"
    }
    {{{"fast" "car"}
      {"quick" "vehicle"}
      {{"quick" "fast"} {"vehicle" "car"}}}
      true
      "Example 5"
    }
}

proc similar_list {p} {
    set list1 [lindex $p 0]
    set list2 [lindex $p 1]
    set list3 [lindex $p 2]

    if {[llength $list1] != [llength $list2]} {
        return false
    }

    for {set i 0} {$i < [llength $list1]} {incr i} {
        set item1 [lindex $list1 $i]
        set item2 [lindex $list2 $i]

        if {$item1 eq $item2} {
            continue
        }

        set found false
        foreach similars $list3 {
            if {[lsearch -exact $similars $item1] != -1 && \
                [lsearch -exact $similars $item2] != -1} {
                set found true
                break
            }
        }
        return $found
    }
    return true
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        similar_list [lindex $case 0]
    } [lindex $case 1]
}

exit 0


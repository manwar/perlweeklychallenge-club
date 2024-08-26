#!/usr/bin/env tclsh
#
# Task 2: Relative Sort
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given two list of integers, @list1 and @list2. The elements in the
# @list2 are distinct and also in the @list1.
# 
# Write a script to sort the elements in the @list1 such that the relative order
# of items in @list1 is same as in the @list2. Elements that is missing in @list2
# should be placed at the end of @list1 in ascending order.
# 
# Example 1
# 
# 	Input: @list1 = (2, 3, 9, 3, 1, 4, 6, 7, 2, 8, 5)
# 		   @list2 = (2, 1, 4, 3, 5, 6)
# 	Ouput: (2, 2, 1, 4, 3, 3, 5, 6, 7, 8, 9)
# 
# Example 2
# 
# 	Input: @list1 = (3, 3, 4, 6, 2, 4, 2, 1, 3)
# 		   @list2 = (1, 3, 2)
# 	Ouput: (1, 3, 3, 3, 2, 2, 4, 4, 6)
# 
# Example 3
# 
# 	Input: @list1 = (3, 0, 5, 0, 2, 1, 4, 1, 1)
# 		   @list2 = (1, 0, 3, 2)
# 	Ouput: (1, 1, 1, 0, 0, 3, 2, 4, 5)
# 

package require tcltest

set cases {
	{{{2 3 9 3 1 4 6 7 2 8 5} {2 1 4 3 5 6}}
     {2 2 1 4 3 3 5 6 7 8 9} "Example 1"}
    {{{3 3 4 6 2 4 2 1 3} {1 3 2}}
     {1 3 3 3 2 2 4 4 6}     "Example 2"}
    {{{3 0 5 0 2 1 4 1 1} {1 0 3 2}}
     {1 1 1 0 0 3 2 4 5}     "Example 3"}
}

proc compare {a b} {
    upvar 1 d dlocal

    set v1 [dict get $dlocal $a]
    set v2 [dict get $dlocal $b]

    if {$v1 < $v2} {
        return -1
    } elseif {$v1 > $v2} {
        return +1
    }
    return 0
}

proc relative_sort {lists} {
   set l1 [lindex $lists 0]
   set l2 [lindex $lists 1]

   set d {}
   for {set i 0} {$i < [llength $l2]} {incr i} {
       dict set d [lindex $l2 $i] $i
   }

   foreach i $l1 {
       if {[dict exists $d $i]} {
           lappend res $i
       } else {
           lappend rem $i
       }
   }
   set rem [lsort -integer $rem]
   set res [lsort -command compare $res]
   lappend res {*}$rem
   return $res
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        relative_sort [lindex $case 0]
    } [lindex $case 1]
}

exit 0

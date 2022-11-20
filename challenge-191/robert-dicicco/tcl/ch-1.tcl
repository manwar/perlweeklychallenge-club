#!/usr/bin/env tclsh



set comment {

  AUTHOR: Robert DiCicco

  DATE: 2022-11-14

  Challenge 191 Twice Largest ( Tcl )



  You are given list of integers, @list.

  Write a script to find out whether the largest item in the

  list is at least twice as large as each of the other items.

}



set arr {{1 2 3 4} {1 2 0 5} {2 6 3 1} {4 5 2 3}}



foreach lst $arr {

  puts "Input: @list = \($lst\)"

  set max [tcl::mathfunc::max {*}$lst]

  set result "good"

  set lst [lsort $lst]

  set x 0

  set len [llength $lst]

  while { $x < $len - 1} {

    set dubl [expr { 2 * [lindex $lst $x]}]

    if {$dubl > $max}  {

      puts "Output: -1\n"

      set result "bad"

      break

    }

    incr x

  }

  if {$result eq "good"} { puts "Output: 1\n" }

}



set comment {



SAMPLE OUTPUT

Input: @list = (1 2 3 4)

Output: -1



Input: @list = (1 2 0 5)

Output: 1



Input: @list = (2 6 3 1)

Output: 1



Input: @list = (4 5 2 3)

Output: -1



}

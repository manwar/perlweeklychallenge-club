#!/usr/bin/env tclsh

set comment {

  AUTHOR: Robert DiCicco

  DATE: 2022-10-26

  Challenge 188 Divisible Pairs  ( Tcl )



  You are given list of integers @list of size $n and divisor $k.

  Write a script to find out count of pairs in the given list that satisfies the following rules.



  The pair (i, j) is eligible if and only if

  a) 0 <= i < j < len(list)

  b) list[i] + list[j] is divisible by k

}



set list1 {{4 5 1 6}  {1 2 3 4}  {1 3 4 5}  {5 1 2 3} {7 2 4 5}}

set ks {2 2 3 4 4}

set cnt 0



proc permutations {list} {

  if {[llength $list] == 1} {

      return $list

  }

  set ret [list]

  set pitem [lindex $list end]

  set rest [permutations [lrange $list 0 end-1]]



  # Right now insert our item at every position in the list

  foreach item $rest {

      for {set i 0} {$i < [llength $item]} {incr i} {

          lappend ret [linsert $item $i $pitem]

      }

      lappend ret [concat $item $pitem]

  }

  return [lsort $ret]

}



foreach item $list1 {

  set k [lindex $ks $cnt]

  puts "Input @list = \($item\), k = $k"

  set out {}

  set a [ permutations $item ]

  foreach x $a {

    set i  [lindex $x 0]

    set j  [lindex $x 1]

    set sz [llength $x]

    if { $i < $j }  {

      if [expr ($i+$j) % $k == 0] {

        lappend out $i$j

      }

    }

  }

  puts -nonewline "Output: "

  puts [llength [lsort -unique $out]]

  puts " "

  incr cnt

}



set comment {

  ----------------------------------------------------------------

  SAMPLE OUTPUT



  PS G:\Projects\Perl\Challenges> tclsh .\DivisiblePairs.tcl

  Input @list = (4 5 1 6), k = 2

  Output: 2



  Input @list = (1 2 3 4), k = 2

  Output: 2



  Input @list = (1 3 4 5), k = 3

  Output: 2



  Input @list = (5 1 2 3), k = 4

  Output: 2



  Input @list = (7 2 4 5), k = 4

  Output: 1

}

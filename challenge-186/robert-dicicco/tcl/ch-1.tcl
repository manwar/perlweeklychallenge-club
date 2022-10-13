#!/usr/bin/env tclsh

# AUTHOR: Robert DiCicco
# DATE: 2022-10-12
# Challenge 186 Zip List ( Tcl )

set a {abc}

set b {123}

proc zip {arr1 arr2} {

  for {set i 0} {$i < 3} {incr i} {

    set first [string range $arr1 $i $i]

    set second [string range $arr2 $i $i]

    puts -nonewline "$first $second "

  }

  puts " "

}

global a b

zip $a $b

zip $b $a

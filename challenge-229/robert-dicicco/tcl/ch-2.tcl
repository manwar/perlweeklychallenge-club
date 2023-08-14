#!/usr/bin/env tclsh
set comment {
------------------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-08-11
Challenge 229 Two Out Of Three  Task 2 ( Tcl )
------------------------------------------------
}

set arr {{ 1 1 2 4} {2 4} {4}}
#set arr {{4 1} {2 4} {1 2}}

global hash
global arr

array set hash {}

proc uniqueList {list} {
  set new {}
  foreach item $list {
    if {[lsearch $new $item] < 0} {
      lappend new $item
    }
  }
  return $new
}

puts -nonewline "Input:"
foreach a $arr {
    puts "\t ($a)"
    set a [uniqueList $a]
    foreach elem $a {
        if {[info exists hash($elem)]} {
            incr hash($elem)
        } else {
            set hash($elem) 1
        }
    }
}

#parray hash

puts -nonewline "Output: ("
foreach {key value} [array get hash] {
    if {$value >=2} {
    puts -nonewline "$key "
    }
}
puts ")"

set comment {
------------------------------------------------
SAMPLE OUTPUT
tclsh .\TwoThree.tcl
Input:   ( 1 1 2 4)
         (2 4)
         (4)
Output: (4 2 )

tclsh .\TwoThree.tcl
Input:   (4 1)
         (2 4)
         (1 2)
Output: (4 1 2 )
------------------------------------------------
}




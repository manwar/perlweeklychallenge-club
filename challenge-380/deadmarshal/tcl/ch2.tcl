package require tcltest
namespace import tcltest::*

proc reverse_degree {str} {
  set m {}
  for {set i 0} {$i < 26} {incr i} {
    set letter [format %c [expr {$i + 97}]]
    set value [expr {26 - $i}]
    lappend m $letter $value
  }
  
  set sum 0
  set idx 1
  foreach ch [split [string tolower $str] ""] {
    set value [dict get $m $ch]
    set sum [expr {$sum + ($value * $idx)}]
    incr idx
  }
  return $sum
}

test reverse_degree-1 {Example 1} -body {
  reverse_degree "z"
} -result 1

test reverse_degree-2 {Example 2} -body {
  reverse_degree "a"
} -result 26

test reverse_degree-3 {Example 3} -body {
  reverse_degree "bbc"
} -result 147

test reverse_degree-4 {Example 4} -body {
  reverse_degree "racecar"
} -result 560

test reverse_degree-5 {Example 5} -body {
  reverse_degree "zyx"
} -result 14

cleanupTests


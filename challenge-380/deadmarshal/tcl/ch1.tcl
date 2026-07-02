package require tcltest
namespace import ::tcltest::*

proc sum_of_frequencies {s} {
  set h [dict create]
  foreach c [split [string tolower $s] ""] {
    if {$c ne ""} {
      dict incr h $c
    }
  }
  set c 0
  set v 0
  dict for {ch count} $h {
    if {[string match {[aeiou]} $ch]} {
      if {$count > $v} {set v $count}
    } else {
      if {$count > $c} {set c $count}
    }
  }
  return [expr {$c + $v}]
}

test sum-1 "Example 1" {
  sum_of_frequencies "banana"
} 5

test sum-2 "Example 2" {
  sum_of_frequencies "teestett"
} 7

test sum-3 "Example 3" {
  sum_of_frequencies "aeiouuaa"
} 3

test sum-4 "Example 4" {
  sum_of_frequencies "rhythm"
} 2

test sum-5 "Example 5" {
  sum_of_frequencies "x"
} 1

cleanupTests


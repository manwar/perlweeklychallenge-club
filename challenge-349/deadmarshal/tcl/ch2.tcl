proc meeting_point {s} {
  set x 0
  set y 0
  foreach c [split $s ""] {
    switch $c {
      "U" {incr y}
      "R" {incr x}
      "D" {incr y -1}
      "L" {incr x -1}
    }
  }
  return [expr {$x == 0 && $y == 0}]
}

puts [meeting_point "ULD"]
puts [meeting_point "ULDR"]
puts [meeting_point "UUURRRDDD"]
puts [meeting_point "UURRRDDLLL"]
puts [meeting_point "RRUULLDDRRUU"]


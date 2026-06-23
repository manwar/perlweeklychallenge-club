proc isArmstrong {base limit} {
  set range [range 0 $limit]
  set res {}
  foreach n $range {
    set digits [split $n ""]
    set num_digits [llength $digits]
    set sum 0
    set value 0
    foreach digit $digits {
      set value [expr {$value * $base + $digit}]
      set sum [expr {$sum + ($digit ** $num_digits)}]
    }
    if {$value == $sum} {
      lappend res $n
    }
  }
  return $res
}

proc range {start end} {
  set res {}
  for {set i $start} {$i <= $end} {incr i} {
    lappend res $i
  }
  return $res
}

puts [isArmstrong 10 1000]
puts [isArmstrong 7 1000]
puts [isArmstrong 16 1000]


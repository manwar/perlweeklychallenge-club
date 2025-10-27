proc array_form_compute {arr k} {
  set i [expr {[llength $arr] - 1}]
  set carry 0
  set res {}
  while {$i >= 0 || $k > 0 || $carry > 0} {
    if {$i >= 0} {
      set d [lindex $arr $i]
      incr i -1
    } else {
      set d 0
    }
    set carry [expr {$carry + $d + $k % 10}]
    set res [linsert $res 0 [expr {$carry % 10}]]
    set carry [expr {$carry / 10}]
    set k [expr {$k / 10}]
  }
  return $res
}

puts [array_form_compute {1 2 3 4} 12]
puts [array_form_compute {2 7 4} 181]
puts [array_form_compute {9 9 9} 1]
puts [array_form_compute {1 0 0 0 0} 9999]
puts [array_form_compute {0} 1000]


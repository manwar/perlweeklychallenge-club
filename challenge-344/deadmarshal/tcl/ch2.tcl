proc array_formation {source target} {
  set i 0
  set target_len [llength $target]
  
  while {$i < $target_len} {
    set k 0
    set found 0
    set source_len [llength $source]
    
    while {$k < $source_len} {
      set sublist [lindex $source $k]
      if {[lindex $sublist 0] == [lindex $target $i]} {
	set found 1
	break
      }
      incr k
    }
    
    if {!$found} {
      return false
    }
    
    set sublist [lindex $source $k]
    set j 0
    set sublist_len [llength $sublist]
    
    while {$j < $sublist_len && $i < $target_len && \
	     [lindex $sublist $j] == [lindex $target $i]} {
      incr i
      incr j
    }
  }
  
  return true
}

puts [array_formation {{2 3} {1} {4}} {1 2 3 4}]
puts [array_formation {{1 3} {2 4}} {1 2 3 4}]
puts [array_formation {{9 1} {5 8} {2}} {5 8 2 9 1}]
puts [array_formation {{1} {3}} {1 2 3}]
puts [array_formation {{7 4 6}} {7 4 6}]


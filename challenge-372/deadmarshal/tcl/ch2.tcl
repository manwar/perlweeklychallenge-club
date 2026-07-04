proc largest_string {s} {
  set res 0
  set len [string length $s]
  for {set l 0} {$l < $len - 1} {incr l} {
    for {set r [expr {$len - 1}]} {$r > $l} {incr r -1} {
      if {[string index $s $l] == [string index $s $r]} {
	set res [expr {max($r - $l - 1,$res)}]
      }
      break
    }
  }
  return $res
}

puts [largest_string "aaaaa"]
puts [largest_string "abcdeba"]
puts [largest_string "abbc"]
puts [largest_string "abcaacbc"]
puts [largest_string "laptop"]


proc power_string {s} {
  set res 1
  set temp 1
  set len [string length $s]
  for {set i 1} {$i < $len} {incr i} {
    set c [string index $s $i]
    set prev [string index $s [expr {$i - 1}]]

    if {$c == $prev} {
      incr temp
      if {$temp > $res} {
	set res $temp
      }
    } else {
      set temp 1
    }
  }
  return $res
}

puts [power_string "textbook"]
puts [power_string "aaaaa"]
puts [power_string "hoorayyy"]
puts [power_string "x"]
puts [power_string "aabcccddeeffffghijjk"]


set s 2
puts $s
for {set i 1} {$i <= 9} {incr i} {
    set s [expr ($s * ($s - 1) + 1)]
    puts $s
}

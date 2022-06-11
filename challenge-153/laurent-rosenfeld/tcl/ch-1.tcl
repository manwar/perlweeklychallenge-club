set left_fact 1
set fact 1
puts -nonewline $left_fact

for {set i 1} {$i <= 10} {incr i} {
    puts -nonewline "${left_fact} "
    set fact [expr $fact * $i]
    set left_fact [expr $left_fact + $fact]

}
puts ""

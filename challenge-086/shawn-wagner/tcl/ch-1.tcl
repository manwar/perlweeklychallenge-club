#!/usr/bin/env tclsh
package require generator ;# From tcllib

generator define genpairs {list} {
    for {set m 0} {$m < [llength $list]} {incr m} {
        for {set n 0} {$n < [llength $list]} {incr n} {
            if {$m != $n} {
                generator yield [::list [lindex $list $m] [lindex $list $n]]
            }
        }
    }
}

proc diffne {total pair} {
    lassign $pair a b
    expr {$a - $b != $total}
}

proc task1 {N A} {
    generator foreach match [generator dropWhile [list diffne $A] [genpairs $N]] {
        lassign $match a b
        puts "1 as $a - $b = $A"
        return
    }
    puts 0
}

task1 {10 8 12 15 5} 7
task1 {1 5 2 9 7} 6
task1 {10 30 20 50 40} 15

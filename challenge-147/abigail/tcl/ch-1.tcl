#!/usr/local/opt/tcl-tk/bin/tclsh

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-147
#

#
# Run as: tclsh ch-1.tcl
#

proc is_prime n {
    if {$n == 2} {return 1}
    if {$n % 2 == 0} {return 0}
    for {set i 3} {$i * $i <= $n} {incr i 2} {
        if {$n % $i == 0} {return 0}
    }
    return 1
}

set todo  {2 3 5 7}
set count [expr 20 - [llength $todo]]

puts -nonewline $todo
puts -nonewline " "

while {[llength $todo] > 0} {
    set new_todo {}
    foreach d [split 123456789 ""] {
        foreach p $todo {
            set candidate $d$p
            if {[is_prime $candidate]} {
                puts -nonewline $candidate
                puts -nonewline " "
                incr count -1
                lappend new_todo $candidate
                if {$count <= 0} {
                    break
                }
            }
            if {$count <= 0} {
                break
            }
        }
        if {$count <= 0} {
            break
        }
    }
    set todo $new_todo
}

puts ""


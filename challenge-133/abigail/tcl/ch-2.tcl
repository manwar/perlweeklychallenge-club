#
# See ../README.md
#

#
# Run as: tclsh ch-2.tcl
#

set small_primes {2 3 5 7 11 13 17 19 23 29 31}
set count  10
set base   10


proc factors {number} {
    global small_primes
    set f {}
    foreach prime $small_primes {
        while {($number % $prime) == 0} {
            lappend f $prime
            set number [expr $number / $prime]
        }
    }
    if {$number > 1} {
        lappend f $number
    }
    return $f
}

proc digitsum {numbers} {
    global base
    set sum 0
    foreach number $numbers {
        while {$number > 0} {
            incr sum    [expr $number % $base]
            set  number [expr $number / $base]
        }
    }
    return $sum
}

set n 1
while {$count > 0} {
    incr n
    set ff [factors $n]
    if {[llength $ff] > 1 && [digitsum $n] == [digitsum $ff]} {
        puts $n
        incr count -1
    }
}


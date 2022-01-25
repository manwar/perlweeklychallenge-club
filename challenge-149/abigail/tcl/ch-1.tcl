#!/usr/local/opt/tcl-tk/bin/tclsh

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-149
#

#
# Run as: tclsh ch-1.tcl < input-file
#

proc digit_sum number {
    set base 10
    set sum   0
    while {$number > 0} {
        incr sum    [expr      $number % $base]
        set  number [expr int ($number / $base)]
    }
    return $sum
}

set fib [dict create]
set fib_prev 0
set fib_last 1
dict set fib $fib_prev 1
dict set fib $fib_last 1

proc is_fib n {
    global fib fib_prev fib_last
    while {$fib_last < $n} {
        set t        $fib_last
        set fib_last [expr $fib_last + $fib_prev]
        set fib_prev $t
        dict set fib $fib_last 1
    }
    return [dict exists $fib $n]
}

while {[gets stdin n] >= 0} {
    for {set k 0} {$n > 0} {incr k} {
        if {[is_fib [digit_sum $k]]} {
            puts -nonewline "${k} "
            incr n -1
        }
    }
    puts ""
}

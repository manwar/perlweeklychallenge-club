#!/usr/bin/env tclsh
package require generator ;# From tcllib

# Use generators to return each possible variation of the list on
# demand instead of calculating them all at once.

generator define combinations {A} {
    set len [llength $A]
    switch $len {
        0 { generator yield {} }
        1 {
            generator yield $A -$A
        }
        default {
            set A [lassign $A elem]
            generator foreach sublist [combinations $A] {
                generator yield [concat $elem $sublist]
                generator yield [concat -$elem $sublist]
            }
        }
    }
}

proc sumpair {lst} {
    list [::tcl::mathop::+ {*}$lst] $lst
}

proc ispositive {pair} {
    expr {[lindex $pair 0] > 0}
}

proc minpair {a b} {
    if {[lindex $a 0] < [lindex $b 0]} {
        return $a
    } else {
        return $b
    }
}

proc task2 {A} {
    set sums [generator map sumpair [combinations $A]]
    set positives [generator filter ispositive $sums]
    generator next $positives head
    set minsum [generator reduce minpair $head $positives]
    puts [llength [lmap elem [lindex $minsum 1] {
        if {$elem < 0} {
            set elem
        } else {
            continue
        }
    }]]
}

task2 {3 10 8}
task2 {12 2 10}


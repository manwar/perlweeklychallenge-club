#!/usr/local/opt/tcl-tk/bin/tclsh

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-148
#

#
# Run as: tclsh ch-2.tcl
#

set COUNT 5
set A     0
set B     1
set C     2
set SUM   3
set out   {}
for {set i 0} {$i < $COUNT} {incr i} {
    lset out $i $A             999999
    lset out $i $B             999999
    lset out $i $C             999999
    lset out $i $SUM [expr 3 * 999999]
}

set max_index 0

for {set k 0} {$k < [lindex $out $max_index $SUM]} {incr k} {
    set a  [expr 3 * $k + 2]
    set f1 [expr     $k + 1]
    set f2 [expr 8 * $k + 5]

    set d1 {}
    for {set i 1} {$i * $i <= $f1} {incr i} {
        if {$f1 % $i == 0} {
            lappend d1 $i
            if {$i != $f1 / $i} {
                lappend d1 [expr $f1 / $i]
            }
        }
    }

    set d2 {}
    for {set i 1} {$i * $i <= $f2} {incr i} {
        if {$f2 % $i == 0} {
            set s1 [expr isqrt ($i)]
            set s2 [expr isqrt ($f2 / $i)]
            if {$s1 * $s1 == $i} {
                lappend d2 $s1
            }
            if {$s2 * $s2 == $f2 / $i && $s1 != $s2} {
                lappend d2 $s2
            }
        }
    }

    foreach d1v $d1 {
        foreach d2v $d2 {
            set b [expr $d1v * $d2v]
            set c [expr $f1 * $f1 * $f2 / ($b * $b)]
            if {$a + $b + $c < [lindex $out $max_index $SUM]} {
                set seen 0
                for {set i 0} {$i < $COUNT} {incr i} {
                    if {[lindex $out $i $A] == $a && \
                        [lindex $out $i $B] == $b} {
                        set seen 1
                    }
                }
                if {$seen > 0} {
                    break
                }

                lset out $max_index $A $a
                lset out $max_index $B $b
                lset out $max_index $C $c
                lset out $max_index $SUM [expr $a + $b + $c]

                set max_index 0
                set max_sum [lindex $out $max_index $SUM]
                for {set i 1} {$i < $COUNT} {incr i} {
                    if {$max_sum < [lindex $out $i $SUM]} {
                        set max_sum [lindex $out $i $SUM]
                        set max_index $i
                    }
                }
            }
        }
    }
}

foreach row $out {
    puts -nonewline [lindex $row $A]
    puts -nonewline " "
    puts -nonewline [lindex $row $B]
    puts -nonewline " "
    puts            [lindex $row $C]
}

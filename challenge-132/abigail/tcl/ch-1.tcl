#
# See ../README.md
#

#
# Run as: tclsh ch-1.tcl < input-file
#

proc idiv {a b} {
    set sign 1
    if {$a < 0} {
        set sign [expr  $sign * -1]
        set a    [expr -$a]
    }
    if {$b < 0} {
        set sign [expr  $sign * -1]
        set b    [expr -$b]
    }
    return [expr $sign * ($a / $b)]
}

proc g2j {Y M D} {
    set M14 [expr $M - 14]
    set M12 [idiv $M14 12]
    set e1  [idiv [expr 1461 * ($Y + 4800 + $M12)] 4]
    set e2  [idiv [expr  367 * ($M - 2 - 12 * $M12)] 12]
    set e3  [idiv [expr   $Y + 4900 + $M12] 100]
    set e4  [idiv [expr 3 * $e3] 4]
    return  [expr $e1 + $e2 - $e4 + $D - 32075]
}

proc j2g {J} {
    set e [expr 4 * ($J + 1401 + (((4 * $J + 274277) / 146097) * 3) / 4 \
              - 38) + 3]
    set D [expr  ((5 * (($e % 1461) / 4) + 2) % 153) / 5 + 1]
    set M [expr (((5 * (($e % 1461) / 4) + 2) / 153 + 2) % 12) + 1]
    set Y [expr ($e / 1461) - 4716 + (12 + 2 - $M) / 12]
    return "$Y $M $D"
}

set julian_today [g2j 2021 9 22]

while {[gets stdin line] >= 0} {
    lassign [split $line "/"] year month date
    if {[string index $month 0] eq "0"} {
        set month [string index $month 1]
    }
    if {[string index $date 0] eq "0"} {
        set date [string index $date 1]
    }
    set julian_then [g2j $year $month $date]
    lassign [j2g [expr 2 * $julian_then  - $julian_today]] Y1 M1 D1
    lassign [j2g [expr 2 * $julian_today - $julian_then]]  Y2 M2 D2
    puts [format "%04d/%02d/%02d, %04d/%02d/%02d" $Y1 $M1 $D1 $Y2 $M2 $D2]
}

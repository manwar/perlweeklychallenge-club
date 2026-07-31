#!/usr/bin/env tclsh
#
# Task 2: Nearest RGB
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a 6-digit hex color.  Write a script to round the RGB channels to
# the nearest web-safe value and return the nearest RGB color.  00 (0), 33 (51),
# 66 (102), 99 (153), CC (204) and FF (255)
# 
# Example 1
# 
#     Input: $color = "#F4B2D1"
#     Output: "#FF99CC"
# 
#     Red: F4 (Decimal 244), closer to 255 => FF
#     Green: B2 (Decimal 178), closer to 153 => 99
#     Blue: D1 (Decimal 209), closer to 204 => CC
#     So the nearest RGB: "#FF99CC"
# 
# Example 2
# 
#     Input: $color = "#15E6E5"
#     Output: "#00FFCC"
# 
#     Red: 15 (Decimal 21), closer to 0 => 00
#     Green: E6 (Decimal 230), closer to 255 => FF
#     Blue: E5 (Decimal 229), closer to 204 => CC
# 
# Example 3
# 
#     Input: $color = "#191A65"
#     Output: "#003366"
# 
#     Red: 19 (Decimal 25), closer to 0 => 00
#     Green: 1A (Decimal 26), closer to 51 => 33
#     Blue: 65 (Decimal 101), closer to 102 => 66
# 
# Example 4
# 
#     Input: $color = "#2D5A1B"
#     Output: "#336633"
# 
#     Red: 2D (Decimal 45), closer to 51 => 33
#     Green: 5A (Decimal 90), closer to 102 => 66
#     Blue: 1B (Decimal 27), closer to 51 => 33
# 
# Example 5
# 
#     Input: $color = "#00FF66"
#     Output: "#00FF66"
# 
#     Red: 00 (Decimal 0), closer to 0 => 00
#     Green: FF (Decimal 255), closer to 255 => FF
#     Blue: 66 (Decimal 102), closer to 102 => 66
# 

package require Tcl 8.6
package require tcltest

set cases {
    {"#F4B2D1" "#FF99CC" "Example 1"}
    {"#15E6E5" "#00FFCC" "Example 2"}
    {"#191A65" "#003366" "Example 3"}
    {"#2D5A1B" "#336633" "Example 4"}
    {"#00FF66" "#00FF66" "Example 5"}
}

proc nearest_rgb {color} {
    set ranges_dec { 0 51 102 153 204 255}
    set ranges_hex {00 33  66  99  CC  FF}

    regexp {#(..)(..)(..)} $color -> r g b
    set rgb [list [scan $r %x] [scan $g %x] [scan $b %x]]

    for {set i 0} {$i < 3} {incr i} {
        set closest_idx 0
        for {set j 1} {$j < [llength $ranges_dec]} {incr j} {
            if {[expr abs([lindex $rgb $i] - [lindex $ranges_dec $j])] <
                [expr abs([lindex $rgb $i] - [lindex $ranges_dec $closest_idx])]} {
                set closest_idx $j
            }
        }
        lset rgb $i $closest_idx
    }

    return "#[lindex $ranges_hex [lindex $rgb 0]][lindex $ranges_hex [lindex $rgb 1]][lindex $ranges_hex [lindex $rgb 2]]"
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        nearest_rgb [lindex $case 0]
    } [lindex $case 1]
}

exit 0


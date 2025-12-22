#!/usr/bin/env tclsh
#
# Task 2: Validate Coupon
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given three arrays, @codes, @names and @status.
# 
# Write a script to validate codes in the given array.
# 
# A code is valid when the following conditions are true:
# 
#     - codes[i] is non-empty and consists only of alphanumeric characters (a-z,
#     A-Z, 0-9) and underscores (_).
# 
#     - names[i] is one of the following four categories: "electronics",
#     "grocery", "pharmacy", "restaurant".
# 
#     - status[i] is true.
# 
# Return an array of booleans indicating validity: output[i] is true if and only
# if codes[i], names[i] and status[i] are all valid.
# 
# Example 1
# 
#     Input: @codes  = ("A123", "B_456", "C789", "D@1", "E123")
#            @names  = ("electronics", "restaurant", "electronics", "pharmacy", "grocery")
#            @status = ("true", "false", "true", "true", "true")
#     Output: (true, false, true, false, true)
# 
# Example 2
# 
#     Input: @codes  = ("Z_9", "AB_12", "G01", "X99", "test")
#            @names  = ("pharmacy", "electronics", "grocery", "electronics", "unknown")
#            @status = ("true", "true", "false", "true", "true")
#     Output: (true, true, false, true, false)
# 
# Example 3
# 
#     Input: @codes  = ("_123", "123", "", "Coupon_A", "Alpha")
#            @names  = ("restaurant", "electronics", "electronics", "pharmacy", "grocery")
#            @status = ("true", "true", "false", "true", "true")
#     Output: (true, true, false, true, true)
# 
# Example 4
# 
#     Input: @codes  = ("ITEM_1", "ITEM_2", "ITEM_3", "ITEM_4")
#            @names  = ("electronics", "electronics", "grocery", "grocery")
#            @status = ("true", "true", "true", "true")
#     Output: (true, true, true, true)
# 
# Example 5
# 
#     Input: @codes  = ("CAFE_X", "ELEC_100", "FOOD_1", "DRUG_A", "ELEC_99")
#            @names  = ("restaurant", "electronics", "grocery", "pharmacy", "electronics")
#            @status = ("true", "true", "true", "true", "false")
#     Output: (true, true, true, true, false)
# 

package require Tcl 8.6
package require tcltest

set cases {
    {{{"A123" "B_456" "C789" "D@1" "E123"}
      {"electronics" "restaurant" "electronics" "pharmacy" "grocery"}
      {"true" "false" "true" "true" "true"}}
     {true false true false true} "Example 1"}
    {{{"Z_9" "AB_12" "G01" "X99" "test"}
      {"pharmacy" "electronics" "grocery" "electronics" "unknown"}
      {"true" "true" "false" "true" "true"}}
     {true true false true false} "Example 2"}
    {{{"_123" "123" "" "Coupon_A" "Alpha"}
      {"restaurant" "electronics" "electronics" "pharmacy" "grocery"}
      {"true" "true" "false" "true" "true"}}
     {true true false true true} "Example 3"}
    {{{"ITEM_1" "ITEM_2" "ITEM_3" "ITEM_4"}
      {"electronics" "electronics" "grocery" "grocery"}
      {"true" "true" "true" "true"}}
     {true true true true} "Example 4"}
    {{{"CAFE_X" "ELEC_100" "FOOD_1" "DRUG_A" "ELEC_99"}
      {"restaurant" "electronics" "grocery" "pharmacy" "electronics"}
      {"true" "true" "true" "true" "false"}}
     {true true true true false} "Example 5"}
}

proc validate_coupon {p} {
    set codes  [lindex $p 0]
    set names  [lindex $p 1]
    set status [lindex $p 2]

    set valid_names [list electronics grocery pharmacy restaurant]

    set results {}
    for {set i 0} {$i < [llength $codes]} {incr i} {
        set code [lindex $codes $i]
        set name [lindex $names $i]
        set stat [lindex $status $i]

        lappend results [expr ( \
            [string length $code] > 0 && [regexp {^\w+$} $code] && \
            [lsearch -exact $valid_names $name] != -1 && \
            $stat eq "true" \
        ) ? true : false]
    }
    return $results

}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        validate_coupon [lindex $case 0]
    } [lindex $case 1]
}

exit 0


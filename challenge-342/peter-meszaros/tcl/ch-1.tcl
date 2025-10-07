#!/usr/bin/env tclsh
#
# Task 1: Balance String
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a string made up of lowercase English letters and digits only.
# 
# Write a script to format the give string where no letter is followed by another
# letter and no digit is followed by another digit. If there are multiple valid
# rearrangements, always return the lexicographically smallest one. Return empty
# string if it is impossible to format the string.
# 
# Example 1
# 
#     Input: $str = "a0b1c2"
#     Output: "0a1b2c"
# 
# Example 2
# 
#     Input: $str = "abc12"
#     Output: "a1b2c"
# 
# Example 3
# 
#     Input: $str = "0a2b1c3"
#     Output: "0a1b2c3"
# 
# Example 4
# 
#     Input: $str = "1a23"
#     Output: ""
# 
# Example 5
# 
#     Input: $str = "ab123"
#     Output: "1a2b3"
# 

package require tcltest

set cases {
    {"a0b1c2"  "0a1b2c"  "Example 1"}
    {"abc12"   "a1b2c"   "Example 2"}
    {"0a2b1c3" "0a1b2c3" "Example 3"}
    {"1a23"    ""        "Example 4"}
    {"ab123"   "1a2b3"   "Example 5"}
}

proc balance_string {str} {

    set chars [split $str ""]
    set digits [lsort [lmap c $chars {
        if {![string is digit $c]} continue
        set c
    }]]
    set letters [lsort [lmap c $chars {
        if {[string is digit $c]} continue
        set c
    }]]
    set len_diff [expr [llength $letters] - [llength $digits]]
    if {abs($len_diff) > 1} {
        return ""
    }


    set letter_comes [expr $len_diff <= 0 ? 0 : 1]
    set result ""
    while {[llength $letters] > 0 || [llength $digits] > 0} {
        if {$letter_comes} {
            if {[llength $letters] > 0} {
                lappend result [lindex $letters 0]
                set letters [lrange $letters 1 end]
            }
        } else {
            if {[llength $digits] > 0} {
                lappend result [lindex $digits 0]
                set digits [lrange $digits 1 end]
            }
        }
        set letter_comes [expr !$letter_comes]
    }
    set result [join $result ""]
    return $result
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        balance_string [lindex $case 0]
    } [lindex $case 1]
}

exit 0



sub balance_string
{
    my $str = shift;

    my @chars = sort split //, $str;
    my @digits = sort grep { /\d/ } @chars;
    my @letters = sort grep { /\D/ } @chars;
    my $len_diff = @letters - @digits;
    return "" if abs($len_diff) > 1;

    my $letter_comes = $len_diff <= 0 ? 0 : 1;
    my $result = "";
    while (@letters || @digits) {
        if ($letter_comes) {
            $result .= shift @letters if @letters;
        } else {
            $result .= shift @digits if @digits;
        }
        $letter_comes = !$letter_comes;
    }
    return $result;
}

for (@$cases) {
    is(balance_string($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;


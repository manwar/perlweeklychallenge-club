#!/usr/bin/env tclsh
#
# Task 2: Smaller Greater Element
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given an array of integers.  Write a script to find the number of
# elements that have both a strictly smaller and greater element in the given
# array.
# 
# Example 1
# 
#     Input: @int = (2,4)
#     Output: 0
# 
#     Not enough elements in the array.
# 
# Example 2
# 
#     Input: @int = (1, 1, 1, 1)
#     Output: 0
# 
# Example 3
# 
#     Input: @int = (1, 1, 4, 8, 12, 12)
#     Output: 2
# 
#     The elements are 4 and 8.
# 
# Example 4
# 
#     Input: @int = (3, 6, 6, 9)
#     Output: 2
# 
#     Both instances of 6.
# 
# Example 5
# 
#     Input: @int = (0, -5, 10, -2, 4)
#     Output: 3
# 
#     The elements are 0, -2, and 4.
# 

package require Tcl 8.6
package require tcltest

set cases {
    {{24}            0 "Example 1"}
    {{1 1 1 1}       0 "Example 2"}
    {{1 1 4 8 12 12} 2 "Example 3"}
    {{3 6 6 9}       2 "Example 4"}
    {{0 -5 10 -2 4}  3 "Example 5"}
}

proc smaller_greater_element {int} {
    set min [lindex [lsort -integer $int] 0]
    set max [lindex [lsort -integer -decreasing $int] 0]

    set count 0
    foreach i $int {
        if {$i > $min && $i < $max} {
            incr count
        }
    }
    return $count

}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        smaller_greater_element [lindex $case 0]
    } [lindex $case 1]
}

exit 0


sub smaller_greater_element
{
    my $int = shift;

    my $min = min(@$int);
    my $max = max(@$int);

    my $count = 0;
    for my $i (@$int) {
        $count++ if $i > $min && $i < $max;
    }
    return $count;
}

for my $case (@cases) {
    my $got = smaller_greater_element($case->{int});
    is($got, $case->{out}, $case->{name});
}
done_testing();

exit 0;


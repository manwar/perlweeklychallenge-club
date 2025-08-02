#!/usr/bin/env tclsh
#
# Task 1: Similar Dominos
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a list of dominos, @dominos.
# 
# Write a script to return the number of dominoes that are similar to any other
# domino.
# 
#     $dominos[i] = [a, b] and $dominos[j] = [c, d] are same if either (a = c and
#     b = d) or (a = d and b = c).
# 
# Example 1
# 
#     Input: @dominos = ([1, 3], [3, 1], [2, 4], [6, 8])
#     Output: 2
# 
#     Similar Dominos: $dominos[0], $dominos[1]
# 
# Example 2
# 
#     Input: @dominos = ([1, 2], [2, 1], [1, 1], [1, 2], [2, 2])
#     Output: 3
# 
#     Similar Dominos: $dominos[0], $dominos[1], $dominos[3]
# 

package require tcltest

set cases {
    {{{1 3} {3 1} {2 4} {6 8}}       2 "Example 1"}
    {{{1 2} {2 1} {1 1} {1 2} {2 2}} 3 "Example 2"}
}

proc similar_dominos {d} {

    set dlen [llength $d]
    set dlist {}
    for {set i1 0} {$i1 < $dlen} {incr i1} {
        for {set i2 [expr $i1 + 1]} {$i2 < $dlen} {incr i2} {
            if {[lindex [lindex $d $i1] 0] == [lindex [lindex $d $i2] 1] &&
                [lindex [lindex $d $i1] 1] == [lindex [lindex $d $i2] 0]
                ||
                [lindex [lindex $d $i1] 0] == [lindex [lindex $d $i2] 0] &&
                [lindex [lindex $d $i1] 1] == [lindex [lindex $d $i2] 1]} {
                lappend dlist $i1 $i2
            }
        }
    }
    return [llength [lsort -integer -unique $dlist]]
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
       similar_dominos [lindex $case 0]
    } [lindex $case 1]
}

exit 0




sub similar_dominos
{
    my $d = shift;

    my @d;
    for my $i1 (0 .. $#$d) {
        for my $i2 ($i1+1 .. $#$d) {
            push(@d, $i1, $i2) if $d->[$i1]->[0] == $d->[$i2]->[1] &&
                                  $d->[$i1]->[1] == $d->[$i2]->[0]
                                  ||
                                  $d->[$i1]->[0] == $d->[$i2]->[0] &&
                                  $d->[$i1]->[1] == $d->[$i2]->[1];
        }
    }
    return scalar uniqint @d;
}


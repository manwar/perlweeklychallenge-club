#!/usr/bin/env tclsh
#
# Task 2: Magic Expression
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a string containing only digits and a target integer.
# 
# Write a script to insert binary operators +, - and * between the digits in the
# given string that evaluates to target integer.
# 
# Example 1
# 
#     Input: $str = "123", $target = 6
#     Output: ("1*2*3", "1+2+3")
# 
# Example 2
# 
#     Input: $str = "105", $target = 5
#     Output: ("1*0+5", "10-5")
# 
# Example 3
# 
#     Input: $str = "232", $target = 8
#     Output: ("2*3+2", "2+3*2")
# 
# Example 4
# 
#     Input: $str = "1234", $target = 10
#     Output: ("1*2*3+4", "1+2+3+4")
# 
# Example 5
# 
#     Input: $str = "1001", $target = 2
#     Output: ("1+0*0+1", "1+0+0+1", "1+0-0+1", "1-0*0+1", "1-0+0+1", "1-0-0+1")
# 

package require Tcl 8.6
package require tcltest

set cases {
    {{"123"   6} {1*2*3 1+2+3}     "Example 1"}
    {{"105"   5} {1*0+5 10-5}      "Example 2"}
    {{"232"   8} {2*3+2 2+3*2}     "Example 3"}
    {{"1234" 10} {1*2*3+4 1+2+3+4} "Example 4"}
    {{"1001"  2} {1-0*0+1 1-0-0+1 1-0+0+1\
        1+0*0+1 1+0-0+1 1+0+0+1}   "Example 5"}
}

# Utility function to make procedures that define generators
# Copied from https://rosettacode.org/wiki/Permutations_with_repetitions#Version_without_additional_libraries
proc generator {name arguments body} {
    set body [list try $body on ok {} {return -code break}]
    set lambda [list $arguments "yield \[info coroutine\];$body"]
    proc $name args "tailcall \
        coroutine gen_\[incr ::generate_ctr\] apply [list $lambda] {*}\$args"
}

# How to generate permutations with repetitions
generator permutationsWithRepetitions {input n} {
    if {[llength $input] == 0 || $n < 1} {error "bad arguments"}
    if {![incr n -1]} {
        foreach el $input {
            yield [list $el]
        }
    } else {
        foreach el $input {
            set g [permutationsWithRepetitions $input $n]
            while 1 {
                yield [list $el {*}[$g]]
            }
        }
    }
}

proc magic_expression {p} {
    set str    [lindex $p 0]
    set target [lindex $p 1]

    set oper { * - + "" }
    set str_list [split $str {}]
    set result {}
    set len [expr [string length $str] - 1]

    set g [permutationsWithRepetitions $oper $len]
    while 1 {
        set o [$g]
        set expression ""
        for {set i 0} {$i < $len} {incr i} {
            append expression [lindex $str_list $i] [lindex $o $i]
        }
        append expression [lindex $str_list end]
        if {[regexp {0\d} $expression]} {
            continue
        }
        set res [expr $expression]
        #puts "expression: $expression -> $res"
        if {$res == $target} {
            lappend result $expression
        }
    }
    return $result
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        magic_expression [lindex $case 0]
    } [lindex $case 1]
}

exit 0



sub magic_expression
{
    my $str    = $_[0]->[0];
    my $target = $_[0]->[1];

    my @oper = ('*', '-', '+', '');
    my @str = split //, $str;
    my $result;
    my $iter = variations_with_repetition(\@oper, length($str) - 1);
    while (my $c = $iter->next) {
        my $expr;
        for (my $i = 0; $i < length($str) - 1; $i++) {
            $expr .= $str[$i] . $c->[$i];
        }
        $expr .= $str[-1];
        my $eval = eval $expr;
        next if $expr =~ /0\d/;
        if (defined $eval && $eval == $target) {
            push @$result, $expr;
        }
    }
    return $result;
}

for (@$cases) {
    is(magic_expression($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;

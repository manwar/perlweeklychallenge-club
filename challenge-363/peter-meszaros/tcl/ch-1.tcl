#!/usr/bin/env tclsh
#
# Task 1: String Lie Detector
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a string.  Write a script that parses a self-referential string
# and determines whether its claims about itself are true. The string will make
# statements about its own composition, specifically the number of vowels and
# consonants it contains.
# 
# Example 1
# 
#     Input: $str = "aa - two vowels and zero consonants"
#     Output: true
# 
# Example 2
# 
#     Input: $str = "iv - one vowel and one consonant"
#     Output: true
# 
# Example 3
# 
#     Input: $str = "hello - three vowels and two consonants"
#     Output: false
# 
# Example 4
# 
#     Input: $str = "aeiou - five vowels and zero consonants"
#     Output: true
# 
# Example 5
# 
#     Input: $str = "aei - three vowels and zero consonants"
#     Output: true
# 

package require Tcl 8.6
package require tcltest

set cases {
    {"aa - two vowels and zero consonants"      true "Example 1"}
    {"iv - one vowel and one consonant"         true "Example 2"}
    {"hello - three vowels and two consonants" false "Example 3"}
    {"aeiou - five vowels and zero consonants"  true "Example 4"}
    {"aei - three vowels and zero consonants"   true "Example 5"}
}

proc string_lie_detector {str} {
    set s [string trim [lindex [split $str -] 0]]
    set claims [string trim [lindex [split $str -] 1]]

    if {[regexp {(\w+) vowels? and (\w+) consonants?} $claims -> v c]} {
        set numbers {zero 0 one 1 two 2 three 3 four 4 five 5 six 6 seven 7 eight 8 nine 9}
        if {![dict exists $numbers $v] || ![dict exists $numbers $c]} {
            return false
        }
        set v_num [dict get $numbers $v]
        set c_num [dict get $numbers $c]
        set vowels 0
        set consonants 0
        foreach char [split $s ""] {
            if {[regexp {[aeiouAEIOU]} $char]} {
                incr vowels
            } elseif {[regexp {[a-zA-Z]} $char]} {
                incr consonants
            }
        }
        if {$vowels == $v_num && $consonants == $c_num} {
            return true
        } else {
            return false
        }
    }
    return false
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        string_lie_detector [lindex $case 0]
    } [lindex $case 1]
}

exit 0




sub string_lie_detector
{
    my $str = shift;
    my ($s, $v, $c) = $str =~ /^(.*) - (\w+) vowels? and (\w+) consonants?$/;
    return undef unless defined $s && defined $v && defined $c;

    my %numbers = (zero  => 0,
                   one   => 1,
                   two   => 2,
                   three => 3,
                   four  => 4,
                   five  => 5,
                   six   => 6,
                   seven => 7,
                   eight => 8,
                   nine  => 9,
               );
                   
    return undef unless exists $numbers{$v} && exists $numbers{$c};

    my ($vowels, $consonants) = (0, 0);
    for (split //, $s) {
        if (/[aeiou]/i) {
            $vowels++;
        } elsif (/[a-z]/i) {
            $consonants++;
        }
    }

    return $vowels == $numbers{$v} && $consonants == $numbers{$c};
}

for (@$cases) {
    is(string_lie_detector($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;

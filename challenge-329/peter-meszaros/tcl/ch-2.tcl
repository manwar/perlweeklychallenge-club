#!/usr/bin/env tclsh
#
# Task 2: Nice String
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a string made up of lower and upper case English letters only.
# 
# Write a script to return the longest substring of the give string which is
# nice. A string is nice if, for every letter of the alphabet that the string
# contains, it appears both in uppercase and lowercase.
# 
# Example 1
# 
#     Input: $str = "YaaAho"
#     Output: "aaA"
# 
# Example 2
# 
#     Input: $str = "cC"
#     Output: "cC"
# 
# Example 3
# 
#     Input: $str = "A"
#     Output: ""
# 
#     No nice string found.
# 

package require tcltest

set cases {
    {"YaaAho" "aaA" "Example 1"}
    {"cC"     "cC"  "Example 2"}
    {"A"      ""    "Example 3"}
}

proc nice_string {str} {
    set max_len 0
    set max_substr ""

    set len [string length $str]
    for {set i 0} {$i < $len} {incr i} {
        for {set j [expr $i + 1]} {$j <= $len} {incr j} {
            set substr [string range $str $i [expr $j - 1]]
            set is_nice 1
            array unset seen

            foreach char [split $substr ""] {
                if {[regexp {^[a-zA-Z]$} $char]} {
                    set lower_char [string tolower $char]
                    if {[info exists seen($lower_char)]} {
                        incr seen($lower_char)
                    } else {
                        set seen($lower_char) 1
                    }
                }
            }

            foreach key [array names seen] {
                if {$seen($key) < 2} {
                    set is_nice 0
                    break
                }
            }

            if {$is_nice && [string length $substr] > $max_len} {
                set max_len [string length $substr]
                set max_substr $substr
            }
        }
    }

    return $max_substr
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        nice_string [lindex $case 0]
    } [lindex $case 1]
}

exit 0


sub nice_string
{
    my $str = shift;

    my $max_len = 0;
    my $max_substr = '';
    my $len = length($str);
    for my $i (0 .. $len - 1) {
        for my $j ($i + 1 .. $len) {
            my $substr = substr($str, $i, $j - $i);
            my %seen;
            my $is_nice = 1;

            for my $char (split //, $substr) {
                if ($char =~ /[a-z]/) {
                    $seen{lc($char)}++;
                } elsif ($char =~ /[A-Z]/) {
                    $seen{lc($char)}++;
                }
            }

            for my $key (keys %seen) {
                if ($seen{$key} < 2) {
                    $is_nice = 0;
                    last;
                }
            }

            if ($is_nice && length($substr) > $max_len) {
                $max_len = length($substr);
                $max_substr = $substr;
            }
        }
    }
    return $max_substr;
}

for (@$cases) {
    is(nice_string($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;

#!/usr/bin/env perl

# Challenge 116
#
# TASK #1 - Number Sequence
# Submitted by: Mohammad S Anwar
# You are given a number $N >= 10.
#
# Write a script to split the given number such that the difference between two
# consecutive numbers is always 1 and it shouldn't have leading 0.
#
# Print the given number if it impossible to split the number.
#
# Example
# Input: $N = 1234
# Output: 1,2,3,4
#
# Input: $N = 91011
# Output: 9,10,11
#
# Input: $N = 10203
# Output: 10203 as it is impossible to split satisfying the conditions.

use Modern::Perl;

my $N = shift;

print_sequences($N);

sub print_sequences {
    my($rest, @prev) = @_;
    my $found_solution = 0;

    if ($rest eq '') {
        if (!$found_solution) {
            say join(",", @prev);
            $found_solution = 1;
        }
    }
    else {
        for (1 .. length($rest)) {
            my $pref = substr($rest,0,$_);
            my $suff = substr($rest,$_);
            next if $suff =~ /^0/;
            if (@prev) {
                if ($prev[-1] + 1 == $pref) {
                    $found_solution ||= print_sequences($suff, @prev, $pref);
                }
            }
            else {
                $found_solution ||= print_sequences($suff, @prev, $pref);
            }
        }
    }
    return $found_solution;
}

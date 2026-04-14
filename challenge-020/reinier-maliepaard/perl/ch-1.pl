#!/usr/bin/perl
use strict;
use warnings;

my $str = "ABBCDDDF";

my @char = split //, $str;

my ($cur_char, $prev_char, $result);

for (my $i = 1; $i < @char; $i++) {

    $cur_char = $char[$i];
    $prev_char = $char[$i-1];

    ($cur_char ne $prev_char) ? ($result .= $prev_char . ", ")
                              : ($result .= $prev_char);

    # add last character at the end of the loop
    $result .= $cur_char if ($i == @char-1);
}

print "$result\n"; # Output: A, BB, C, DDD, F


#######################################################################
# alternative with regex
# /(([A-Z])\2*)/g
# Finds consecutive runs of the same uppercase letter.
#
# ([A-Z])      -> captures one letter (this is \2)
# \2*          -> repeats that same letter (e.g. BB, DDD)
# ((...))      -> outer capture = full run (e.g. "BB", "DDD")
# /g           -> repeats across the whole string
#
# $1 is the FULL match of the outer parentheses
#     e.g. "A", "BB", "DDD", "F"
#
# $2 is the single character inside the run
#     e.g. "A", "B", "D", "F"
#######################################################################


# my @runs;

# while ($str =~ /(([A-Z])\2*)/g) {
#     push @runs, $1;
# }

# print join(", ", @runs), "\n"; # Output: A, BB, C, DDD, F

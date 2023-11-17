#!/usr/bin/env perl

# Challenge 240
#
# Task 1: Acronym
# Submitted by: Mohammad S Anwar
#
# You are given an array of strings and a check string.
#
# Write a script to find out if the check string is the acronym of the words in
# the given array.
# Example 1
#
# Input: @str = ("Perl", "Python", "Pascal")
#        $chk = "ppp"
# Output: true
#
# Example 2
#
# Input: @str = ("Perl", "Raku")
#        $chk = "rp"
# Output: false
#
# Example 3
#
# Input: @str = ("Oracle", "Awk", "C")
#        $chk = "oac"
# Output: true

use Modern::Perl;

# parse args
sub usage { return "Usage: $0 -str s1 s2 s3 ... -chk check\n"; }

my(@strs, $check);
while (@ARGV) {
    if ($ARGV[0] eq "-str") {
        shift;
        while (@ARGV && $ARGV[0] !~ /^-/) {
            push @strs, shift;
        }
    }
    elsif ($ARGV[0] eq "-chk") {
        shift;
        $check = shift;
    }
    else {
        die usage();
    }
}
if (!@strs || !$check) { die usage(); }

# compute
my $inits = join '', map { substr($_,0,1) } @strs;

# output
if (lc($inits) eq lc($check)) {
    say "true";
}
else {
    say "false";
}

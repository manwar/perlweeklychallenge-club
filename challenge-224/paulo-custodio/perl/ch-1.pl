#!/usr/bin/env perl

# Challenge 224
#
# Task 1: Special Notes
# Submitted by: Mohammad S Anwar
# You are given two strings, $source and $target.
#
# Write a script to find out if using the characters (only once) from source,
# a target string can be created.
#
# Example 1
# Input: $source = "abc"
#        $target = "xyz"
# Output: false
# Example 2
# Input: $source = "scriptinglanguage"
#        $target = "perl"
# Output: true
# Example 3
# Input: $source = "aabbcc"
#        $target = "abc"
# Output: true

use Modern::Perl;

@ARGV==2 or die "Usage: $0 source target\n";
my($source, $target) = @ARGV;

say can_make_string($target, $source) ? "true" : "false";

sub can_make_string {
    my($str, $chars) = @_;
    for my $ch (split //, $chars) {
        $str =~ s/$ch//i;
    }
    return $str eq '';
}

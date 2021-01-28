#!/usr/bin/perl

# Challenge 018
#
# Task #1
# Write a script that takes 2 or more strings as command line parameters and
# print the longest common substring. For example, the longest common substring
# of the strings “ABABC”, “BABCA” and “ABCBA” is string “ABC” of length 3.
# Other common substrings are “A”, “AB”, “B”, “BA”, “BC” and “C”. Please check
# this wiki page for details.

use strict;
use warnings;
use 5.030;

say "(", join(", ", map {$_=qq("$_")} longest_substr(@ARGV)), ")";


sub longest_substr {
    my(@strs) = @_;
    my $longest_len = -1;
    my %longest;

    for my $str (@strs) {                                   # each string
        for my $s (0 .. length($str)-1) {                   # each starting point
            for my $len (reverse 1 .. length($str)-$s) {    # each substring of str
                next if $longest_len > $len;                # prune search
                my $substr = substr($str, $s, $len);
                next if $longest{$str};                     # prune search
                if (all(sub {/$substr/}, @strs)) {          # matches all
                    if ($longest_len == $len) {
                        $longest{$substr}=1;
                    }
                    else { # $longest_len < $len
                        %longest = ($substr=>1);
                        $longest_len = $len;
                    }
                }
            }
        }
    }
    return sort keys %longest;
}

sub all {
    my($sub, @a) = @_;
    for (@a) { return if !$sub->($_); }
    return 1;
}

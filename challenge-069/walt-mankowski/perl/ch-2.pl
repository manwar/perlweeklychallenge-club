#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.32);
use experimental qw(signatures);

# TASK #2 › 0/1 String
# Submitted by: Mohammad S Anwar
# 
# A 0/1 string is a string in which every character is either 0 or 1.
# 
# Write a script to perform switch and reverse to generate S1000 as described below:
# 
# switch:
# 
# Every 0 becomes 1 and every 1 becomes 0. For example, “101” becomes “010”.
# 
# reverse:
# 
# The string is reversed. For example, "001” becomes “100”.
# 
# To generate S1000 string, please follow the rule as below:
# 
# S0 = “”
# S1 = “0”
# S2 = “001”
# S3 = “0010011”
# …
# SN = SN-1 + “0” + switch(reverse(SN-1))

my $n = $ARGV[0];
say S($n);

sub S($n) {
    my $S = '';
    for my $i (1..$n) {
        $S .= '0' . switch(rev($S));
    }
    return $S;
}

sub switch($s) {
    $s =~ tr/01/10/;
    return $s;
}

sub rev($s) {
    return scalar reverse $s;
}

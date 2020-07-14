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
# printf "S(%d) = %s\n", $n, S($n);
say S($n);


sub S($n) {
    if ($n == 0) {
        return "";
    } else {
        my $sn1 = S($n-1);
        return $sn1 . "0" . switch(rev($sn1));
    }
}

sub switch($s) {
    state @swap = (1, 0);

    return join '', map { $swap[$_] } split //, $s;
}

sub rev($s) {
    return join '', reverse split //, $s;
}

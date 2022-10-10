#!/usr/bin/env perl
# Perl weekly challenge 185
# Task 1:  MAC Address
#
# See https://wlmb.github.io/2022/10/03/PWC185/#task-1-mac-address
use v5.36;
use List::Util qw(all pairs);
use experimental "try";
die "Usage: $0 S1 [S2...]\nto convert strings Sn from hhhh.hhhh.hhhh to hh:hh:hh:hh:hh:hh"
unless @ARGV;
for (@ARGV) {
    try {
        my @quads=split /\./;
        die "Expected 3 parts" unless @quads==3;
        die "Expected 4-hex-digit parts" unless all {m/[0-9a-f]{4}/} @quads;
        say "$_ -> ", join ":", map {join "", @$_} pairs map {split ""} @quads;
    }
    catch ($m) {
        say "Failed for $_: $m";
    }
}

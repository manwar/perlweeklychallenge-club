#!/usr/bin/env perl
# Perl weekly challenge 254
# Task 1:  Three Power
#
# See https://wlmb.github.io/2024/01/29/PWC254/#task-1-three-power
use v5.36;
use POSIX qw(lround);
die <<~"FIN" unless @ARGV;
    Usage: $0 N1 [N2...]
    to check if the integers N1 N2... are cubes
    FIN
for(@ARGV){
    warn("$_ not integer"),next unless $_ == lround($_);
    say "$_ -> ", abs($_)==lround(abs($_)**(1/3))**3?"True":"False";
}

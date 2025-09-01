#!/usr/bin/env perl
# Perl weekly challenge 337
# Task 1:  Smaller Than Current
#
# See https://wlmb.github.io/2025/08/31/PWC337/#task-1-smaller-than-current
use v5.36;
use PDL;
use PDL::NiceSlice;
die <<~"FIN" unless @ARGV;
    Usage: $0 A1 A2...
    to find for each number Ni in the array Ak how many numbers Nj
    are less than Ni.
    The arrays are input as strings of the form
    "[N0 N1 ...]" where the Ni's are numbers
    FIN
for(@ARGV){
    my $array=pdl($_);
    say "$_ -> ",($array(*1)>$array)->sumover; # compare array as cols vs. as rows
}

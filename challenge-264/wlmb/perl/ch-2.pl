#!/usr/bin/env perl
# Perl weekly challenge 264
# Task 2:  Target Array
#
# See https://wlmb.github.io/2024/04/12/PWC264/#task-2-target-array
use v5.36;
use experimental qw(for_list);
LOOP: for my ($source, $indices)(@ARGV){
    my @source=split " ", $source;
    my @indices=split " ", $indices;
    my @output;
    for(0..@indices-1){
	warn("Index out of range"), next LOOP unless 0 <= $_ < @source;
	splice @output, $indices[$_],0,$source[$_];
    }
    say "source=(@source), indices=(@indices) -> (@output)";
}

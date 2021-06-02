#!/usr/bin/env perl
# Perl weekly challenge 115
# Task 2: Largest Multiple
#
# See https://wlmb.github.io/2021/06/01/PWC115/#task-2-largest-multiple
use strict;
use warnings;
use v5.12;
use List::MoreUtils qw(first_index);
foreach(@ARGV){
    die "Usage: ./ch-2.pl digits1 [digits2...]"
         unless m/^\d+$/;
    say "Input: $_";
    my @digits=sort {$a<=>$b} split '', $_;
    my $even_index=first_index {$_%2==0} @digits;
    say("No even number may be constructed from input"), next
         unless $even_index>=0;
    my $last=splice @digits, $even_index,1;
    say "Output: ", reverse(@digits), $last;
}

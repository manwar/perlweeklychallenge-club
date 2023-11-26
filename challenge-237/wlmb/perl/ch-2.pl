#!/usr/bin/env perl
# Perl weekly challenge 237
# Task 2:  Maximise Greatness
#
# See https://wlmb.github.io/2023/10/01/PWC237/#task-2-maximise-greatness
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 N1 [N2...]
    to find the greatness of the array N1 N2...
    FIN
my @copy=my @sorted=sort {$a<=>$b} @ARGV;
my $current=shift @sorted;
my @permutation;
while(@copy){
    my $next=shift @copy;
    push(@permutation, $next), $current=shift @sorted if $current<$next
}
say "@ARGV -> ", 0+@permutation;

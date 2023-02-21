#!/usr/bin/env perl
# Perl weekly challenge 204
# Task 1:  Monotonic Array
#
# See https://wlmb.github.io/2023/02/13/PWC204/#task-1-monotonic-array
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 N1 [N2...]
    to test if the sequence N1 N2... is monotonic
    FIN
my @orig=@ARGV;
my $current=shift;
my ($increasing, $decreasing);
for(@ARGV){
    $_>$current and $increasing=1;
    $_<$current and $decreasing=1;
    last if $increasing and $decreasing; # shortcut if non monotonic
    $current=$_;
}
my ($result, $reason)=
    $increasing && $decreasing?(0, "Non-monotonic"):
    $increasing               ?(1, "Non-decreasing"):
    $decreasing               ?(1, "Non-increasing"):
    (1, "Constant");
say join " ", @orig, "->", $result, $reason;

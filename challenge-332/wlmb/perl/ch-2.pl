#!/usr/bin/env perl
# Perl weekly challenge 332
# Task 2:  Odd Letters
#
# See https://wlmb.github.io/2025/07/26/PWC332/#task-2-odd-letters
use v5.36;
use List::Util qw(all);
die <<~"FIN" unless @ARGV;
    Usage: $0 W1 W2...
    to check if all letters in word Wn appear an odd number of times
    FIN
for(@ARGV){
    my %count;
    $count{$_}++ for split "";
    say "$_ -> ", (all{$_%2} values %count)?"True":"False"
}

#!/usr/bin/env perl
# Perl weekly challenge 255
# Task 1:  Odd Character
#
# See https://wlmb.github.io/2024/02/05/PWC255/#task-1-odd-character
use v5.36;
use experimental qw(for_list);
die <<~"FIN" unless @ARGV && @ARGV%2==0;
    Usage: $0 S0 T0 [S1 T1...]
    to find the odd characters in the string pairs Sn Tn
    FIN
for my ($s,$t)(@ARGV){
    warn "Length should differ by one" unless length $t == 1+length $s;
    my %count;
    ++$count{$_} for split "", fc $s;
    --$count{$_}||delete $count{$_} for split "", fc $t;
    warn "More than one odd character" unless (keys %count)==1;
    say "$t, $s -> ", keys %count;
}

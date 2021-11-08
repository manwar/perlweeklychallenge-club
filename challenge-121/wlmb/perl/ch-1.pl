#!/usr/bin/env perl
# Perl weekly challenge 121
# Task 1: Invert bit
#
# See https://wlmb.github.io/2021/07/12/PWC121/#task-1-invert-bit
use strict;
use warnings;
use v5.12;
use List::Util qw(pairs);
use POSIX qw(round);
foreach(pairs @ARGV){
    my ($n,$b)=map {round $_} @$_; # Assure integer
    say("Wrong range: 0<=$n<=255 && 1<=$b<=8?"), next
        unless 0<=$n<=255 && 1<=$b<=8; # ??
    my $r=(1<<($b-1))^$n; # Count bits from 1, not 0
    say "Number: $n, Bit: $b, Output: $r";
}

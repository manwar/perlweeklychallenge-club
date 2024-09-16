#!/usr/bin/env perl
# Perl weekly challenge 287
# Task 1:  Strong Password
#
# See https://wlmb.github.io/2024/09/16/PWC287/#task-1-strong-password
use v5.36;
use List::Util qw(max);
die <<~"FIN" unless @ARGV;
    Usage: $0 P1 P2...
    to find the minimum number of steps required to convert
    the passwords Pi into strong passwords
    FIN
for(@ARGV){
    my $single_triad=/^(.)\1\1$/;
    my $missing_classes=(!/[a-z]/)+(!/[A-Z]/)+(!/[0-9]/);
    my $triads=0;
    ++$triads while /(.)\1\1/g;
    my $missing_classes=max($missing_classes-$triads, 0);
    my $missing_chars=max(6-(length)-$missing_classes, 0);
    my $steps=$single_triad?3:$triads+$missing_chars+$missing_classes;
    say "$_ -> $steps";
}

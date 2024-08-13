#!/usr/bin/env perl
# Perl weekly challenge 282
# Task 1:  Good Integer
#
# See https://wlmb.github.io/2024/08/11/PWC282/#task-1-good-integer
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 N1 N2...
    to find good integers within the numbers N1 N2...
    FIN
ARG: for(@ARGV){
    my $arg=$_;
    warn "Expected only digits: $_" unless /^\d+$/;
    while(s/.*?((.)\2\2(\2*))//){
        say("$arg -> $1"), next ARG if $3 eq "";
    }
    say "$arg -> -1"
}

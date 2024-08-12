#!/usr/bin/env perl
# Perl weekly challenge 282
# Task 2:  Changing Keys
#
# See https://wlmb.github.io/2024/08/11/PWC282/#task-2-changing-keys
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 S1 S2...
    to count how many key changes are required for each character in strings S1 S2...
    FIN
for(@ARGV){
    warn("Expected alphabetical string: $_"), next unless /^[a-zA-Z]+$/;
    my $arg=$_;
    $_=lc;
    s/(.)\1+/$1/g;
    say "$arg -> ", length($_)-1
}

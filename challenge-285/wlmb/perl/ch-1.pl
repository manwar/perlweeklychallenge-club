#!/usr/bin/env perl
# Perl weekly challenge 285
# Task 1:  No Connection
#
# See https://wlmb.github.io/2024/09/02/PWC285/#task-1-no-connection
use v5.36;
use experimental qw(for_list);
die <<~"FIN" unless @ARGV and @ARGV%2==0;
    Usage: $0 I1 O1 I2 O2...
    where Ii is the incoming and Oi the outgoing node
    of the i-th edge.
    FIN
my (%in, %out);
for my($in,$out)(@ARGV){
    ++$in{$in} if $in ne $out;
    ++$out{$out};
}
say "@ARGV -> ", join " ", grep{!$in{$_}}keys %out;

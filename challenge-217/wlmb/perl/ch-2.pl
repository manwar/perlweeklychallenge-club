#!/usr/bin/env perl
# Perl weekly challenge 217
# Task 2:  Max Number
#
# See https://wlmb.github.io/2023/05/15/PWC217/#task-2-max-number
use v5.36;
use List::Util qw(all);
die <<~"FIN" unless @ARGV;
    Usage: $0 N1 [N2...]
    to build the highest possible number by rearranging and concatenating
    the numbers N1 N2...
    FIN
die "Expected nonnegative integers" unless all {/^\d+$/} @ARGV;
say "@ARGV -> ", join "", sort {"$b$a" <=> "$a$b"} @ARGV;

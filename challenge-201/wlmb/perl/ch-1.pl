#!/usr/bin/env perl
# Perl weekly challenge 201
# Task 1:  Missing Numbers
#
# See https://wlmb.github.io/2023/01/23/PWC201/#task-1-missing-numbers
use v5.36;
my %seen;
die <<~ "FIN" unless @ARGV;
    Usage: $0 N1 [N2...]
    to find the missing numbers from the sequence N1 N2...
    FIN
@seen{@ARGV}=(1)x@ARGV;
die "Expected unique values" unless 0+@ARGV==0+keys %seen;
say join " ", @ARGV, "->", grep {!$seen{$_}} 0..@ARGV;

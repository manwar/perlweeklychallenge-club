#!/usr/bin/env perl
# Perl weekly challenge 246
# Task 1:  6 out of 49
#
# See https://wlmb.github.io/2023/12/03/PWC246/#task-1-6-out-of-49
use v5.36;
my %n=map{$_=>1} 1..49;
my @n=keys %n;
say join " ", @n[0..5];

#!/usr/bin/env perl
# Perl weekly challenge 283
# Task 1:  Lucky Integer
#
# See https://wlmb.github.io/2024/08/26/PWC283/#task-1-lucky-integer
use v5.36;
use List::Util qw(max);
die <<~"FIN" unless @ARGV;
    Usage: $0 N1 N2...
    to find the largest lucky number among N1 N2...
    FIN
my %frequency_of;
$frequency_of{$_}++ for @ARGV;
say "@ARGV -> ", (max grep {$_==$frequency_of{$_}} keys %frequency_of)//-1;

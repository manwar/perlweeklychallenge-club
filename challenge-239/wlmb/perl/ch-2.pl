#!/usr/bin/env perl
# Perl weekly challenge 239
# Task 2:  Consistent Strings
#
# See https://wlmb.github.io/2023/10/15/PWC239/#task-2-consistent-strings
use v5.36;
use List::Util qw(all);
die <<~"FIN" unless @ARGV;
    Usage: $0 A S1 [S2...]
    Count how many of the strings Sn are consistent with the allowed characters in string A.
    FIN
my $allowed=shift;
my %allowed;
map {$allowed{$_}++} split "", $allowed;
my @output = grep{all {$allowed{$_}} split ""} @ARGV;
say "Allowed: $allowed. Strings: @ARGV -> ",0+@output;

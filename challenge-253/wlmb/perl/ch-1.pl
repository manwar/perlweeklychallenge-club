#!/usr/bin/env perl
# Perl weekly challenge 253
# Task 1:  Split Strings
#
# See https://wlmb.github.io/2024/01/22/PWC253/#task-1-split-strings
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 S W1 [W2...]
    to separate words W1 W2... at separator character S.
    FIN
my $separator = shift;
die "Only single characterr allowed as separator: $separator" unless $separator=~/^.$/;
my @results;
push @results, grep {/./} split /[$separator]/ for (@ARGV);
say "Separator: $separator, input: @ARGV => output: @results";

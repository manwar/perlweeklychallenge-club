#!/usr/bin/env perl
# Perl weekly challenge 182
# Task 1:  Max Index
#
# See https://wlmb.github.io/2022/09/12/PWC182/#task-1-max-index
use v5.36;
use List::Util qw(max);
use List::MoreUtils qw(firstidx);
die "Usage: $0 N0 [N1...]\nto get index of maximum among N0, N1..."
    unless @ARGV;
my $max=max(@ARGV);
my $index=firstidx {$_==$max} @ARGV;
say "The index of the biggest number in (", join(", ", @ARGV), ") is $index";

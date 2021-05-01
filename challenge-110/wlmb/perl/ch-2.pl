#!/usr/bin/env perl
# Perl weekly challenge 110
# Task 2: Transpose file
#
# Simple version
# See https://wlmb.github.io/2021/04/27/PWC110/#task-2-transpose-file
use strict;
use warnings;
use v5.12;
my @input=map {chomp; [split /,/]} <>;
say join "\n", map { my $c=$_; join ",", map {$input[$_][$c]} 0..@input-1} 0..scalar @{$input[0]}-1;

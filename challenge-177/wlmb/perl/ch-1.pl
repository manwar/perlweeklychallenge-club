#!/usr/bin/env perl
# Perl weekly challenge 177
# Task 1: Damm algorithm
#
# See https://wlmb.github.io/2022/08/08/PWC177/#task-1-damm-algorithm
use v5.36;
use List::Util qw(reduce);
die "Usage: $0 N1 [N2... ]\nTo check N_{i} with Damm's algorithm\n" unless @ARGV;
my @digits= map {split "", $_} # consecutive digits of a Damm table
    qw(0317598642 7092154863 4206871359 1750983426 6123045978
       3674209581 5869720134 8945362017 9438617205 2581436790);
# Organice the digits as a 2D array
my $table=[map {[@digits[10*$_..10*$_+9]]}(0..9)];
# The group operation $n ∗ $m is given by $table->[$n][$m]
say "$_ ", (reduce {$table->[$a][$b]} (0,split "", $_))?"isn't":"is", " correct"  for @ARGV;

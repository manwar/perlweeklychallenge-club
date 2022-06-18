#!/usr/bin/env perl
# Perl weekly challenge 169
# Task 2: Achilles numbers
#
# See https://wlmb.github.io/2022/06/13/PWC169/#task-2-achilles-numbers
use v5.12;
use warnings;
use Math::Utils qw(gcd);
use Math::Prime::Util qw(factor_exp);
use List::Util qw(all);
die "Usage: ./ch-2.pl N\nto generate the first N Achilles numbers" unless @ARGV;
my $N=shift;
my $candidate=1;
my @achilles_numbers;
while(@achilles_numbers<$N){
    my @exponents=map{$_->[1]} factor_exp(++$candidate);
    push @achilles_numbers, $candidate
        if @exponents>1 and (all {$_>1} @exponents) and gcd(@exponents)==1;
}
say "The first $N Achilles numbers are: ", join " ", @achilles_numbers;

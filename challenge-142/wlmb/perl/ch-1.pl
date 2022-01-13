#!/usr/bin/env perl
# Perl weekly challenge 142
# Task 1: divisor last digit
#
# See https://wlmb.github.io/2021/12/09/PWC142/#task-1-divisor-last-digit
use v5.12;
use warnings;

say("Usage: ./ch-1.pl m n\nto count divisors of m ending in n"), exit unless @ARGV==2;
my ($m,$n)=@ARGV;
my $q=sqrt($m);
my @divisors_ending_in_n=grep {$_=~/$n$/}
    my @divisors=sort {$a<=>$b} map {1<$_<$q?($_, $m/$_):$_} grep {$m%$_==0}(1..$q);
say "Input: m=$m n=$n,\nOutput: ", scalar(@divisors_ending_in_n),
    "\nas the divisors of $m are: ", join(" ", @divisors),
    "\nand those ending in $n are: ", join(" ", @divisors_ending_in_n), "\n";

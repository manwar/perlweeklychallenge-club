#!/usr/bin/env perl
# Perl weekly challenge 148
# Task 1: Eban numbers
#
# See https://wlmb.github.io/2022/01/17/PWC148/#task-1-eban-numbers
use v5.12;
use warnings;
use Lingua::EN::Numbers qw(num2en);
# Usage: ./ch-1.pl [upper_bound]"
my $upper_bound=$ARGV[0]//100;
say "The Eban numbers up to $upper_bound are";
for(0..$upper_bound){
    say "$_ ",num2en($_)  unless (my $n=num2en($_))=~/e/
}

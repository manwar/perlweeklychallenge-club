#!/usr/bin/env perl
# Perl weekly challenge 244
# Task 1:  Count Smaller
#
# See https://wlmb.github.io/2023/11/20/PWC244/#task-1-count-smaller
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 N1 [N2...]
    to count how many members of the list N1 N2... are smaller
    than each element
    FIN
my @sorted = sort{$a <=>$b} @ARGV;
my %repetitions;
my %previous;
my $previous;
for(@sorted){
    $repetitions{$_}++;
    $previous{$_} = $previous unless defined $previous && $previous==$_;
    $previous = $_;
}
my %total;
for(@sorted){
    $total{$_}=0 unless defined $previous{$_};
    $total{$_}=$repetitions{$previous{$_}}+$total{$previous{$_}} if defined $previous{$_};
}
say "@ARGV -> @total{@ARGV}"

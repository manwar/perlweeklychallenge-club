#!/usr/bin/env perl
# Perl weekly challenge 172
# Task 2: Five number summary
#
# See https://wlmb.github.io/2022/07/04/PWC172/#task-1-five-number-summary
use v5.36;
say("Usage: ./ch-2.pl N1 N2...Nk\nto find the five-number summary of the sequence N1...Nk"), exit
    unless @ARGV;
say("The sequence should have at least 2 elements"), exit unless @ARGV>=2;
my @data=sort {$a<=>$b} @ARGV;
my ($min, $max)=($data[0], $data[-1]);
my $median=median(@data);
my $q1=median(@data[0..(@data-2)/2]);
my $q3=median(@data[(@data+1)/2..@data-1]);
say join " ", "The five-number summary of ", @ARGV, "is";
say "min=$min, Q1=$q1, median=$median, Q3=$q3, max=$max";

sub median(@d){
    @d%2?$d[(@d-1)/2]:($d[@d/2-1]+$d[@d/2])/2
}

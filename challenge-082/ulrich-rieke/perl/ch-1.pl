#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

my ($M, $N) = @ARGV ;
my %M ;
my %N ;
map { $M{$_}++ if $M % $_ == 0 } (1..$M) ;
map { $N{$_}++ if $N % $_ == 0 } (1..$N) ;
my @common = grep { exists $M{$_} } keys %N ;
my @sorted = sort { $a <=> $b } @common ;
say "@sorted" ;

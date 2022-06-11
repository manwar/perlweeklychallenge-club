#!/usr/bin/env perl
# Perl weekly challenge 148
# Task 1: fibonacci digit sum
#
# See https://wlmb.github.io/2022/01/24/PWC149/#task-1-fibonacci-digit-sum
use v5.12;
use warnings;
use PDL;
use PDL::NiceSlice;
die "Usage: ./ch-1.pl N to obtain N numbers with Fibonacci digit sums\n" unless @ARGV;
my $N=$ARGV[0];
my $fibs=pdl(0,1); # first Fibonacci numbers
my @solutions;
my $try=0; # next number to try
while(@solutions<$N){
    my $sum=pdl(split "", $try)->sumover; # sum of digits
    $fibs=append($fibs, $fibs(-1)+$fibs(-2)) while($sum>$fibs((-1))); # grow $fibs array as needed
    push @solutions, $try if any($sum-$fibs==0);
    ++$try;
};
say "f($N)=",pdl(@solutions);

#!/usr/bin/env perl
# Perl weekly challenge 173
# Task 2: Sylverster's sequence
#
# See https://wlmb.github.io/2022/07/11/PWC173/#task-2-sylvesters-sequence
use v5.36;
use bigint;
say("Usage: ./ch-2.pl N\nto print the first N numbers of Sylvester's sequence"), exit
    unless @ARGV;
my $N=shift;
die "$N should be positive" unless $N>0;
my $s=2;
say "The first $N Sylvester's numbers are\n$s";
say $s=$s*($s-1)+1 foreach(1..$N-1);

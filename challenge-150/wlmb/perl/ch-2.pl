#!/usr/bin/env perl
# Perl weekly challenge 150
# Task 2: square-free integer
#
# See https://wlmb.github.io/2022/01/31/PWC150/#task-2-square-free-integer
use v5.12;
use warnings;
use PDL;
use PDL::NiceSlice;
my $N=$ARGV[0]//500;
my $square_free=ones($N+1);
$square_free(0).=0; # ignore zero
$square_free($_*$_:-1:$_*$_).=0
    for(2..sqrt($N));
say sequence($N+1)->where($square_free);

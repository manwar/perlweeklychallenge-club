#!/usr/bin/env perl
# Perl weekly challenge 150
# Task 1: fibonacci words
#
# See https://wlmb.github.io/2022/01/31/PWC150/#task-1-fibonacci-words
use v5.12;
use warnings;
die "Usage: ./ch-1.pl word word [N]" .
    "to get the N-th (default=51) character of a fibonacci word"
    unless @ARGV>=2;
my ($x, $y, $N)=@ARGV;
$N//=51; # default
my ($l,$m)=map {length $_} ($x, $y); # last two lengths
die "Words should not be empty" unless $l > 0 && $m > 0;
die "N should be >=1" unless $N>=1;
say "Input: x=$x, y=$y, N=$N";
say("Output: ", substr $x, $N-1, 1), exit if $N<=$l; # character in first word
say("Output: ", substr $y, $N-1, 1), exit if $N<=$m; # character in second word
do {($l,$m)=($m,$m+$l)} until $N<=$m; # get lengths of concatenated strings
# get back to the initial two strings
# while updating $N
# Negative $N corresponds to a char not in the current string, but in the following,
# so we make it positive in the following step
($l,$m,$N)=($m-$l, $l, $N>0?$N+$l-$m:$N+$l)  while($m>length($y));
# A final negative $N corresponds to the first word
# a final positive $N corresponds to the second word
say "Output: ", $N<=0? substr($x,$N+length($x)-1,1):substr($y,$N-1,1);

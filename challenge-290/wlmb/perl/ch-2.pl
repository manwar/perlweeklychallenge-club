#!/usr/bin/env perl
# Perl weekly challenge 290
# Task 2:  Luhn’s Algorithm
#
# See https://wlmb.github.io/2024/10/07/PWC290/#task-2-luhn’s-algorithm
use v5.36;
use List::Util qw(sum0);
die <<~"FIN" unless @ARGV;
    Usage: $0 S1 S2...
    to check the digits in the strings S1 S2 with Luhn's algorithm
    FIN
my @doubled=(0,2,4,6,8,1,3,5,7,9); # double a digit and add its digits.
for(@ARGV){
    my $counter=0;
    my @letters=split "";
    my @reversed_digits=reverse grep {/\d/} @letters;
    my @mapped=map {$counter++%2?$doubled[$_]:$_} @reversed_digits; # double every second digit
    my $sum=sum0(@mapped)%10;
    my $result=$sum?"false":"true";
    say	"$_ -> $result";
}

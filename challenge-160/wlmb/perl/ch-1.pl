#!/usr/bin/env perl
# Perl weekly challenge 160
# Task 1: Four is magic
#
# See https://wlmb.github.io/2022/04/11/PWC160/#task-1-four-is-magic
use v5.12;
use warnings;
die "Usage: ./ch-1.pl N1 [N2... ]\n".
    "to find all trajectories between number names starting at index N1, N2..."
     unless @ARGV;
my @names=qw(zero one two three four five six seven eight nine);
for my $n(@ARGV){
    say("Wrong input: $n"), next if $n>=@names;
    while($n!=4){
        print "$names[$n] is ", $names[$n=length $names[$n]], ", ";
    }
    say "four is magic"
};

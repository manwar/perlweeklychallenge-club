#!/usr/bin/env perl
# Perl weekly challenge 113
# Task 1: Represent integer. Faster, recursive
#
# See https://wlmb.github.io/2021/05/22/PWC113/#task-1-represent-integer
use strict;
use warnings;
use v5.12;
use List::Util qw(sum0);
use POSIX qw(floor);

my ($N, $D)=@ARGV; #get arguments from command line.
    die "Usage: ./ch-1.pl positive-integer digit"
    unless defined $N and defined $D and $N>=0
           and $D=~m/^\d$/ and $N==floor $N;
my @set=reverse grep {m/$D/} (1..$N); # ordered set from large to small.
my @answer=find($N,@set);
say("Inputs: N=$N D=$D: Output: ",
    @answer? "1 as $N=". join("+", @answer):"0");


sub find {
    my ($goal, @set)=@_;
    while(defined (my $current=shift @set)){
	next if $current > $goal;
	return ($current) if $current==$goal;
	my @answer=find($goal-$current, @set);
	return ($current,@answer) if @answer;
    }
    return ();
}

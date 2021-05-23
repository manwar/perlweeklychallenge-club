#!/usr/bin/env perl
# Perl weekly challenge 113
# Task 1: Represent integer.
#
# See https://wlmb.github.io/2021/05/22/PWC113/#task-1-represent-integer
use strict;
use warnings;
use v5.12;
use List::Util qw(sum0);
use POSIX qw(floor);

my ($N, $D)=@ARGV; #get arguments from command line.
    die "Usage: ./ch-1a.pl positive-integer digit"
    unless defined $N and defined $D and $N>=0
           and $D=~m/^\d$/ and $N==floor $N;
my $next=subsets(grep {m/$D/} (1..$N));
while(my @subset=$next->()){
    say("Inputs: N=$N D=$D: Output: 1 as $N=",
         join "+", @subset), exit if sum0(@subset)==$N;
}
say "Inputs: N=$N D=$D: Output: 0";

sub subsets {
    my @set=@_;
    my $subset_counter=2**@set; # Total number of subsets
    my $done=0;
    sub {
	return () if $done;
	--$subset_counter;
	$done=1, return () unless $subset_counter;
	my @subset=grep {defined $_}
                        map {$subset_counter&(1<<$_)?$set[$_]:undef}
                        0..@set-1;
	return @subset;
    }
}

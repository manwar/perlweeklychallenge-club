### /* https://theweeklychallenge.org/blog/perl-weekly-challenge-172/
### 
### Task 1: Prime Partition
### 
### Submitted by: [50]Mohammad S Anwar
###      __________________________________________________________________
### 
###    You are given two positive integers, $m and $n.
### 
###    Write a script to find out the Prime Partition of the given number. No
###    duplicates allowed.
### 
###    For example,
### Input: $m = 18, $n = 2
### Output: 5, 13 or 7, 11
### 
### Input: $m = 19, $n = 3
### Output: 3, 5, 11
### 
### */
use strict;
use warnings;
use Math::Prime::Util qw/forprimes/;
use Math::Combinatorics;

die "need two positive integers m and n\n" unless @ARGV==2 && join(" ",@ARGV[0,1]) =~ /^\d+ \d+$/;
my ($m, $n) = @ARGV;

my @p;
forprimes { push @p, $_ } $m;

my $c = Math::Combinatorics->new( count => $n, data => \@p );
{
	last unless my @combo = $c->next_combination();
	printf("%s\n", join(", ",@combo)) if eval(join(" + ",@combo))==$m;
	redo;
}

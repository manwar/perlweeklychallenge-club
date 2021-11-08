#!/usr/bin/env perl
# Perl weekly challenge 125
# Task 1:  Pythagorean triplets
#
# See https://wlmb.github.io/2021/08/10/PWC125/#task-1-pythagorean-triples
use warnings;
use strict;
use v5.12;
use POSIX qw(floor);
use List::Util qw(uniq);

die "Usage: ./ch-1.pl N1 N2... to search for pythagorean triplets containing Ni"
    unless @ARGV;
foreach(@ARGV){
    my $N=floor($_); # check non-negative integer arguments
    warn("Expected natural"), next unless $N>=0 and $N==$_;
    my @found=();
    foreach my $a(1..$N-1){
	foreach my $b (1..$a-1){
	    push @found, [$a, $b, $_/($a**2-$b**2)] if $_%($a**2-$b**2)==0;
	    push @found, [$a, $b, $_/(2*$a*$b)] if $_%(2*$a*$b)==0;
	    push @found, [$a, $b, $_/($a**2+$b**2)] if $_%($a**2+$b**2)==0;
	}
    }
    say "Input; $_\nOutput:";
    say "\t$_" foreach uniq map { #remove duplicates
	my($A,$B,$K)=@$_; # careful not to confuse with $a and $b from sort
	my ($x, $y, $z)=sort {$a <=> $b} map {$K*$_} ($A**2-$B**2, 2*$A*$B, $A**2+$B**2);
	"\t($x, $y, $z)";
    } @found;
    say("\t-1, no result found") unless @found;
}

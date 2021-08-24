#!/usr/bin/env perl
# Perl weekly challenge 127
# Task 1:  disjoint sets
#
# See https://wlmb.github.io/2021/08/23/PWC127/#task-1-disjoint-sets
use warnings;
use strict;
use v5.12;
use PDL;

die 'Usage: ./ch-1.pl "[a1,a2,...]" "[b1,b2,...]" ... to test for disjointness'
    unless @ARGV && @ARGV%2==0;
# Assume arguments of the form "[n1,n2,n3...]"
while(scalar @ARGV){
    my ($s1, $s2)=map {pdl $_} splice @ARGV,0,2;
    my $m=$s1-$s2->dummy(0);
    my $disjoint=$m->all;
    my $repeated=$s2->where($m->andover==0);
    say "Input;\n\t$s1\n\t$s2\nOutput: $disjoint";
    say $disjoint?"As there are no common members"
                 :"As the subset $repeated is common to both sets."
}

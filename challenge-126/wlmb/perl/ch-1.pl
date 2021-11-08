#!/usr/bin/env perl
# Perl weekly challenge 126
# Task 1:  Count numbers. Recursive solution
#
# See https://wlmb.github.io/2021/08/20/PWC126/#task-1-count-numbers
use warnings;
use strict;
use v5.12;
use POSIX qw(floor);

die "Usage: ./ch-1.pl N1 N2... to count numbers up to Ni with no 1's"
    unless @ARGV;
foreach(@ARGV){
    my $N=floor($_); # check non-negative integer arguments
    warn("Expected natural: $_"), next unless $N>=0 and $N==$_;
    say "Input: $_\nOutput: ", $N>1?count(split '',$N)-1:0;
}

sub count {
    state @m1=(0,1,1..8);
    state @m2=(1,0,(1)x8);
    my ($first,@rest)=@_;
    return 1 unless defined $first;
    return $m1[$first]*9**@rest+$m2[$first]*count(@rest); #$first>1
}

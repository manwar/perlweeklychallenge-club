#!/usr/bin/env perl
# Perl weekly challenge 141
# Task 2: Like numbers
#
# See https://wlmb.github.io/2021/11/29/PWC141/#task-2-like-numbers
use v5.12;
use warnings;
use PDL;
use PDL::NiceSlice;

die "Usage: ./ch-2.pl m n" unless @ARGV==2;
my ($m,$n)=@ARGV;
my $l=length $m;
my $digits=pdl[split "", $m];
my $multiples= pdl [
    sort {$a<=>$b}
         grep {$_!~/^0/&&$_%$n==0}
         map {
	     my $bits=pdl([split "", sprintf "%b", $_]);
	     join "", $digits->where($bits->(-1:0))->list;
    } 1..2**$l-2
    ];
say "m=$m, n=$n, Out=", $multiples->nelem,
    "\nas multiples=$multiples";

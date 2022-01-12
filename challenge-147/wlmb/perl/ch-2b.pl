#!/usr/bin/env perl
# Perl weekly challenge 147
# Task 2: pentagon numbers
#
# See https://wlmb.github.io/2022/01/10/PWC147/#task-2-pentagon-numbers
use v5.12;
use warnings;
use Time::HiRes qw(time);
use PDL;
use PDL::NiceSlice;

die "Usage: ./ch-2a.pl largest_index\n" unless @ARGV==1;
my $N=shift;
my $start=time();
my $n=zeroes(long, $N)->xvals+1;
my $p=$n*(3*$n-1)/2;
my $check=pentagonal($p);
my $pass=whichND(pentagonal($p+$p(*1)) & pentagonal($p-$p(*1)));
die "Bad luck" unless $pass->dim(1)>0;
my $ij=$pass(:,(0))+1;
my ($pi, $pj)=map {$p(($_-1))} (my ($i, $j)=map {$ij(($_))} (0,1));
my ($s, $d)=($pi+$pj, $pi-$pj);
my ($k, $l)=map {index_of($_)} ($d, $s);
say "p$i=$pi\np$j=$pj\np$i-p$j=$d=p$k\np$i+p$j=$s=p$l";
say "Time: ", time()-$start;
sub pentagonal {
    my $p=shift;
    my $p241=24*$p+1;
    my $sp241=$p241->sqrt;
    return (($p>0)&($sp241**2==$p241) & ($sp241%6==5));
}
sub index_of {
    my $p=24*shift()+1;
    my $s=sqrt($p);
    return ($s+1)/6;
}

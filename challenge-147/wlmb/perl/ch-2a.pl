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
for my $i (1..$p->nelem){
    my $pi=$p(($i-1));
    my $pass=which(pentagonal($pi+$p) & pentagonal($pi-$p));
    next unless $pass->nelem;
    my $j=$pass((0))+1;
    my $pj=$p(($j-1));
    my $s=$pi+$pj;
    my $d=$pi-$pj;
    my ($k, $l)=map {index_of($_)} ($d, $s);
    say "p$i=$pi\np$j=$pj\np$i-p$j=$d=p$k\np$i+p$j=$s=p$l";
    last;
}
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

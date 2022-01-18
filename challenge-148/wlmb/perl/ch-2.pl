#!/usr/bin/env perl
# Perl weekly challenge 148
# Task 2: Cardano triplets
#
# See https://wlmb.github.io/2022/01/17/PWC148/#task-2-cardano-triplets
use v5.12;
use warnings;
use PDL;
use PDL::NiceSlice;
#Usage: .ch-2.pl [-howmany N] [-upperbound U]
# to obtain N Cardano triplets with integeres up to U
my %options=(-howmany=>5, -upperbound=>100, @ARGV);
my ($how_many, $upper_bound)=@options{(-howmany, -upperbound)};
my $n=sequence(long,$upper_bound);
my $a=$n;
my $b=$n(*1);
my $c=$n(*1,*1);
my $k=8*$a*$a*$a+15*$a*$a+6*$a-27*$b*$b*$c-1;
my $r=whichND($k==0); # $r contains Cardano triplets
my $found=$r->dim(1); # how many triplets were found
say "Not enough candidates, please increase upper bound"
    unless $found>=$how_many;
$how_many=$found if $how_many>$found;
say "The first $how_many Cardano triplets are\n", $r(:,0:$how_many-1) if $how_many>0;

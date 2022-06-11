#!/usr/bin/env perl
# Perl weekly challenge 152
# Task 2: Rectangle area
#
# See https://wlmb.github.io/2022/02/14/PWC152/#task-2-rectangle-area
use v5.12;
use warnings;
use List::Util qw(min sum0 all);
die "Usage: ./ch-2.pl L1 B1 R1 T1 L2 B2 R2 T2 ..."
    . "where L's B's R's and T's denote left, bottom, right and top coordinates"
    unless @ARGV;
my @non_ol;
my @input;
my @pending;
while(@ARGV){
    die "# coordinates must be multiple of four" unless @ARGV>=3;
    my ($L,$B,$R,$T)=splice @ARGV, 0, 4;
    ($L, $R)=($R, $L) if $L>$R; # reorder if necessary
    ($B, $T)=($T, $B) if $B>$T;
    push @input, {left=>$L, bottom=>$B, right=>$R, top=>$T};
}
my @pending=@input;
 ADD1:
    while(@pending){
	my $rectangle=shift @pending;
	foreach(@non_ol){
	    my @fragments=divide($rectangle, $_);
	    next ADD1 if @fragments==1; # rectangle contained in some other piece
	    push(@pending, @fragments), next ADD1 if @fragments>1;

	}
	push @non_ol, $rectangle;
}
say "Input: ";
say "\tRectangle $_: ($input[$_]->{left},$input[$_]->{bottom}), ",
    "($input[$_]->{right},$input[$_]->{top})" for(0..@input-1);
say "Area: ", sum0 map {($_->{right}-$_->{left})*($_->{top}-$_->{bottom})} @non_ol;
say "Non-overlapping subregions: ";
say "\tRectangle $_: ($non_ol[$_]->{left},$non_ol[$_]->{bottom}), ",
    "($non_ol[$_]->{right},$non_ol[$_]->{top})" for(0..@non_ol-1);
sub divide {
    my ($p, $q)=@_;
    return if $p->{left}>=$q->{right}    # no overlap
              or $p->{right}<=$q->{left}
              or $p->{bottom}>=$q->{top}
              or  $p->{top}<=$q->{bottom};
    return ({left=>$p->{left}, bottom=>$p->{bottom}, right=>$q->{left}, top=>$p->{top}},
	    {left=>$q->{left}, bottom=>$p->{bottom}, right=>$p->{right}, top=>$p->{top}})
	if $p->{left}<$q->{left}; # split left
    return ({left=>$p->{left}, bottom=>$p->{bottom}, right=>$q->{right}, top=>$p->{top}},
	    {left=>$q->{right}, bottom=>$p->{bottom}, right=>$p->{right}, top=>$p->{top}})
	if $p->{right}>$q->{right}; # split right
    return ({left=>$p->{left}, bottom=>$p->{bottom}, right=>$p->{right}, top=>$q->{bottom}},
	    {left=>$p->{left}, bottom=>$q->{bottom}, right=>$p->{right}, top=>$p->{top}})
	if $p->{bottom}<$q->{bottom}; # split bottom
    return ({left=>$p->{left}, bottom=>$p->{bottom}, right=>$p->{right}, top=>$q->{top}},
	    {left=>$p->{left}, bottom=>$q->{top}, right=>$p->{right}, top=>$p->{top}})
	if $p->{top}>$q->{top}; # split top
    return $p; # $p contained in $q
}

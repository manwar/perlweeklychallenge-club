#!/usr/bin/env perl
use strict;
use warnings;
use Data::Dumper;
use Math::Trig ':pi';
use POSIX qw<round>;
use v5.28;

my $matrix=[
	[ 1, 2, 3 ],
	[ 4, 5, 6 ],
	[ 7, 8, 9 ]
];


say "0deg rotation:";
rotate($matrix,0);
say "90deg rotation:";
rotate($matrix,90);
say "180deg rotation:";
rotate($matrix,180);
say "270deg rotation:";
rotate($matrix,270);

sub rotate {
	my ($input,$angle)=@_;
	#input indexing
	my @ip=map {pip4 *$_} 0..7;
	my @ir=map {1+round sin} @ip;
	my @ic=map {1+round cos} @ip;

	#output indexing
	my @polar=map {($angle/180 *pi) + pip4 *$_} 0..7;
	my @row= map {1+round sin} @polar;
	my @col =map {1+round cos} @polar;

	my $out=[[],[],[]];

	$out->[1]->[1]=$matrix->[1]->[1];
	$out->[$row[$_]]->[$col[$_]]=$matrix->[$ir[$_]]->[$ic[$_]] for (0..@col-1);
	say "[".join(", ", @{$out->[$_]})."]" for 0..2;
	$out;
}

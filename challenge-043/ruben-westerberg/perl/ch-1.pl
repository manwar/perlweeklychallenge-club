#!/usr/bin/env perl
use strict;
use warnings;

my %rings=(red=>9,green=>5,black=>0,yellow=>7,blue=>8);
my @y= map {11- $_} @rings{qw<red green black yellow blue>}; 
my @m=( [1,0,0,0,0],
        [1,1,0,0,0],
        [0,1,1,1,0],
        [0,0,0,1,1],
        [0,0,0,0,1]
);
my $x=solve(\@m,\@y);

my @labels=qw(red/green green/black black black/yellow yellow/blue);
printf "%-15s%d\n",$labels[$_],$$x[$_] for 0..$#labels;


sub solve {
	my ($c, $y)=@_;
	my $j=build($c,$y);
	my $s=@$c;
	my $row;	
	for my $p (0..$s-1) {
		my $v=$j->[$p][$p];
		my $prow=$j->[$p];
		for my $r (0..$s-1) {
			$row=$j->[$r];
			next if $p==$r;
			my $d=$row->[$p]/$v;
			for my $col (0..$s) {
				$row->[$col]-=$d*$prow->[$col];
			}
		}
	}
	$row->[-1]/=$row->[-2];
	$row->[-2]=1;
	backsub($j);
}

sub build {
	my ($c,$y)=@_;
	my @j;
	for (0..(scalar @$c -1)) {
		push @j, [@{$c->[$_]},$y->[$_]];
	}
	\@j;
}

sub backsub {
	my ($j)=@_;
	my $s=@$j;
	my @x=(0) x $s;
	for my $r (reverse 0..$s-1) {
		my $sum=0;
		my $row=$j->[$r];
		for (0..$s-1) {
			$sum+=$$row[$_]*$x[$_];	
		}
		$x[$r]=$row->[$s]-$sum;
	}

	\@x;
}


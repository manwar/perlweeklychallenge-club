#!/usr/bin/env perl
use strict;
use warnings;
use v5.26;


my @inputs=@ARGV > 0 ? @ARGV : (10,20,20,51);
@inputs =sort @inputs;

sub rank1224 {
	my $ref=sub {map {
		state $prev=$_;
		state $count=0;
		$count= ($prev != $$_[1])? 1: $count +1;
		$prev=$$_[1];
		$$_[0]+2-$count;
	}

	(map {state $i;[$i++,$_]} @_);
	};
	&$ref(@_);
}

sub rank1334 {
	my @r=rank1224(reverse @_);
	map {@r+1 - $_} reverse @r;
}

sub rank1223 {
	map  {
		state $prev=$_;
		state $r=1;
		$r= ($prev != $_) ? $r+1: $r;
		$prev=$_;
		$r;

	} @_;
}
print "Inputs: ",join " ",@inputs;
print "\n";
print "1224 Ranking: ",join ' ', rank1224(@inputs);
print "\n";
print "1334 Ranking: ",join ' ', rank1334(@inputs);
print "\n";
print "1223 Ranking: ", join ' ', rank1223(@inputs);

#!/usr/bin/env perl

use List::Permutor;
use Array::Compare;

print &permutation2rank([1,0,2]),"\n"; # 2
print &rank2permutation([0,1,2],1),"\n"; # 021

sub permutation2rank {
	my ($rarry) = @_;
	my $comp = Array::Compare -> new; 
	my $ctr=0;
	my $p = new List::Permutor (sort @$rarry);
	while (my @set = $p->next) {
		last if $comp->compare($rarry,\@set);
		$ctr++;
	}
	return $ctr;
}

sub rank2permutation {
	my ($rarry, $rank) = @_; my $ctr=0;
	my $p = new List::Permutor (sort @$rarry);
	my @set=();
	while (@set = $p->next) {
		last if $ctr==$rank;
		$ctr++;
	}
	return @set;
}


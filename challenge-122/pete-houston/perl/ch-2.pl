#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 12202.pl
#
#        USAGE: ./12202.pl N 
#
#  DESCRIPTION: Print all permutations of 1, 2, 3 to sum to N.
#
# REQUIREMENTS: Algorithm::Knapsack, List::Util, Math::Combinatorics
#        NOTES: Although this works, it is inelegant.
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 19/07/21
#===============================================================================

use strict;
use warnings;
use Algorithm::Knapsack;
use List::Util 'sum';
use Math::Combinatorics;

my $n = shift;

my @aoa = combos ($n, 0);
@aoa = permos (@aoa);
for my $set (@aoa) {
	print "@$set\n";
}

sub combos {
	my ($tot, $level) = @_;
	my @solutions;
	my @scores;
	my @fs;
	push @scores, ($_) x ($tot / $_) for 1 .. 3;
	my $sack = Algorithm::Knapsack->new (
		capacity => $tot,
		weights  => \@scores,
	);
	$sack->compute;
	my $combos = 0;
	my %seen;
	for my $fit ($sack->solutions) {
		next unless sum (@scores[@$fit]) == $tot;
		my $res = join (' + ', @scores[@$fit]) . " = $tot\n";
		next if $seen{$res};
		$seen{$res} = 1;
		# Count frequencies
		my %freqs;
		$freqs{$_}++ for @scores[@$fit];
		push @fs, [map { $freqs{$_} || 0 } 1 .. 3];
		push @solutions, [@scores[@$fit]];
		$combos++;
	}
	return @fs;
}

sub permos {
	my @sets = @_;
	my @perms;
	for my $combo (@sets) {
		# Permute these indistinguishably
		my $permer = Math::Combinatorics->new (
			count => sum (@$combo),
			data => [1 .. 3],
			frequency => $combo
		);
		while (my @x = $permer->next_string) {
			push @perms, [@x];
		}
	}
	return @perms;
}

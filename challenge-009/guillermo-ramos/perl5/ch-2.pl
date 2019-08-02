#!/usr/bin/env perl

use strict;
use warnings;

sub rank {
	my $rank_type = shift;
	my @points = sort @_;

	my %ranks;
	my $rank = $rank_type eq "modified" ? 0 : 1;

	my $interval_begin = 0;
	my $i;
	for ($i = 0; $i < @points; $i++) {
		my $point = $points[$i];
		if ($point != $points[$interval_begin]) {
			my @points_to_add = @points[$interval_begin .. ($i-1)];
			$rank += @points_to_add if $rank_type eq "modified";
			$ranks{$rank} = \@points_to_add;
			if ($rank_type eq "standard") {
				$rank += @points_to_add;
			} elsif ($rank_type eq "dense") {
				$rank = $rank + 1;
			}
			$interval_begin = $i;
		}
	}
	my @points_to_add = @points[$interval_begin .. ($i-1)];
	$rank += @points_to_add if $rank_type eq "modified";
	$ranks{$rank} = \@points_to_add;
	return \%ranks;
}

# Get rank type and points as CLI arguments
my $rank_type = shift || "";
grep /^$rank_type$/, qw(modified standard dense)
	or die "Usage: $0 {modified, standard, dense} rank1 rank2 ...";
my @points = @ARGV;

# Compute rankings
my $ranks = rank($rank_type, @points);

# Display rankings
for my $rank (sort (keys %$ranks)) {
	my @positions = @{$ranks->{$rank}};
	print "$rank. @positions\n";
}

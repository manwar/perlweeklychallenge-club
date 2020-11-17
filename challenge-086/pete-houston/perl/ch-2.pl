#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 8602.pl
#
#        USAGE: ./8602.pl [ infile ]
#
#  DESCRIPTION: Solve a sudoku puzzle
#
#      OPTIONS: Reads the input grid from STDIN if a filename isn't given
# REQUIREMENTS: None, just perl!
#        NOTES: The solver is a bit naive and will only find unique solutions
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 11/11/20
#===============================================================================

use strict;
use warnings;

my $grid = load_grid ($ARGV[0]);
solve ($grid);
output ($grid);

sub load_grid {
	my $fh = \*STDIN;
	if (defined $_[0]) {
		open $fh, '<', $_[0] or die "Cannot open $_[0]: $!";
	}

	my @input;
	while (my $line = <$fh>) {
		$line =~ s/_/0/g;
		my @digits = ($line =~ /([0-9])/g);
		next unless $#digits == 8;
		push @input, \@digits;
	}
	die "Only " . scalar @input . " lines successfully read" unless
		$#input == 8;
	return \@input;
}

sub solve {
	my $grid = shift;
	my $missing = 81;
	while ($missing) {
		for my $row (0 .. 8) {
			my @missing_ids = grep { $grid->[$row][$_] < 1 } (0 .. 8);
			for my $id (@missing_ids) {
				find_one ($grid, $row, $id);
			}
		}
		my $oldmissing = $missing;
		$missing = grep { $_ < 1 } map { @$_ } @$grid;
		die "Cannot be solved\n" if $missing == $oldmissing;
	}
}

sub find_one {
	my ($grid, $row, $col) = @_;
	my %poss = map { $_ => 1 } 1 .. 9;

	# Row
	delete $poss{$_} for grep { $_ } @{$grid->[$row]}[0 .. 8];

	# Column
	for my $j (0 .. 8) {
		my $n = $grid->[$j][$col];
		delete $poss{$n} if $n;
	}

	# Square
	my $y = int ($row / 3) * 3;
	my $x = int ($col / 3) * 3;
	for my $j ($y .. $y + 2) {
		for my $i ($x .. $x + 2) {
			my $n = $grid->[$j][$i];
			delete $poss{$n} if $n;
		}
	}
	my @possibles = keys %poss;
	die "No options left for $row, $col\n" if 1 > @possibles;
	if (2 > @possibles) {
		($grid->[$row][$col]) = $possibles[0];
		return;
	}
}

sub output {
	my $grid = shift;
	for my $row (0 .. 8) {
		print "@{$grid->[$row]}\n";
	}
}

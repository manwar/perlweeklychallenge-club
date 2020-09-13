#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 7702.pl
#
#        USAGE: ./7702.pl GRIDFILE
#
#  DESCRIPTION: Find Xs with no X neighbours
#
# REQUIREMENTS: Path::Tiny, Lingua::EN::Inflexion, Lingua::EN::Nums2Words
#        NOTES: In addition to the number found, also prints locations
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 12/09/20
#===============================================================================

use strict;
use warnings;
use autodie;

use Path::Tiny 'path';
use Lingua::EN::Inflexion;

my @grid = read_grid (shift);
my @xmess = find_solo_x (@grid);
print scalar (@xmess), "\n", @xmess;

sub read_grid {
	my @rows = path(shift)->lines ({chomp => 1});
	tr/OX//dc, $_ = [ split //, $_ ] for @rows;
	return @rows;
}

sub find_solo_x {
	my @grid = @_;
	my $maxrow = $#grid;
	my $maxcol = $#{$grid[0]};
	die "Grid is not rectangular.\n" if grep { $#$_ != $maxcol } @grid;
	my @solos;
	for my $r (0 .. $maxrow) {
		for my $c (0 .. $maxcol) {
			next unless $grid[$r][$c] eq 'X';
			push @solos, mess ($r, $c, $#solos)
				if all_os_around (\@grid, $r, $c);
		}
	}
	return @solos;
}

sub all_os_around {
	my ($grid, $r, $c) = @_;
	for my $i ($r - 1 .. $r + 1) {
		next unless $i >= 0 && defined $grid->[$i];
		for my $j ($c - 1 .. $c + 1) {
			next unless $j >= 0 && defined $grid->[$i][$j];
			next if $i == $r && $j == $c;
			return if $grid->[$i][$j] eq 'X';
		}
	}
	return 1;
}

sub mess {
	my ($r, $c, $tot) = @_;
	$tot += 2;
	$r   += 1;
	$c   += 1;
	return ucfirst inflect ("<#ow:$tot> X found at Row $r Col $c.\n");
}

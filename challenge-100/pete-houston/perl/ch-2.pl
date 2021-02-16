#!/usr/bin/env perl
#===============================================================================
#
#         FILE: 10002.pl
#
#        USAGE: ./10002.pl < input_file
#
#  DESCRIPTION: Minimum path sum down the triangle. Expects the triangle
#    to be on STDIN with one row per line. Each entry is expected to be a
#    whole number, separated from neighbours by non-digits.
#    Example input_file:
#
#            1
#           2 4
#          6 4 9
#         5 1 7 2
#
# REQUIREMENTS: Perl 5.10, Class::Tiny, Ref::Util, List::Util
#        NOTES: Perhaps not the most efficient, but I've been looking
#               for an excuse to try Class::Tiny, so here it is.
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 15/02/21
#===============================================================================

use strict;
use warnings;
use 5.010;

package Node;

use Class::Tiny qw/lchild rchild value minval/;
use Ref::Util qw/is_ref is_arrayref/;
use List::Util 'min';

sub BUILDARGS {
	my ($class, $init, $r, $c, $lastchild) = @_;
	if (is_arrayref ($init)) {
		# Buld tree from AoA
		$r //= 0;
		$c //= 0;
		my $self = Node->new ($init->[$r][$c]);

		# Add children if we are not the bottom row
		if ($r < $#$init) {
			$self->lchild (
				$lastchild //
				Node->new ($init, $r + 1, $c));
			$self->rchild (Node->new ($init, $r + 1, $c + 1,
				$self->lchild->rchild));
		}
		return $self;
	} elsif (!is_ref ($init)) {
		# Set value from scalar
		return { value => $init };
	}
	return {};
}

# Retrieve or calculate the minimum path downwards from here.
sub minsum {
	my $self = shift;
	unless (defined $self->minval) {
		my $sum = $self->value;
		$sum += min ($self->lchild->minsum, $self->rchild->minsum) if
			defined $self->lchild;
		$self->minval ($sum)
	}
	return $self->minval;
}

package main;

my @aoa  = map { [/([0-9]+)/g] } <STDIN>;
my $root = Node->new (\@aoa);

print $root->minsum . "\n";

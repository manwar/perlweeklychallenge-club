#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 14602.pl
#
#        USAGE: ./14602.pl N/M
#
#  DESCRIPTION: Print out 2 ancestors of the tree value matching the
#               argument.
#
# REQUIREMENTS: Class::Tiny
#        NOTES: The tree is really unnecessary here. See 14602b.pl for
#               alternative approach without one.
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 03/01/22
#===============================================================================

use strict;
use warnings;

# Each pair of children have values which are:
# 	Left: parent numerator over sum of parent numerator and denominator
# 	Right: sum of parent numerator and denominator over parent denominator

package Node;

use Class::Tiny qw/lchild rchild parent value/;

sub BUILD {

	#my ($class, $value, $r, $maxdepth, $parent) = @_;
	my ($self, $args) = @_;
	my $r        = $args->{row};
	my $maxdepth = $args->{maxdepth};

	# Build tree from 1/1
	unless ($args->{row}) {
		$r //= 0;
		$self->value ('1/1') unless defined $self->value;
	}

	# Add children if we are not the bottom row
	if ($r < $maxdepth) {
		my ($num, $dom) = split /\//, $self->value;
		my $sum       = $num + $dom;
		my %childargs = (
			row      => $r + 1,
			maxdepth => $maxdepth,
			parent   => $self
		);
		$self->lchild (Node->new (value => "$num/$sum", %childargs));
		$self->rchild (Node->new (value => "$sum/$dom", %childargs));
	}

}

# Retrieve or calculate the minimum path downwards from here.
sub find_by_value {
	my ($self, $value) = @_;
	return $self if $self->value eq $value;
	for my $child ($self->lchild, $self->rchild) {
		next unless defined $child;
		my $res = $child->find_by_value ($value);
		return $res if defined $res;
	}
	return;
}

package main;

my $root = Node->new (value => '1/1', row => 0, maxdepth => 4);

my $v = shift;
my $one = $root->find_by_value ($v);

unless (defined $one) {
	print "No match for value '$v' found\n";
	exit;
}

my $parent = $one->parent;
unless (defined $parent) {
	print "No parent found\n";
	exit;
}
print "parent = '" . $parent->value . "' and ";

my $gparent = $parent->parent;
unless (defined $gparent) {
	print "no grandparent found\n";
	exit;
}
print "grandparent = '" . $gparent->value . "'\n";


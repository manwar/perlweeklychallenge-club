#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 12902.pl
#
#        USAGE: ./12902.pl  
#
#  DESCRIPTION: Linked list addition
#
# REQUIREMENTS: Class::Tiny
#        NOTES: DLL class could also have pop and shift methods but they
#               are not needed for this exercise so have been omitted for
#               brevity.
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 06/09/21
#===============================================================================

use strict;
use warnings;

package Link;

use Class::Tiny qw/next prev value/;

sub new {
	my ($class, $payload, $prev, $next) = @_;
	my $self =  { value => $payload, prev => $prev, next => $next };
	bless $self, $class;
	return $self;
}

################################################################################

package DLL;

use Class::Tiny qw/head tail/;

sub new {
	my $class = shift;
	my $self = {
		head => Link->new (shift)
	};
	$self->{tail} = $self->{head};
	bless $self, $class;
	for my $val (@_) {
		$self->push ($val)
	}
	return $self;
}

sub push {
	my ($self, $val) = @_;
	my $new = Link->new ($val, $self->tail);
	$self->tail->next ($new);
	$self->tail ($self->tail->next);
}

sub unshift {
	my ($self, $val) = @_;
	my $new = Link->new ($val, undef, $self->head);
	$self->head->prev ($new);
	$self->head ($self->head->prev);
}

sub print {
	my $self = shift;
	my $this = $self->head;
	my $out = shift // '';
	while (defined $this) {
		$out .= $this->value . '->';
		$this = $this->next;
	}
	$out =~ s/->$/\n/;
	print $out;
}

sub add {
	my ($self, $add) = @_;
	my $this  = $self->tail;
	my $that  = $add->tail;
	my $carry = 0;
	my ($sum, $result);
	while (1) {
		$sum =
			(defined ($this) ? $this->value : 0) +
			(defined ($that) ? $that->value : 0) +
			$carry;
		if ($sum > 9) {
			$carry = 1;
			$sum -= 10;
		} else {
			$carry = 0;
		}
		last unless $carry || defined ($this) || defined ($that);
		if (defined $result) {
			$result->unshift ($sum);
		} else {
			$result = DLL->new ($sum);
		}
		$this = $this->prev if defined $this;
		$that = $that->prev if defined $that;
	}
	return $result;
}

################################################################################

package main;

my $first  = get_list ('first');
my $second = get_list ('second');
$first->print ('First is ');
$second->print ('Second is ');

my $sum = $first->add ($second);
$sum->print ('Sum is ');

sub get_list {
	my $which = shift;
	print "Enter the digits for the $which list all on one line.\n";
	return DLL->new (<STDIN> =~ /[0-9]/g);
}

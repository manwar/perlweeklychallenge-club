#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 14001.pl
#
#        USAGE: ./14001.pl X Y
#
#  DESCRIPTION: Add the two binary numbers and print the result. eg:
#
#               $ ./14001.pl 1101 111
#               10100
#
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 22/11/21
#===============================================================================

use strict;
use warnings;

package Bin;

use overload (
	'+'  => 'add',
	'""' => 'bin'
);

sub new {
	my ($class, $str) = @_;
	# $str is a string of bits, eg: "10010";
	my $self = {
		bin => $str,
		dec => defined ($str) ? bin2dec ($str) : $str
	};
	bless $self, $class;
}

sub dec { $_[0]->{dec} };
sub bin { $_[0]->{bin} };

sub bin2dec {
	my @bits = split //, shift;
	my $dec = 0;
	my $fac = 1;
	while (@bits) {
		$_ = pop @bits;
		$dec += $fac * $_;
		$fac *= 2;
	}
	return $dec;
}

sub add {
	my ($x, $y) = @_;
	my $dsum = $x->{dec} + $y->{dec};
	return Bin->new (sprintf "%b", $dsum);
}

package main;

print Bin->new ($ARGV[0]) + Bin->new ($ARGV[1]) . "\n";

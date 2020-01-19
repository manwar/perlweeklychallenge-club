#!/usr/bin/perl

package Hex;

use strict;
use warnings;
use Data::Dumper qw(Dumper);
use bigint qw/hex/;
require Exporter;

use overload 
	'""' => \&out,
	'++' => \&incr,
	'!=' => \&ne,
	'=' => \&clone,
	'fallback' => 1;

our @ISA = qw(Exporter);
our @EXPORT_OK = qw(debug);
$Data::Dumper::Indent=0;

sub new {
	my ($class,$n,$hex) = @_;
	$n = hex($n) if $hex;
	$n = 0 if ! $n;
	my $self = \$n;
	bless $self, $class;
	return $self;
}

sub clone {
	my ($self) = @_;
	my $n = $$self;
	my $copy = bless \$n, ref $self;
    return $copy;
}

sub set {
	my ($self,$value,$hex) = @_;
	$value = hex($value) if $hex;
	$$self = $value;
}

sub incr {
	my ($self) = @_;
	$$self++;
	my $hex = sprintf("%x",$$self);
	return $hex;
}

sub ne {
	my ($self,$cmp) = @_;
	my $hex = sprintf("%x",$$self);
	if($$self != $cmp->dec()) {
		return 1;
	} 
	return 0;
}

sub out { 
	my $self = shift; 
	my $hex = sprintf("%x",$$self);
	return $hex; 
}

sub dec {
	my $self = shift;
	return $$self;
}

sub print {
	my $self = shift; 
	printf("%x",$$self);
}

1;

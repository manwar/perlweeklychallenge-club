#!/usr/bin/env perl
use warnings;
use strict;
use  Tie::Scalar;

package myclass;
sub TIESCALAR {
	my $class=shift;
	my $h=shift;
	bless ({history=>$h}, $class);
}

sub FETCH {
	my $self=shift;
	my $h=$self->{history};
	$h->[-1];
}
sub STORE {
	my $self=shift;
	my $value=shift;
	push @{$self->{history}},$value;

}

package main;
my $test;
my @history;
tie $test, 'myclass', \@history;
$test=10;
$test=1;
$test=15;
print "Current Value of variable: $test\n";
print "Historical Values: @history\n";

#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 9502.pl
#
#        USAGE: ./9502.pl  
#
#  DESCRIPTION: Stack demo as a test script
#
# REQUIREMENTS: List::Util and Test::More (which are in core)
#        NOTES: Since a stack is a list, we will use an arrayref object
#               instead of the traditional hashref.
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 11/01/21
#===============================================================================

use strict;
use warnings;

package Stack;

use List::Util;

sub new {
	my $class = shift;
	return bless \@_, $class;
}

sub push {
	my ($self, @args) = @_;
	push @$self, @args;
}

sub pop {
	pop @{$_[0]};
}

sub top {
	return $_[0]->[-1];
}

sub min {
	return List::Util::min @{$_[0]};
}

package main;

use Test::More tests => 3;

my $stack = Stack->new;
$stack->push (2);
$stack->push (-1);
$stack->push (0);
is $stack->pop, 0, 'Popped 0';
is $stack->top, -1, '-1 is at stack top';
$stack->push (0);
is $stack->min, -1, '-1 is min value';

#!/usr/bin/env perl

use Syntax::Construct 'non-destructive-substitution';

use strict;
use warnings;

sub challenge_185_1 {
	my ($mac) = @_;

	return $mac
		=~ s/[^[:xdigit:]]+//gr
		=~ s/( [[:xdigit:]]{2} ) (?! $)/$1:/grx
		;
}


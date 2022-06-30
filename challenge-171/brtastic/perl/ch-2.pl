#!/usr/bin/env perl

use v5.36;
use List::Util qw(shuffle);

sub compose ($f1, $f2)
{
	return sub (@args) {
		return $f1->($f2->(@args));
	};
}

my $sub_ref = compose(sub { local $, = ", "; say @_ }, \&shuffle);

$sub_ref->(1 .. 20);


#!/usr/bin/env perl
use strict;
use warnings;
print $_."\n" for (center(<>));
sub center {
	my $max=0;
	map { chomp; ($max < length($_ )) ? $max=length($_):();} @_;
	return map { ' ' x (($max - length $_)/2) . $_} @_;
}

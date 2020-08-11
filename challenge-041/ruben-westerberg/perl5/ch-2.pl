#!/usr/bin/env perl
use strict;
use warnings;
use v5.26;

print map { "n: $_ l: ".l($_)."\n"} 0..19;

sub l {
	my $i=shift;
	state @cache=(1,1);
	push @cache, $cache[-1]+$cache[-2]+1 while(! defined($cache[$i]));
	$cache[$i];
}

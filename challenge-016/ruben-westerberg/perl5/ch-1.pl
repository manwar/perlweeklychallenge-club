#!/usr/bin/env perl
use strict;
use warnings;
use v5.26;

my $i=0;
while (1) {
	state $sum+=++$i;
	last if $sum > 100;
}
print --$i."\n";

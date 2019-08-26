#!/usr/bin/env perl
use strict;
use warnings;
use v5.26;
#
my $input=$ARGV[0]//"aabcDDefffgh";
my @a=split "", $input;
my @b;
for (0..@a-1) { 
	my $v=$a[$_];
	state $prev=$v;
	state @stack;
	if( $v eq $prev) {
		push @stack, $v;
	}
	else {
		push @b, join "", @stack;
		@stack=();
		push @stack,$v;
	}
	$prev=$v;
	push @b, join "", @stack if $_ ==  @a-1;
};

print join("|",@b),"\n";


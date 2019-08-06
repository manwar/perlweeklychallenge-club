#!/usr/bin/env perl
use strict;
use warnings;
use v5.26;
#
my $input=$ARGV[0]//"aabcDDefffgh";

my @a=split "", $input;

my @b;
for (@a) { 
	state $prev=$_;
	state @stack;
	if( $_ eq $prev) {
		push @stack, $_;
	}
	else {
		push @b, join "", @stack;
		@stack=();
		push @stack,$_;
		
	}
	$prev=$_;
};

print join("|",@b),"\n";


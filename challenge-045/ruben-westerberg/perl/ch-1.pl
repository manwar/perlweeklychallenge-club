#!/usr/bin/env perl
use warnings;
use strict;

my $string="The quick brown fox jumps over the lazy dog";
my $padded=$string =~ tr/ //dr;
$padded .= " " x (8+8-length($padded)%8);
my @rows;
my $steps=length($padded)/ 8;
push @rows, [split "", substr $padded, $_*8,8] for (0..$steps-1);
my $out="";
for my $c (0..7) {
	for my $r (0..$steps-1) {
		$out.= join "",$rows[$r]->[$c];
	}
}
$out=~s/ +/ /g;
$out=~s/ $//;
print $out;

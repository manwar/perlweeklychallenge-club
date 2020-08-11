#!/usr/bin/env perl
use strict;
use warnings;


my @inComming=(
	[qw"P + 2 l ! a t o"],
	[qw"1 e 8 0 R $ 4 u"],
	[qw"5 - r ] + a > /"],
	[qw"P x w l b 3 k \\"],
	[qw"2 e 3 5 R 8 y u"],
	[qw"< ! r ^ ( ) k 0"]
);
my @decoded;
for my $c (0..@{$inComming[0]}-1) {
	my @col;
	my %count;
	for my $r (@inComming) {
		my $v=$$r[$c];
		$count{$v}++;
		if ($count{$v}==2) {
			push @decoded, $v;
			last;
		}
	}
}
print join "", @decoded;

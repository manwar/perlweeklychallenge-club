#!/usr/bin/perl
use 5.36.0;
use strict;

use Time::HiRes qw/time/;

use subs qw/
	simple_method
	my_method
	create_matrix
/;

my $min = 0, my $max = 10000;
say "Using a matrix of 2..100 X 2..100";
say "With elements from $min to $max\n";

foreach my $n (2..100) {
	my @m = create_matrix $n, $min, $max;

	my $st = time;
	simple_method @m;
	my $me_1 = (time - $st) * 1000 ** 2;

	$st = time;
	my_method @m;
	my $me_2 = (time - $st) * 1000 ** 2;

	my $win = $me_1 < $me_2
		? 'simple_method'
		: 'my_method'
	;

	say sprintf
		"%03d X %03d:\t%05d\t%05d\t$win",
		$n, $n, $me_1, $me_2
	;
}

sub create_matrix
{
	my $n2 = shift;
	my $min = shift;
	my $max = shift;
	my @matrix;

	for (my $i = 0; $i < $n2; $i++) {
		for (my $j = 0; $j < $n2; $j++) {
			$matrix[$i][$j] = int rand($max - $min) + $min;
		}
	}
	@matrix
}

sub simple_method
{
	(sort { $a <=> $b } map { @$_ } @_)[2]
}

sub my_method
{
	my @m = @_;
	my @small;
	for (my $i = 0; $i <= $#m; $i++) {
		for (my $j = 0; $j <= $#m; $j++) {
			@small = sort { $a <=> $b } (@small, $m[$i][$j]);
			pop @small unless $#small <= 2;
		}
	}

	pop @small
}

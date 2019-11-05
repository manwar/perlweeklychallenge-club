#!/usr/bin/perl
#
# Challenge 2: "ASCII bar chart: Write a function that takes a hashref
# where the keys are labels and the values are integer or floating point
# values. Generate a bar graph of the data and display it to stdout.
# 
# The input could be something like:
# 
# $data = { apple => 3, cherry => 2, banana => 1 };
# generate_bar_graph($data);
# 
# And would then generate something like this:
# 
#  apple | ############
# cherry | ########
# banana | ####
# 
# If you fancy then please try this as well: (a) the function could let
# you specify whether the chart should be ordered by (1) the labels, or
# (2) the values.
# 
# My notes: easy, especially using a histogram module I wrote recently.
#

use v5.10;	# for "say"
use strict;
use warnings;
use Data::Dumper;
use List::Util qw(max);
use Function::Parameters;

#
# my $str = generate_bar_graph( $data, $width, $bylabels );
#	Generate a bar graph from the frequency data in $data (a hashref),
#	where the maximum frequency occupies $width characters,
#	either sorted by labels (if $bylabels is true) or
#	by numeric values, returning a printable string form.
#
fun generate_bar_graph( $data, $width, $bylabels )
{
	my $maxv = max( values %$data );
	my $fieldw = max( map { length($_) } keys %$data );
	my $scale = int($width/$maxv);
	#die "debug: g_b_g: maxv=$maxv, fieldw=$fieldw, scale=$scale\n";
	my @str;
	my $fw = $fieldw+2;
	my @data = sort {
		$bylabels ? $a cmp $b : $data->{$b} <=> $data->{$a}
	} keys %$data;
	foreach my $k (@data)
	{
		my $v = $data->{$k};
		my $row = sprintf( '%'.$fw.'s | ', $k ). ('#' x ($v*$scale));
		push @str, $row;
	}
	return join("\n", @str );
}

my $data = { apple => 3, cherry => 2, banana => 1 };
my $str = generate_bar_graph( $data, 40, 1 );
say $str;

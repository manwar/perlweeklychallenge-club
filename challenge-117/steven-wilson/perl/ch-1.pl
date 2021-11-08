#!/usr/bin/env perl
# usage: $ ./ch-1.pl file_with_missing_row.txt

use strict;
use warnings;
use feature qw/ say /;
use List::Util qw/ sum /;

my $filename = $ARGV[0];

open(my $fh, '<', $filename)
	or die "Can't open $filename: @!";

my @row_numbers;
while (my $row = <$fh>){
	push @row_numbers, (split /,/, $row )[0]; 
}

my $sum_of_row_numbers = sum(@row_numbers);
my $sum_of_row_range = sum(1 .. (@row_numbers + 1));

my $missing_row = $sum_of_row_range - $sum_of_row_numbers;

say "The missing row number is $missing_row";

#!/usr/bin/env perl

#-- this script uses lexical variables only

use v5.36;

my @input=(
'/a/b/c/1/x.pl',
'/a/b/c/d/e/2/x.pl',
'/a/b/c/d/3/x.pl',
'/a/b/c/4/x.pl',
'/a/b/c/d/5/x.pl'
);


my sub input (@input) {
	
	my %input=();

	my $min_length=100_000_000;

	for my $row (0 .. $#input) {
		my @input = split /\//, $input[$row];
		($min_length > @input) && ($min_length = @input);
		for my $col (0 .. $#input) {
			$input{"$col,$row"} = $input[$col];
		}	
	}

	my $retval = '';

	COL: for my $col (0 .. $min_length) {
		ROW: for my $row (0 .. $#input-1) {
			unless ($input{"$col,$row"} eq $input{$col.','.($row+1)}) { 
				last COL;
			}
		}
		$retval .= $input{"$col,0"} .'/';		
	}
	$retval;
}

say &input(@input);
#/a/b/c/


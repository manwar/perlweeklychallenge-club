#!/usr/bin/env perl6

my @input=(
'/a/b/c/1/x.pl',
'/a/b/c/d/e/2/x.pl',
'/a/b/c/d/3/x.pl',
'/a/b/c/4/x.pl',
'/a/b/c/d/5/x.pl'
);


sub input(@input_) {
	
	my %input=();

	my $min_length=100_000_000;

	for (0 .. @input_.end) -> $row {
		my @input = split /\//, @input_[$row];
		($min_length > @input) && ($min_length = @input);
		for (0 .. @input.end) -> $col {
			%input{"$col,$row"} = @input[$col];
		}	
	}

	my $retval = '';

	COL: for (0 .. $min_length) -> $col {
		ROW: for (0 .. @input_.end-1) -> $row {
			unless (%input{"$col,$row"} eq %input{$col ~ ',' ~ ($row+1)}) { 
				last COL;
			}
		}
		$retval ~= %input{"$col,0"} ~ '/';		
	}
	$retval;
}

say &input(@input);
#/a/b/c/


#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-09-02
use utf8;     # Week 285 - task 1 - No connection
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

no_connection(['B', 'C'], ['D', 'B'], ['C', 'A']);
no_connection(['F', 'G'], ['G', 'H'], ['H', 'F']);
no_connection(['B', 'C'], ['A', 'A'], ['B', 'B']);

# longer example - random routes
my ($x, $y);
for (0 .. 24) {
	$x .= qq{['} . chr(int(rand(15)) + ord('A')) . qq{','} .
		chr(int(rand(15)) + ord('A')) . qq{'],}
}
$x =~ s|.$||;
no_connection(eval($x));

sub no_connection {
	
	my (@routes, $r, $input, $output, %from, %to);
	
	# create list of froms and tos where from and to are distinct
	@routes = @_;
	for $r (@routes) {
		$input .= qq{['$r->[0]', '$r->[1]'], };
		next if $r->[1] eq $r->[0]; 
		$from{$r->[0]} = 1;
		$to{$r->[1]} = 1;
	}
	
	# create list of froms and tos where from and to are distinct
	$output = '';
	for $r (@routes) {
		next if $output =~ m|'$r->[1]'|;
		$output .= qq['$r->[1]', ] unless defined $from{$r->[1]};
	}
	
	# edge case of ['X', 'X']
	for $r (@routes) {
		if ($r->[1] eq $r->[0] and not $from{$r->[1]}) {
			$output .= qq['$r->[1]', ] unless $output =~ m|'$r->[1]'|;
		}
	}
	say qq[\nInput:  \@routes = (] . substr($input, 0, -2) . ')';
	say qq[Output: ] . ($output ? substr($output, 0, -2) : 'none');
}

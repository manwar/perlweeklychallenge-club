#!/usr/bin/perl

use v5.26;    # The Weekly Challenge - 2023-12-11
use utf8;     # Week 247 task 1 - Secret santa
use strict;   # Peter Campbell Smith
use warnings; # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

secret_santa('Mr. Wall', 'Mrs. Wall', 'Mr. Anwar', 
	'Mrs. Anwar', 'Mr. Conway', 'Mr. Cross', 
	'Miss Anwar', 'Dr Anwar', 'Lord Anwar');

secret_santa('Rudolph Reindeer', 'Dasher Reindeer', 'Dancer Reindeer',
	'Prancer Reindeer', 'Vixen Reindeer','Comet Reindeer',
	'Cupid Reindeer', 'Donner Reindeer', 'Blitzen Reindeer',
	'Santa Claus', 'Mrs Claus', 'Subordinate Claus');
				 
sub secret_santa {
	
	my (%people, %recipient, $d, $r, $result, $list, $j);
	
	# initialise
	$people{$_} = int(rand(899) + 101)  for (@_);
	$list = '   ';
	
	# find someone with a different surname
	D: for $d (sort {$people{$a} <=> $people{$b}} keys %people) {
		$list .= $d . ($j ++ % 3 == 2 ? qq[,\n   ] : ', ');
		for $r (sort {$people{$b} <=> $people{$a}} keys %people) {
			next if ($d eq $r or $people{$r} == 0);
			if (surname($d) ne surname($r)) {
				$result .= qq[   $d -> $r\n];
				$people{$r} = 0;
				next D;
			}
		}
		
		# no luck, so try for wih the same one
		for $r (sort {$people{$a} <=> $people{$b}} keys %people) {
			next if ($d eq $r or $people{$r} == 0);
			$result .= qq[   $d -> $r\n];
			$people{$r} = 0;
			next D;
		}	
	}
	
	# show results
	$list =~ s|,[\n ]+$||;
	say qq[\nInput:\n$list];
	say qq[Output:\n] . substr($result, 0, -1);
}

sub surname {	
	$_[0] =~ m|([-a-zA-Z']*)$|;
	return $1;
}
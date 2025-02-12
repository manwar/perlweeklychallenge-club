#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-02-10
use utf8;     # Week 308 - task 2 - Decode xor
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

decode_xor([1, 2, 3], 1);
decode_xor([6, 2, 7, 3], 4);
decode_xor([47, 21, 33, 8], 4);

sub decode_xor {
	
	my (@e, $a, $b, $e, @result);
	
	# inputs
	@e = @{$_[0]};
	$a = $_[1];
	$result[0] = $a;
	
	# loop over values of @encoded
	for $e (@e) {
		$b = $e ^ $a;
		push @result, $b;
		$a = $b;
	}
	
	say qq[\nInput:  \@encoded = (] . join(', ', @e) . qq[), \$integer = $_[1]];
	say qq[Output: (] . join(', ', @result) . ')';
}

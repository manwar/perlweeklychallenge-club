#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-03-24
use utf8;     # Week 314 - task 2 - Sort column
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

sort_column('swpc', 'tyad', 'azbe');
sort_column('cba', 'daf', 'ghi');
sort_column('a', 'b', 'c');

sort_column('accountant', 'complexion', 'salamander', 'vegetables');
sort_column('sandwich', 'sandaich', 'sandwiah', 'sanawich');
sort_column('z', 'z', 'z', 'z');
sort_column('challenge');

sub sort_column {
	
	my (@rows, $prev, $col, $row, $this, %bad);
	@rows = @_;
	
	# loop over columns
	for $col (0 .. length($rows[0]) - 1) {
		$prev = '@';
		
		# loop over rows
		for $row (@rows) {
			$this = substr($row, $col, 1);
			
			# test for lexical order
			$bad{$col} = 1 if $this lt $prev;
			$prev = $this;
		}
	}
		
	say qq[\nInput:  \@strings = ('] . join(qq[', '], @rows) . qq[')];
	say qq[Output: ] . scalar(keys %bad);
}

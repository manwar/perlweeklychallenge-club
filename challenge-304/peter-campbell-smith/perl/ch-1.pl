#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-01-13
use utf8;     # Week 304 - task 1 - Arrange binary
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

arrange_binary ([1, 0, 0, 0, 1], 1);
arrange_binary ([1, 0, 1, 0, 1], 1);
arrange_binary ([0, 0, 1, 0, 1, 0, 0], 1);
arrange_binary ([1, 0, 0, 0, 0, 0, 0, 0, 1], 1);
arrange_binary ([0, 0, 0, 0], 1);

sub arrange_binary {
	
	my ($string, $n, $count, @ints);
	
	# initialise
	@ints = @{$_[0]};
	$n = $_[1];
	
	# join @ints as string and add 0 at each end
	$string = '0' . join('', @ints) .'0';
	
	# count possible replacements
	$count = 0;
	$count ++ while $string =~ s|000|010|;
	$string =~ s|^.(.*).$|$1|;
	
	# report result
	say qq[\nInput:  \@ints =  (] . join(', ', @ints) . qq[), \$n = $n];
	if ($count >= $n) {
		say qq[Output: true     (] . join(', ', split('', $string)) . qq[), replaced $count];
	} else {
		say qq[Output: false];
	}
}

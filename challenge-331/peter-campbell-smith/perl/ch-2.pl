#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-07-21
use utf8;     # Week 331 - task 2 - Buddy strings
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

buddy_strings('luck', 'lcuk');
buddy_strings('love', 'love');
buddy_strings('feed', 'feed');
buddy_strings('enchilada', 'anchilade');
buddy_strings('3 blind mice', '3 clind mibe');
buddy_strings('12345', '12435');

sub buddy_strings {
	
	my ($one, $two, $length, $result, $j, $char1, $char2, $mismatch, %seen);
	
	# initialise
	($one, $two) = @_;
	
	# loop over corresponding chars in each string
	$length = length($one);
	$result = 'false';
	if ($length == length($two)) {
		for $j (0 .. $length - 1) {
			$char1 = substr($one, $j, 1);
			$char2 = substr($two, $j, 1);
			
			# swapped chars must be letters
			next unless ($char1 . $char2) =~ m|[a-z]{2}|i;
			
			# if they differ
			if ($char1 ne $char2) {
				
				# this is the first mismatch, so save it
				unless (defined $mismatch) {
					$mismatch = $j;
					
				# this is the second mismatch, so can it swap with the first?
				} elsif ($result eq 'false') {
					if ($char1 eq substr($two, $mismatch, 1) and $char2 eq substr($one, $mismatch, 1)) {
						$result = qq[true - '$char1' and '$char2'];
					}
				
				# this is a 3rd mismatch so not buddies
				} else {
					$result = 'false';
					last;
				}	
			}
		}
		
		# check for identical strings with (any) repeated letter
		if ($one eq $two) {
			for $j (0 .. $length - 1) {
				$char1 = substr($one, $j, 1);
				if ($seen{$char1}) {
					$result = qq[true - '$char1' and '$char1'];
					last;
				}
				$seen{$char1} = 1 if $char1 =~ m|[a-z]|;
			}
		}
	}
		
	say qq[\nInput:  \$source = '$one', \$target = '$two'];
	say qq[Output: $result];
}

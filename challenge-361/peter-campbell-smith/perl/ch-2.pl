#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2026-02-16
use utf8;     # Week 361 - task 2 - Find celebrity
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

find_celebrity([[0, 0, 0, 0, 1, 0],
                [0, 0, 0, 0, 1, 0],
                [0, 0, 0, 0, 1, 0],
                [0, 0, 0, 0, 1, 0],
                [0, 0, 0, 0, 0, 0],
                [0, 0, 0, 0, 1, 0]]);
find_celebrity([[0, 1, 0, 0],
                [0, 0, 1, 0],
                [0, 0, 0, 1],
                [1, 0, 0, 0]]);
find_celebrity([[0, 1, 0, 1, 0, 1],
                [1, 0, 1, 1, 0, 0],
                [0, 0, 0, 1, 1, 0],
                [0, 0, 0, 0, 0, 0],
                [0, 1, 0, 1, 0, 0],
                [1, 0, 1, 1, 0, 0]]);

sub find_celebrity {
	
	my ($matrix, $party, $person, $celeb, $knows, $known_by);
	
	# initialise
	$matrix = $_[0];
	$party = @$matrix;
	
	# loop over guests
	P: for $person (0 .. $party - 1) {
		$celeb = $person;
		
		# who do they know?
		for $knows (0 .. $party - 1) {
	
			# not a celeb if they know someone
			next if $person == $knows;
			if ($matrix->[$person]->[$knows]) {
				$celeb = -1;
				next P;
			}
		}
			
		# who knows them?
		for $known_by (0 .. $party - 1) {
			
			# not a celeb if the aren't known by someone
			next if $person == $known_by;
			unless ($matrix->[$known_by]->[$person]) {
				$celeb = -1;
				next P;
			}			
		}
		
		# found one!
		last if $celeb > 0;
	}
	
	say ''; print_matrix(qq[Input: ], $matrix);
	say qq[Output: ] . ($celeb >= 0 ? qq[person $celeb] : 'nobody') . q[ is a celebrity];
}

sub print_matrix {
	
	my ($legend, $matrix, $j);

	# format matrix
	($legend, $matrix) = @_;
	for $j (0 .. @$matrix - 1) {
		print qq{$legend [} . join(', ', @{$matrix->[$j]}) . qq(]);
		say $j == @$matrix - 1 ? '' : ', ';
		$legend = ' ' x length($legend);
	}
}
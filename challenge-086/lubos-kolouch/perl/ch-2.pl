#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-2.pl
#
#        USAGE: ./ch-2.pl  
#
#  DESCRIPTION: Perl Weekly Challenge 086
#  				Task 2
#  				Sudoku Puzzle	
#
#  				Uses backtrack algorithm
#
#       AUTHOR: Lubos Kolouch
#      CREATED: 11/15/2020 01:27:06 PM
#===============================================================================

use strict;
use warnings;
use Storable qw/dclone/; # for deep copy of the puzzle...

sub load_puzzle {
	# load the puzzle from the input
	
	my $data = shift;
	
	my @puzzle;
	my $i=0;
	for (@$data) {
		
		my $j = 0;
		for (split(' ', @$data[$i])) {
			if ($_ eq  '_') {
				$puzzle[$i][$j] = 0 ;
			} else {
				$puzzle[$i][$j] = $_ + 0;
			}
			$j++;
		}
		$i++;
	}

	return \@puzzle;
}

sub get_valid_options {
	# eliminate numbers 1-9 that are already taken
	
	my $param = shift;

	my %valid_options;

	$valid_options{$_} = 1 for (1..9);

	# eliminate already taken numbers
	for (0..8) {
		next unless $param->{puzzle}[ $param->{row} ][$_];
		delete $valid_options{ $param->{puzzle}[ $param->{row} ][$_]};
	}

	for (0..8) {
		next unless $param->{puzzle}[ $_ ][ $param->{col}];
		delete $valid_options{ $param->{puzzle}[ $_ ][$param->{col}]};
	}

	return unless keys %valid_options;

	# eliminate quadrant
	
	my $row_q = int($param->{row} / 3);
	my $col_q = int($param->{col} / 3);

	for my $row (0..2) {
		for my $col (0..2) {
			my $row_pos = $row_q * 3 + $row;
			my $col_pos = $col_q * 3 + $col;

			delete $valid_options{ $param->{puzzle}[$row_pos][$col_pos] } if $param->{puzzle}[$row_pos][$col_pos];

		}
	}
	return unless keys %valid_options;
	return \%valid_options;

}

sub is_complete {
	my $puzzle = shift;

	for my $i (0..scalar @$puzzle -1) {
		for my $j (0..scalar @$puzzle -1) {
			return unless $$puzzle[$i][$j];
		}
	}

	return 1;
}
sub solve_position {
	# backtrack recursively to find the solution

	my $puzzle = shift;

	# i was struggling to get a deep copy of the ref-ed array, so...
	my $next_puzzle = dclone( $puzzle );
	
	for my $row (0..scalar @$next_puzzle -1) {
		for my $col (0..scalar @$next_puzzle -1) {
			
			# find the next empty position
			next if $$next_puzzle[$row][$col];
	
			my $valid_options = get_valid_options( { puzzle => $next_puzzle, row => $row, col => $col } );

			unless (keys %$valid_options) {
				# nothing left to try, check if the solution is complete

				return unless is_complete($next_puzzle);


				return $next_puzzle;
			}
			
			my @hash_keys = keys %$valid_options;

			# iterate through the candidate numbers

			for my $next_key (@hash_keys) {
				$$next_puzzle[$row][$col] = $next_key;

				my $next_iteration = solve_position($next_puzzle);
				return $next_iteration if $next_iteration;
			}
		}

	}
	# great, we could fill all empty positions!
	return $next_puzzle;

}

sub print_puzzle {
	my $puzzle = shift;

	for my $row (0..scalar @$puzzle -1) {
		for my $col (0..scalar @$puzzle -1) {
			print $$puzzle[$row][$col]." ";
		}
		print "\n";
	}
	print "\n";
}

sub solve_sudoku {
    my $data = shift;

	my $puzzle = load_puzzle($data);

	my $position;

	$position = solve_position($puzzle);
	print_puzzle($position);

    return $position;
}

use Test::More;

is_deeply(solve_sudoku( [
'_ _ _ 2 6 _ 7 _ 1', 
'6 8 _ _ 7 _ _ 9 _',
'1 9 _ _ _ 4 5 _ _',
'8 2 _ 1 _ _ _ 4 _',
'_ _ 4 6 _ 2 9 _ _',
'_ 5 _ _ _ 3 _ 2 8',
'_ _ 9 3 _ _ _ 7 4',
'_ 4 _ _ 5 _ _ 3 6',
'7 _ 3 _ 1 8 _ _ _' ] ), 

[ 
[4,3,5,2,6,9,7,8,1],
[6,8,2,5,7,1,4,9,3],
[1,9,7,8,3,4,5,6,2],
[8,2,6,1,9,5,3,4,7],
[3,7,4,6,8,2,9,1,5],
[9,5,1,7,4,3,6,2,8],
[5,1,9,3,2,6,8,7,4],
[2,4,8,9,5,7,1,3,6],
[7,6,3,4,1,8,2,5,9],
]
);

done_testing;


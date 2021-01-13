#!/usr/bin/perl
# Test: ./ch-1.pl
use Modern::Perl;
use Algorithm::Combinatorics qw(combinations);

my $m1 = [ [1, 0, 1],
           [1, 1, 1],
           [1, 1, 1], ];

my $m2 = [ [1, 0, 1],
           [1, 1, 1],
           [1, 0, 1], ];

for my $m ($m1, $m2) {
	say "Input:";
	print_matrix($m);

	say "Output:";
	print_matrix(zero($m));
}

# Zero our columns and rows
sub zero {
	my $m = shift;

	# Lengths of the matrix
	my $l1 = scalar(@$m);
	my $l2 = scalar(@{$m->[0]});

	# Initialize new matrix
	my $m2 = [];
	for (my $i = 0; $i < $l1; $i++) {
		$m2->[$i] = [];
		for (my $j = 0; $j < $l2; $j++) {
			$m2->[$i][$j] = 1;
		}
	}

	# Process each element of the matrix
	for (my $i = 0; $i < $l1; $i++) {
		for (my $j = 0; $j < $l2; $j++) {
			if ($m->[$i][$j] == 0) {
				# zero our rows
				$m2->[$i][$_] = 0
					for (0 .. $l2- 1 );

				# zero our cols
				$m2->[$_][$j] = 0 #
					for (0 .. $l1 - 1)
			}
		}
	}

	# Return new matrix
	return $m2;
}

# Print the matrix
sub print_matrix {
	my $m = shift;
	my $l1 = scalar(@$m);
	my $l2 = scalar(@{$m->[0]});

	# Process each element of the matrix
	for (my $i = 0; $i < $l1; $i++) {
		print '[ ';
		for (my $j = 0; $j < $l2; $j++) {
			printf ('%3s', $m->[$i][$j]);
		}
		say ' ]';
	}

	say '';
}

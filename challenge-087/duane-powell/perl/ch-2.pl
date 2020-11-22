#!/usr/bin/perl
use warnings;
use strict;
use feature 'say';

=pod

=head1 DESCRIPTION

 Problem: https://perlweeklychallenge.org/blog/perl-weekly-challenge-087/ TASK #2A
 You are given matrix m x n with 0 and 1.
 Write a script to find the largest rectangle containing only 1. Print 0 if none found.

 Solution: From each point in the matrix radiate out until we hit a rectangle boundary.
 Then verify all points within the boundary are equal to 1. Remember largest.  

 The verts in our rectangle will be represented as posiitve (x,y) coordinates.
 (a,b) = lower left and (c,d) = upper right

 |           (c,d) = (m-1,n-1)
 |
 |
 |
 | (a,b) = (0,0)

 Initially (a,b) = (0,0) and (c,d) = the user supplied (m-1,n-1) 
=cut

# user supplied dimensions
my ($m, $n) = @ARGV;

# Default to 6 x 6 matrix if dimension not supplied
# We are zero indexed, so deduct 1 from matrix dimensions
$m ||= 6; $m--;
$n ||= 6; $n--;

sub matrix_init {
	my $value = shift; # init a matrix of size (c,d) and set values to $value or random
	my ($c, $d) = @_;

	my $matrix_ref = [];
        for my $y (0 .. $d) {
                for my $x (0 .. $c) {
			$matrix_ref->[$x][$y] = ($value eq 'rand') ? ((rand() < 0.5) ? 1 : 0) : $value;
                }
        }
	return $matrix_ref;
}
sub matrix_print {
	my $matrix_ref = shift;
	my ($a, $b, $c, $d) = @_; # print section of matrix from (a,b) to (c,d)

	my $out; # output string
	my @x = reverse ($a .. $c); 
	for my $x (@x) {
		$out .= "\t[ ";
		foreach my $y ($b .. $d ) {
			$out .= $matrix_ref->[$x][$y] . " ";
		}
		$out .= "]\n";
	}
	say $out;
}
sub matrix_is_all_ones {
	my $matrix_ref = shift;
	my ($a, $b, $c, $d) = @_;

	my $area = 0;
	foreach my $y ($b .. $d) {
		for my $x ($a .. $c) {
			return 0 if ($matrix_ref->[$x][$y] == 0);
			$area++;
		}
	}
	return $area; # return the area of the matrix if it's all 1's
}	
sub matrix_get_rectangle {
	my $matrix_ref = shift;
	my ($a, $b, $c, $d) = @_;

	my ($x, $y) = ($a, $b);
	my ($y_ok, $x_ok) = (1, 1);

	# expand along x and y until we hit 0 or boundary
	until ($x+1 > $c or $matrix_ref->[$x+1][$y] == 0) {
		$x++;
	}
	until ($y+1 > $d or $matrix_ref->[$x][$y+1] == 0) {
		$y++;
	}

	my $area = matrix_is_all_ones($matrix_ref, $a, $b, $x, $y);
	if ($area) {
		return ($area, $a, $b, $x, $y);
	}
	else {
		# area was not filled with only 1's so collapse along longest edge and try again
		if (($y - $b) > ($x - $a)) {
			$y_ok = ($y - $b);
			$x_ok = 0;
		}
		else {
			$x_ok = ($x - $a);
			$y_ok = 0;
		}
	}
	while ($area == 0 and ($x_ok > 0 or $y_ok > 0)) {
		if ($x_ok) {
			$area = matrix_is_all_ones($matrix_ref, $a, $b, $x_ok, $y);
			return ($area, $a, $b, $x_ok, $y) if ($area);
			$x_ok--;
		}
		else {
			$area = matrix_is_all_ones($matrix_ref, $a, $b, $x, $y_ok);
			return ($area, $a, $b, $x, $y_ok) if ($area);
			$y_ok--;
		}
	}
	return (0,0,0,0,0); # will never get here
}

sub matrix_solve {
	my $matrix = shift;

	# determine dimensions of this matrix
	my $m = scalar( @{$matrix} )-1;
	my $n = scalar( @{$matrix->[0]} )-1;

	say "\nInput:";
	matrix_print($matrix, 0, 0, $m, $n);

	my $max_area = 0;
	my @solution = ();
	for my $y (0 .. $n) {
		for my $x (0 .. $m) {
			if ($matrix->[$x][$y] == 1) { # see if this vert is part of a larger rectangle
				my ($area, @coord) = matrix_get_rectangle($matrix, $x, $y, $m, $n);
				if ($area > $max_area) {
					# Note: winner goes to first rectangle found if two rectangles tie
					$max_area = $area;
					@solution = @coord;
				}
			}
		}
	}

	if ($max_area < 2) {
		say "Output: 0";
	} 
	else {
		say "Output: $max_area";
		matrix_print($matrix, @solution);
	}
}

# solve for examples
foreach (1 .. 5) {
	my $matrix = matrix_get($_);
	matrix_solve($matrix);
}
# solve for random
foreach (1 .. 3) {
	# populate maxtrix with coin tosses
	my $matrix = matrix_init('rand',$m,$n);
	matrix_solve($matrix);
}
exit;

sub matrix_get {
	# a utility sub so we can cut and paste interesting matrices
	my $matrix_id = shift || 1;
	my $mat;
	if ($matrix_id == 1) {
		$mat = <<'EOF_MATRIX';
[ 0 0 0 1 0 0 ]
[ 1 1 1 0 0 0 ]
[ 0 0 1 0 0 1 ]
[ 1 1 1 1 1 0 ]
[ 1 1 1 1 1 0 ]
EOF_MATRIX
	}
	if ($matrix_id == 2) {
		$mat = <<'EOF_MATRIX';
[ 1 0 1 0 1 0 ]
[ 0 1 0 1 0 1 ]
[ 1 0 1 0 1 0 ]
[ 0 1 0 1 0 1 ]
EOF_MATRIX
	}
	if ($matrix_id == 3) {
		$mat = <<'EOF_MATRIX';
[ 0 0 0 1 1 1 ]
[ 1 1 1 1 1 1 ]
[ 0 0 1 0 0 1 ]
[ 0 0 1 1 1 1 ]
[ 0 0 1 1 1 1 ]
EOF_MATRIX
	}
	if ($matrix_id == 4) {
		# test matrix of 3 overlapping rectangles of size 8, 9, 10. 
		$mat = <<'EOF_MATRIX';
[ 1 1 1 1 0 1 ]
[ 1 1 1 1 0 1 ]
[ 0 0 1 1 1 0 ]
[ 0 0 1 1 1 0 ]
[ 1 0 1 1 1 0 ]
[ 1 0 0 0 0 0 ]
EOF_MATRIX
	}
	if ($matrix_id == 5) {
		$mat = <<'EOF_MATRIX';
[ 1 1 1 1 ]
[ 1 0 1 1 ]
[ 1 1 1 1 ]
[ 1 1 0 1 ]
[ 1 1 1 1 ]
EOF_MATRIX
	}
	if ($matrix_id == 9) {
		$mat = <<'EOF_MATRIX';
[ A B C D ]
[ E F G H ]
[ I J K L ]
[ M N O P ]
EOF_MATRIX
	}
	my $matrix_ref = [];
	$mat =~ s/\[//g;
	$mat =~ s/\]//g;
	$mat =~ s/ //g;
	my @rows = split(/\n/,$mat);
	foreach (@rows) {
		my @cols = split(//, $_);
		unshift @{$matrix_ref}, [@cols];
	}
	return $matrix_ref;
}

__END__

./ch-2.pl

Input:
        [ 0 0 0 1 0 0 ]
        [ 1 1 1 0 0 0 ]
        [ 0 0 1 0 0 1 ]
        [ 1 1 1 1 1 0 ]
        [ 1 1 1 1 1 0 ]

Output: 10
        [ 1 1 1 1 1 ]
        [ 1 1 1 1 1 ]


Input:
        [ 1 0 1 0 1 0 ]
        [ 0 1 0 1 0 1 ]
        [ 1 0 1 0 1 0 ]
        [ 0 1 0 1 0 1 ]

Output: 0

Input:
        [ 0 0 0 1 1 1 ]
        [ 1 1 1 1 1 1 ]
        [ 0 0 1 0 0 1 ]
        [ 0 0 1 1 1 1 ]
        [ 0 0 1 1 1 1 ]

Output: 8
        [ 1 1 1 1 ]
        [ 1 1 1 1 ]


Input:
        [ 1 1 1 1 0 1 ]
        [ 1 1 1 1 0 1 ]
        [ 0 0 1 1 1 0 ]
        [ 0 0 1 1 1 0 ]
        [ 1 0 1 1 1 0 ]
        [ 1 0 0 0 0 0 ]

Output: 10
        [ 1 1 ]
        [ 1 1 ]
        [ 1 1 ]
        [ 1 1 ]
        [ 1 1 ]


Input:
        [ 0 1 0 0 1 0 ]
        [ 0 0 0 0 0 1 ]
        [ 0 0 1 0 1 0 ]
        [ 1 1 1 1 1 1 ]
        [ 0 0 1 0 1 0 ]
        [ 1 0 1 0 1 0 ]

Output: 6
        [ 1 1 1 1 1 1 ]


Input:
        [ 1 1 0 1 0 1 ]
        [ 0 0 1 1 0 1 ]
        [ 1 1 1 1 0 0 ]
        [ 0 1 0 1 0 1 ]
        [ 0 1 0 1 0 0 ]
        [ 1 0 0 1 0 0 ]

Output: 6
        [ 1 ]
        [ 1 ]
        [ 1 ]
        [ 1 ]
        [ 1 ]
        [ 1 ]


Input:
        [ 1 1 1 1 1 1 ]
        [ 1 1 1 1 1 1 ]
        [ 1 1 0 0 0 1 ]
        [ 0 0 1 1 0 0 ]
        [ 1 0 1 1 0 1 ]
        [ 0 0 1 0 0 0 ]

Output: 12
        [ 1 1 1 1 1 1 ]
        [ 1 1 1 1 1 1 ]



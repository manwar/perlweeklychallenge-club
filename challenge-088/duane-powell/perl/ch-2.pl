#!/usr/bin/perl
use warnings;
use strict;
use feature 'say';

=pod

=head1 DESCRIPTION

 Problem: https://perlweeklychallenge.org/blog/perl-weekly-challenge-088/ TASK #2
 You are given m x n matrix of positive integers.
 Write a script to print spiral matrix as list.

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
			$matrix_ref->[$y][$x] = ($value eq 'rand') ? int(rand(99)) + 1 : $value;
                }
        }
	return $matrix_ref;
}
sub matrix_print {
	my $matrix = shift;

        # determine dimensions of this matrix
	my ($a, $b, $c, $d) = (0, 0, scalar( @{$matrix} )-1, scalar( @{$matrix->[0]} )-1);

	my $out; # output string
	my @y = reverse ($b .. $d); 
	for my $y (@y) {
		$out .= "\t[ ";
		foreach my $x ($a .. $c) {
			my $o = $matrix->[$y][$x] . ", ";
			$o = ' ' x ( 4 - length( $o ) ) . $o;
			$out .= $o;
		}
		$out .= "]\n";
	}
	say $out;
}
sub matrix_get {
	my $matrix_id = shift || 1;

	# a utility sub so we can cut and paste interesting matrices
	my $mat;
	if ($matrix_id == 1) {
		$mat = <<'EOF_MATRIX';
[ 1, 2, 3 ]
[ 4, 5, 6 ]
[ 7, 8, 9 ]
EOF_MATRIX
	}
	if ($matrix_id == 2) {
		$mat = <<'EOF_MATRIX';
[  1,  2,  3,  4 ]
[  5,  6,  7,  8 ]
[  9, 10, 11, 12 ]
[ 13, 14, 15, 16 ]
EOF_MATRIX
	}
	if ($matrix_id == 3) {
		$mat = <<'EOF_MATRIX';
[ P, E, R, L ]
[ E, D, A, R ]
[ H, !, Y, U ]
[ T, S, E, L ]
EOF_MATRIX
	}
	my $matrix_ref = [];
	$mat =~ s/\[//g;
	$mat =~ s/\]//g;
	$mat =~ s/ //g;
	my @rows = (split(/\n/,$mat));
	foreach (@rows) {
		my @cols = (split(/,/, $_));	
		unshift @{$matrix_ref}, [@cols];
	}
	return $matrix_ref;
}
sub matrix_spiral {
	my $matrix = shift;

	# Spiral around the matrix by traversing: east, south, west and then north.
	# We will contract the bounding box when we turn north.
        # Determine dimensions of this matrix and its bounding box.
	my ($a, $b, $c, $d) = (0, 0, scalar( @{$matrix} )-1, scalar( @{$matrix->[0]} )-1);

	my $out; # printed output
	my $element_max = ($c + 1) * ($d + 1); # total possible element of the spiral
	my $element_count = 0;

	# (x,y) are the current element.
	# Start traversing from just outside the matrix at north-west corner (-1, d+1)
	my ($x, $y) = (-1, $d+1); 
	LAST: while (1) {
		# traverse east
		($x, $y) = ($x+1, $y-1); # (x,y) = (0,d) if this is the very first element
		while ($x <= $c) {
			$out .= $matrix->[$y][$x] . ",";
			last LAST if (++$element_count == $element_max);
			$x++;
		}
		# traverse south
		($x, $y) = ($c, $y-1);
		while ($y >= $b) {
			$out .= $matrix->[$y][$x] . ",";
			last LAST if (++$element_count == $element_max);
			$y--;
		}
		# traverse west
		($x, $y) = ($x-1, $y+1);
		while ($x >= $a) {
			$out .= $matrix->[$y][$x] . ",";
			last LAST if (++$element_count == $element_max);
			$x--;
		}

		# tighten the spiral's bounding box 
		$a++; $b++, $c--; $d--; 

		# traverse north
		($x, $y) = ($x+1, $y+1);
		while ($y <= $d) {
			$out .= $matrix->[$y][$x] . ",";
			last LAST if (++$element_count == $element_max);
			$y++;
		}
	}
	$out = join(', ',split(/,/,$out));
	say "\t[$out]";
}

my $matrix;
foreach (1 .. 3) {
	$matrix = matrix_get($_);
	say "\n\nInput:";
	matrix_print($matrix);
	say "Output:";
	matrix_spiral($matrix);
}

$matrix = matrix_init('rand', $m, $n);
	say "\n\nInput:";
	matrix_print($matrix);
	say "Output:";
	matrix_spiral($matrix);

__END__

./ch-2.pl


Input:
        [  1,  2,  3, ]
        [  4,  5,  6, ]
        [  7,  8,  9, ]

Output:
        [1, 2, 3, 6, 9, 8, 7, 4, 5]


Input:
        [  1,  2,  3,  4, ]
        [  5,  6,  7,  8, ]
        [  9, 10, 11, 12, ]
        [ 13, 14, 15, 16, ]

Output:
        [1, 2, 3, 4, 8, 12, 16, 15, 14, 13, 9, 5, 6, 7, 11, 10]


Input:
        [  P,  E,  R,  L, ]
        [  E,  D,  A,  R, ]
        [  H,  !,  Y,  U, ]
        [  T,  S,  E,  L, ]

Output:
        [P, E, R, L, R, U, L, E, S, T, H, E, D, A, Y, !]


Input:
        [ 91,  3, 38, 80, 14, 58, ]
        [ 96, 78, 18, 87, 64, 85, ]
        [ 88, 50, 61, 59, 67, 89, ]
        [ 16, 46, 34,  1, 77, 80, ]
        [  6, 14, 82, 71, 73,  3, ]
        [ 10, 75, 60, 81, 78, 52, ]

Output:
        [91, 3, 38, 80, 14, 58, 85, 89, 80, 3, 52, 78, 81, 60, 75, 10, 6, 16, 88, 96, 78, 18, 87, 64, 67, 77, 73, 71, 82, 14, 46, 50, 61, 59, 1, 34]

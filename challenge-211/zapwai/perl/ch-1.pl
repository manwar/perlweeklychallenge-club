use v5.30.0;
my @matrix = ( [4, 3, 2, 1],
	       [5, 4, 3, 2],
	       [6, 5, 4, 3], );
# my @matrix = ( [1, 2, 3],
#                    [3, 2, 1],
#                  );
my $m = $#matrix + 1;
my $n = $#{$matrix[0]} + 1;
say "Input: \@matrix is";
for my $i (0 .. $m - 1) {
    print " ";
    for my $j (0 .. $n - 1) {
	print $matrix[$i][$j];
    }
    print "\n";
}
my $flag = 1;
for my $i (0 .. $m - 2) {
    if ($i == 0) {
	for my $j (0 .. $n - 2) {
	    $flag = 0 unless (const_diag($i,$j));
	}
    } else {
	$flag = 0 unless (const_diag($i,0));	
    }
}
print "\nOutput: ";
if ($flag) {
    say "True, the matrix is Toeplitz.";
} else {
    say "False, the matrix is not Toeplitz.";
}
sub const_diag {
    my ($i,$j) = @_;
    my $val = $matrix[$i][$j];
    for my $s ($i .. $m - 1) {
	last if (!defined $matrix[$s][$j]);
	return 0 unless ($matrix[$s][$j] == $val);
	$j++;
    }
    1
}

# Test: perl6 ch-1.p6
sub MAIN() {
    my @path;
    my @matrix = [
    	[ 1, 2, 3 ],
    	[ 4, 5, 6 ],
    	[ 7, 8, 9 ],
    ];

    say min-path(@matrix, 0, 0, @path)
        ~ ': ' ~ @path.join(" → ");
}

# Calculate the max path
sub min-path(@matrix, Int $m, Int $n, @path) {

    # Size of matrix
    my $max_m = @matrix[0].elems;
    my $max_n = @matrix.elems;

    # Out of bounds
    return Nil
    	if ($m >= $max_m || $n >= $max_n);

    # Points in the branch
    my $total = @matrix[$m][$n];

    # Calculate path
    @path.push($total);
    my @path1 = @path.map({ $_ });
    my @path2 = @path.map({ $_ });

    # Points produced by each branch
    my $score1 = min-path(@matrix, $m + 1, $n, @path1);
    my $score2 = min-path(@matrix, $m, $n + 1, @path2);

    # Return the better branch
    if ( ($score1 && $score2 && $score1 <= $score2) ||
         ($score1 && !$score2) ) {
    	@path = @path1.map({ $_ });
    	return $total + $score1;
    } elsif ( ($score1 && $score2 && $score1 > $score2) ||
              (!$score1 && $score2) ) {
    	@path = @path2.map({ $_ });
    	return $total + $score2;
    } else {
    	return $total;
    }
}

#!/usr/bin/perl
# Test: ./ch-1.pl
use strict;
use warnings;
use feature qw /say/;

my @path;
my $matrix = [
    [ 1, 2, 3 ],
    [ 4, 5, 6 ],
    [ 7, 8, 9 ],
];

say min_path($matrix, 0, 0, \@path)
    . ": " . (join ' → ', @path);

# Calculate the max path
sub min_path {
    my ($matrix, $m, $n, $path) = @_;

    # Size of matrix
    my $max_m = scalar(@{$matrix->[0]});
    my $max_n = scalar(@{$matrix});

    # Out of bounds
    return undef
    	if ($m >= $max_m || $n >= $max_n);

    # Points in the branch
    my $total = $matrix->[$m][$n];

    # Calculate path
    push @$path, $total;
    my @path1 = map { $_ } @$path;
    my @path2 = map { $_ } @$path;

    # Points produced by each branch
    my $score1 = min_path($matrix, $m + 1, $n, \@path1);
    my $score2 = min_path($matrix, $m, $n + 1, \@path2);

    # Return the better branch
    if ( ($score1 && $score2 && $score1 <= $score2) ||
         ($score1 && !$score2) ) {
    	@$path = map { $_ } @path1;
    	return $total + $score1;
    } elsif ( ($score1 && $score2 && $score1 > $score2) ||
              (!$score1 && $score2) ) {
    	@$path = map { $_ } @path2;
    	return $total + $score2;
    } else {
    	return $total;
    }
}

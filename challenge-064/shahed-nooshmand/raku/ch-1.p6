#!/usr/bin/env raku

my @matrix = [1, 2, 3],
             [4, 5, 6],
             [7, 8, 9];
say "{.sum} ({.join: ' → '})" given min paths(@matrix, 0, 0), by => &sum;


sub paths(@matrix, $i, $j) {
    my @paths;
    my $pivot = @matrix[$i][$j];
    my $right = @matrix[$i][$j+1];
    my $down  = @matrix[$i+1][$j];

    with $right {
    	@paths.push: |paths(@matrix, $i, $j + 1).map: { $pivot, |$_ }
    }
    with $down {
    	@paths.push: |paths(@matrix, $i + 1, $j).map: { $pivot, |$_ }
    }
    without $right // $down {
    	return $pivot
    }

    return @paths
}

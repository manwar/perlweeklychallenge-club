# Task 2 of the Weekly Challenge 334
# https://theweeklychallenge.org/blog/perl-weekly-challenge-334/#TASK2

output(solve([[1, 2], [3, 1], [2, 4], [2, 3]], [3, 4])); # 2
output(solve([[3, 4], [2, 3], [1, 5], [2, 5]], [2, 5])); # 3
output(solve([[2, 2], [3, 3], [4, 4]],         [1, 1])); # -1
output(solve([[0, 1], [1, 0], [0, 2], [2, 0]], [0, 0])); # 0
output(solve([[5, 6], [6, 5], [5, 4], [4, 5]], [5, 5])); # 0


sub output($point) {
    say 'Result: ', $point, "\n";
}

sub solve(@points, $point) {
    say 'Input points: ', @points, ', reference point: ', $point;

    my ($x, $y) = $point[0..1];

    my @valid;
    for @points.kv -> $i, $p {
        next if $p[0] != $x && $p[1] != $y;
        # found a valid point

        my $distance = abs($p[0] - $x) + abs($p[1] - $y);
        push @valid, {
            index => $i,
            point => $p, 
            distance => $distance,
        };
    }

    say 'Valid points: ', @valid;

    return -1 unless @valid;

    my $min_distance = (@valid.map: *<distance>).min;
    say "Minimum distance: $min_distance";

    my @valid_with_min_distance = @valid.grep: *<distance> == $min_distance;
    say 'Points with minimum distance: ', @valid_with_min_distance;
    return @valid_with_min_distance[0]<index> if @valid_with_min_distance.elems == 1;

    my $min_index = (@valid_with_min_distance.map: *<index>).min;
    say "Minimum index: $min_index";
    return (@valid_with_min_distance.grep: *<index> == $min_index)[0]<index>;
}

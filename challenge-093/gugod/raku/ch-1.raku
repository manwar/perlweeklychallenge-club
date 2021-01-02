
sub MAIN {
    say max-points ((1,1), (2,2), (3,3));
    say max-points ((3,3), (1,1), (2,2));
    say max-points ((1,1), (2,2), (3,1), (1,3), (5,3));
    say max-points ((3,1), (1,3), (5,3), (4,4), (5,5), (1,1), (2,2));
}

sub slope ($p1, $p2) {
    my $dx = $p2[0] - $p1[0];
    my $dy = $p2[1] - $p1[1];
    return $dx == 0 ?? Inf !! ($dy / $dx);
}

sub max-points( @points ) {
    my %lines;

    for @points.combinations(3) -> ($pi, $pj, $pk) {
        %lines{"$pi - $pj"} //= [$pi, $pj];
        my $slope_ij = slope($pi, $pj);
        my $slope_jk = slope($pj, $pk);

        # (Inf == Inf) == True
        if $slope_ij == $slope_jk {
            %lines{"$pi - $pj"}.push($pk);
        }
    }

    my $maxline = %lines.pairs.max({ .value.elems });

    say "# Points: { @points.gist }";
    say "    line with maximum number of poionts: " ~ $maxline.value.gist;
    say "";

    return $maxline.value.elems;
}

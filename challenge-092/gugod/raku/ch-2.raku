sub MAIN {

    my @cases = (
        (((1,4), (8,10)),        (2,6)),
        (((1,2), (3,7), (8,10)), (5,8)),
        (((1,5), (7,9)),         (10,11)),
        (((1,2), (3,7), (8,10)), (2,8)),
    );

    for @cases -> $it {
        my $S = $it[0];
        my $N = $it[1];
        my $S2 = insert-intervals($S, $N);
        say $S2.gist ~ " <- " ~ $S.gist ~ " (+) " ~ $N.gist;
    }
}

sub insert-intervals (@S is copy, $N) {
    my $i = @S.first(-> $s { $s[0] <= $N[0] <= $s[1] }, :k);
    my $j = @S.first(-> $s { $s[0] <= $N[1] <= $s[1] }, :k);

    if $i.defined {
        @S[$i] = (@S[$i][0], max(@S[$i][1], $N[1]));
    }

    if $j.defined {
        @S[$j] = (@S[$j][0], max(@S[$j][1], $N[1]));

        if $i.defined and @S[$i][0] <= @S[$j][0] <= @S[$i][1] {
            @S[$i] = (@S[$i][0], @S[$j][1]);

            for $i^..$j -> $x {
                @S[$x] = Nil;
            }
        }
    }

    if none($i.defined, $j.defined) {
        @S.push($N);
        @S = @S.sort({ $^a[0] <=> $^b[0] });
    }

    return @S.grep({ .defined });
}

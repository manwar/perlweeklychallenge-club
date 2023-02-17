sub reshape (@matrix, $r, $c) {
    my @result;
    my $rows = @matrix.elems;
    my $cols = @matrix[0].elems;
    return 0 if $r * $c != $rows * $cols;
    my @flattened = | @matrix.map({| $_ });
    for 0..^$r -> $i {
        push @result, @flattened[$i*$c .. $i*$c + $c -1 ]
    }
    return @result;
}
sub display-result (@mat, $rc) {
    say @mat.gist.fmt("%-18s - "), "$rc => ",
        reshape(@mat, | $rc);
}

my @test = ((1, 2), (3, 4));
for <1 4>, <4 1>, <2 2>, <3 4> -> $rc {
    display-result @test, $rc;
}
@test = ((1, 2, 3), (4, 5, 6));
for <3 2>, <2 3>, <1 6>, <6 1>, <6 3> -> $rc {
    display-result @test, $rc;
}

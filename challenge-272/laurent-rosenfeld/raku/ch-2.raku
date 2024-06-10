sub string-score ($in) {
    my $result = 0;
    my @let = $in.comb;
    for 1 .. @let.end -> $i {
        $result += (@let[$i].ord - @let[$i - 1].ord).abs;
    }
    return $result;
}
for <hello perl raku> -> $test {
    printf "%-8s => ", $test;
    say string-score $test;
}

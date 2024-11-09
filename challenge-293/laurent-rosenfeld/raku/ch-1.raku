sub sort-dom ($dom) {
    my ($a, $b) = $dom.comb;
    return $a < $b ?? "$a$b" !! "$b$a";
}

sub similar-dom (@doms) {
    my $histo = bag map { sort-dom $_ }, @doms;
    my $count = 0;
    $count += $_ for grep { $_ > 1 }, $histo.values;
    return $count;
}

my @tests = <13 31 24 68>, <12 21 11 12 22>, <31 24 13 56 24>;
for @tests -> @test {
    printf "%-15s => ", "@test[]";
    say similar-dom @test;
}

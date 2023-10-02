sub special-note ($source, $target) {
    my $chars = $source.comb.Bag;
    return $target.comb.Bag ⊆ $chars;
}

for ("abc", "xyz"), ("scriptinglanguage", "perl"),
        ("aabbcc", "abc") -> @test {
    printf "%-20s - %-7s => ", "@test[0]", "@test[1]";
    say special-note  @test[0], @test[1];
}

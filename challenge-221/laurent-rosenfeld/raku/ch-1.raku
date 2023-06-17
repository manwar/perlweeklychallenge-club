sub find-good ($string, @words) {
    my $chars = $string.comb.Bag;
    my $length = 0;
    for @words -> $word {
        $length += $word.chars if $word.comb.Bag ⊆ $chars;
    }
    return $length
}
for (("atach", <cat bt hat tree atac>),
    ("atach", <cat bt hat tree ataca>),
    ("welldonehopper", <hello world challenge>)) -> @test {
    printf "%-15s - %-22s => ", "@test[0]", "@test[1]";
    say find-good  @test[0], @test[1];
}

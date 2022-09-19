my @bars = map {.chr}, 0x2581 .. 0x2588;
for < 2 4 6 8 10 12 10 8 6 4 2>, <0 1 19 20>,
    <0 999 4000 4999 7000 7999> -> @test {
    my ($min, $max) = @test.minmax[0,*-1];
    say "@test[]; min: $min; max: $max.";
    say join '', @bars[ map { @bars * ($_ - $min) / ($max - $min) min @bars.end }, @test], "\n";
}

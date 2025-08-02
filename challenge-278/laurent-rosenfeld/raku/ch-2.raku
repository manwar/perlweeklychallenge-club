sub shuffle-word ($word is copy, $char) {
    my $ind = index $word, $char;
    return $word unless $ind;
    my $prefix = join "", sort $word.comb[0..$ind];
    return $prefix ~ substr $word, $ind + 1;
}

my @tests = <challenge e>, <programming a>, <champion, b>;
for @tests -> @test {
    printf "%-12s %-2s => ", @test;
    say shuffle-word @test[0], @test[1];
}

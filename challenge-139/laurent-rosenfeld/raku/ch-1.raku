use v6;

sub jortsort (@in) {
    + [<=] @in;  # + numifies the Boolean result
}

for (1,2,3,4,5), (1,3,2,4,5) -> @test {
    say "@test[] -> ", jortsort @test;
}

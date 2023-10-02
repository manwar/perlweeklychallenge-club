sub count-words (@in is copy) {
    my $prefix = shift @in;
    return (grep { .starts-with($prefix) }, @in).elems;
}

for <at pay attention practice attend>,
    <ja janet julia java javascript> -> @test {
    printf "%-3s - %-30s => ",
        @test[0], "@test[1..@test.end]";
    say count-words @test;
}

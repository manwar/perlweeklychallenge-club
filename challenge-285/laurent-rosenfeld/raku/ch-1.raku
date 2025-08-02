sub no-connection (@in) {
    my @starts = map { .[0] }, @in;
    my @ends = map { .[1] }, @in;
    return ~ (@ends (-) @starts);
}

    my @tests = (("B","C"), ("D","B"), ("C","A")), (("A","Z"),);
for @tests -> @test {
    printf "%-20s => ", @test.gist;
    say no-connection @test;
}

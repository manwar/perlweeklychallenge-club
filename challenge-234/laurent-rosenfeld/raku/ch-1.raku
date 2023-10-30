sub common-chars (@in) {
    my @letters = map { .comb }, @in;
    return ~ ∩ @letters;
}

for <java javascript julia>, <bella label roller>,
    <cool lock cook> -> @test {
    printf "%-25s => ", "@test[]";
    say common-chars @test;
}

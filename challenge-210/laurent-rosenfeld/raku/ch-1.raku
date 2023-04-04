sub sum-deleted-digits (@in) {
    # we can always delete all digits
    return [+] @in;
}

for <2 3 1>, <1 1 2 2 2 3> -> @test {
    say "@test[]".fmt("%-15s => "), sum-deleted-digits @test;
}

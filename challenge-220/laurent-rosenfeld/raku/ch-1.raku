sub common-char (@in) {
    return sort keys ([∩] map {.lc.comb}, @in);
}

for <Perl Rust Raku>, <love live leave> -> @test {
    printf "%-15s => ", "@test[]";
    say common-char @test;
}

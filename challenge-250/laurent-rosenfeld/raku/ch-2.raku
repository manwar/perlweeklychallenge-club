sub alphanum-string (@in) {
    my @out = map {  /^\d+$/ ?? 0 + $_ !! $_.chars }, @in;
    return max @out;
}

for ( "perl", "2", "000", "python", "r4ku"),
    ("001", "1", "000", "0001") -> @test {
    say alphanum-string @test;
}

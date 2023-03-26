sub ends-with-a (@in) {
    my $i = 0;
    my $end = @in.end;
    loop {
        return 1 if $i == $end;
        $i += @in[$i] == 0 ?? 1 !! 2;
        return 0 if $i > $end;
    }
}

for <1 0 0>, <1 1 1 0>, <0 0 0 1 0>, <1 1 0> -> @test {
    say (~ @test).fmt("%-12s => "), ends-with-a @test;
}

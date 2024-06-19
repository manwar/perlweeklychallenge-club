sub percent ($str, $char) {
    my $count = 0;
    for $str.comb -> $ch {
        $count++ if $ch eq $char;
    }
    return (($count * 100) / $str.chars).round;
}

my @tests = <perl e>, <java a>, <python m>,
            <ada a>, <ballerina l>, <analitik k>;
for @tests -> @test {
    printf "%-10s - %-2s => ", @test;
    say percent @test[0], @test[1];
}

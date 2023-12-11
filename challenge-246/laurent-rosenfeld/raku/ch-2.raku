sub linear-rec (@in) {
    my @range = @in.minmax;
    for @range -> $p {
        for @range -> $q {
            for 2..@in.end -> $i {
                last if @in[$i] !=
                    $p * @in[$i-2] + $q * @in[$i-1];
                # say "$p $q $i";
                return ("True:  p = $p, q = $q")
                    if $i == @in.end;
            }
        }
    }
    return (False);
}

my @tests = <1 1 2 3 5>, <4 2 4 5 7>, <4 1 2 -3 8>;
for @tests -> @test {
    printf "%-12s => ", "@test[]";
    say linear-rec @test;
}

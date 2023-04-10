sub is-toeplitz (@in) {
    for 1..@in.end -> $i {
        for 1..@in[0].end -> $j {
            # say "$i $j @in[$i][$j] @in[$i-1][$j-1]";
            return False if @in[$i][$j] != @in[$i-1][$j-1];
        }
    }
    return True;
}


for ( <4 3 2 1>, <5 4 3 2>, <6 5 4 3> ),
    ( <3 2 1 0>, <4 3 2 1>, <5 4 3 2> ),
    ( <3 2 1 0>, <4 3 2 1>, <5 5 3 2> ),
    ( <1 2 3>, <3 2 1> ) -> @test {
    say @test;
    say is-toeplitz(@test), "\n";
}

sub widest-valley (@in) {
    my (@valley, @temp);
    for 1..@in.end -> $i {     # valley with no left part
        push @valley, @in[$i-1];
        last if @in[$i] < @in[$i-1];
    }

    for 1..@in.end -> $i {
        my $left = True;
        for $i..@in.end -> $j {
            if $left {
                push @temp, @in[$j - 1];
                push @temp, @in[$j] and $left = False
                    if @in[$j] > @in[$j - 1];
            } else {
                last if @in[$j] < @in[$j-1];
                push @temp, @in[$j];
            }
        }
        @valley = @temp if @temp.elems > @valley.elems;
        @temp = ();
    }
    return @valley;
}

for <1 5 5 2 8>, <1 5 5 2>, <2 6 8 5>,
    <9 8 13 13 2 2 15 17>, <2 1 2 1 3>,
    <1 3 3 2 1 2 3 3 2> -> @test {
        say "@test[]".fmt("%-20s => "),
            widest-valley @test;
}

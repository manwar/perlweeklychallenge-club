sub number-collision (@in-array) {
    my @in = @in-array;
    loop {
        return () if @in.elems == 0;
        my @temp;
        for 0..^@in.end -> $i {
            if @in[$i] > 0 {
                if @in[$i+1] > 0 {
                    push @temp, @in[$i];
                } else {
                    next if abs(@in[$i]) == abs(@in[$i+1]);
                    push @temp,
                        abs(@in[$i]) > abs(@in[$i+1]) ??
                        @in[$i] !! @in[$i+1];
                }
            } elsif @in[$i] < 0 {
                push @temp, @in[$i] and next
                    unless @in[$i-1]:exists;
                if @in[$i-1] < 0 {
                    push @temp, @in[$i];
                } else {
                    shift @temp and next
                        if abs(@in[$i]) == abs(@in[$i+1]);
                    @temp[*-1] =
                        abs(@in[$i]) > abs(@in[$i-1]) ??
                        @in[$i] !! @in[$i-1];
                }
            } else {     # @in[$i] == 0
                push @temp, @in[$i];
            }
        }
        return @temp if @temp.all > 0 or @temp.all < 0;
        @in = @temp;
    }
}

for <2 3 -1>, <3 2 -4>, <1 -1> -> @test {
    say "@test[]".fmt("%-10s => "), number-collision @test;
}

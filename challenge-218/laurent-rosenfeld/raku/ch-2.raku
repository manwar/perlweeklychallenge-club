sub toggle_col (@in, $i) {
    for 0..@in.end -> $j {
        @in[$j][$i] = +not @in[$j][$i];
    }
}
sub improve-score (@in) {
    my $col-max = @in.elems - 1;
    my $row-max = @in[0].elems - 1;
    for @in -> @row {
        if @row[0] == 0 {
            $_ = +not $_ for @row;
        }
    }
    for 0..$row-max -> $index {
        my @col;
        push @col, @in[$_][$index] for 0..$col-max;
        toggle_col(@in, $index) if @in.elems/2 > [+] @col;
    }
    return @in;
}

my @test = [0,0,1,1], [1,0,1,0], [1,1,0,0];
say "Test: ", @test;
my @new-mat =  improve-score @test;
say "Result: ", @new-mat;
say "Score: ", [+] map {$_.join('').parse-base(2)}, @new-mat;

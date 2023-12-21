sub submatrix-sum (@in) {
    my $max-row = @in.end;
    my $max-col = @in[0].end;
    my @result;
    for 0..^$max-row -> $i {
        my @row;
        for 0..^$max-col -> $j {
            push @row, @in[$i][$j] + @in[$i][$j+1] +
                @in[$i+1][$j] + @in[$i+1][$j+1];
        }
        push @result, @row; # push doesn't flatten
    }
    return @result;
}

my @tests = [
              [1,  2,  3,  4],
              [5,  6,  7,  8],
              [9, 10, 11, 12]
            ],
            [
              [1, 0, 0, 0],
              [0, 1, 0, 0],
              [0, 0, 1, 0],
              [0, 0, 0, 1]
            ];
for @tests -> @test {
    print @test.gist, " => ";;
    say submatrix-sum @test;
}

sub special-positions (@mat) {
    my $row-max = @mat[0].end;
    my $count = 0;
    IND_I: for 0..$row-max -> $i {
        for 0..@mat.end -> $j {                            `
            next if @mat[$i][$j] != 1;
            next unless
                (@mat[$i][0..^$j, $j^..$row-max]).any != 0;
            for 0..@mat.end -> $k {
                next if $k == $i;
                next IND_I unless @mat[$i][$k] == 0;
            }
            # say "$i, $j"; # uncomment to see the positions
            $count++;
        }
    }
    return $count;
}

my @tests =
        [ [1, 0, 0],
          [0, 0, 1],
          [1, 0, 0],
        ],
        [ [1, 0, 0],
          [0, 1, 0],
          [0, 0, 1],
        ];
for @tests -> @test {
    printf "%-8s %-8s ... => ", "@test[0]", "@test[1]";
    say special-positions @test;
}

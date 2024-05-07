sub is-x-matrix (@m) {
    my $end = @m.end; # end = size - 1
    for 0..$end -> $i {
        for 0..$end -> $j {
            if $i == $j or $i + $j == $end { # diag or antidiag
                return False if @m[$i][$j] == 0;
            } else {    # not diag or antidiag
                return False if @m[$i][$j] != 0;
            }
        }
    }
    # If we got here, it is an X-matrix
    return True;
}

my @tests =
    [ [1, 0, 0, 2],
      [0, 3, 4, 0],
      [0, 5, 6, 0],
      [7, 0, 0, 1],
    ],
    [ [1, 2, 3],
      [4, 5, 6],
      [7, 8, 9],
    ],
    [ [1, 0, 2],
      [0, 3, 0],
      [4, 0, 5],
    ];
for @tests -> @test {
    printf "[%-10s...] => ", "@test[0]";
    say is-x-matrix @test;
}

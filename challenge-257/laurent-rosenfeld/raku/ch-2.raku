sub is-first-echelon (@mat) {
    my @leading;
    for 0..@mat.end -> $i {
        my @row = |@mat[$i];
        for 0..@row.end -> $j {
            next if @row[$j] == 0;
            if @row[$j] == 1 {
                @leading[$i] = $j;
                last;
            } else {
            }
        }
        @leading[$i] = Inf unless defined @leading[$i];
    }
    return False unless [<] grep { $_ < Inf }, @leading; # rules 2 and 3
    return False unless [<=] @leading;
    for 0..@leading.end -> $i {
        last if @leading[$i] == Inf;
        next unless defined @leading[$i];
        for 0..@mat.end -> $k {
            next if $i == @leading[$k];
            return False if @mat[$k][$i] != 0;
        }
    }
    return True;
}

my @tests =
    [ [1,0,0,1], [0,1,0,2], [0,0,1,3]],
    [ [1, 1, 0], [0, 1, 0], [0, 0, 0]],
    [ [0, 1,-2, 0, 1], [0, 0, 0, 1, 3], [0, 0, 0, 0, 0], [0, 0, 0, 0, 0]],
    [ [1, 0, 0, 4], [0, 1, 0, 7], [0, 0, 1,-1]],
    [ [0, 1,-2, 0, 1], [0, 0, 0, 0, 0], [0, 0, 0, 1, 3], [0, 0, 0, 0, 0]],
    [ [0, 1, 0], [1, 0, 0], [0, 0, 0]],
    [ [4, 0, 0, 0], [0, 1, 0, 7], [0, 0, 1,-1]];

for @tests -> @test {
    printf "%-20s => ", "@test[0] ...";
    say is-first-echelon @test;
}

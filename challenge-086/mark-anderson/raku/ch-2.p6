my @sudoku := < _ _ _ 2 6 _ 7 _ 1 >,
              < 6 8 _ _ 7 _ _ 9 _ >,
              < 1 9 _ _ _ 4 5 _ _ >,
              < 8 2 _ 1 _ _ _ 4 _ >,
              < _ _ 4 6 _ 2 9 _ _ >,
              < _ 5 _ _ _ 3 _ 2 8 >,
              < _ _ 9 3 _ _ _ 7 4 >,
              < _ 4 _ _ 5 _ _ 3 6 >,
              < 7 _ 3 _ 1 8 _ _ _ >;

my @s;
my @nums = @sudoku.map((1..9) (-) (*.comb(/\d/).map(+*)))
                  .map(*.keys.sort.Array);
my @indices = @sudoku.map(*.grep("_", :k).Array);
my @permutations;

for ^9 {
    @s = @sudoku.map(*.Array);
    @permutations[$_] = get-permutations($_);
}

for [X] @permutations -> @p {
    (^9).map: { @s[$_][|@indices[$_]] = @p[$_].Array };

    if column-check(@s) {
        if sub-box-check(0, @s) {
            if sub-box-check(3, @s) {
                if sub-box-check(6, @s) {
                    .say for @s;
                    last;
                }
            }
        }
    }
}

sub get-permutations($i) {
    my @a = gather {
        for @nums[$i].permutations -> @n {
            @s[$i][|@indices[$i]] = @n;
            take @n if column-check(@s) and sub-box-check($i, @s);
        }
    }
 
    return @a;
}

sub column-check(@s) {
    for ^9 {
        if @s.map(*[$_]).join ~~ /(\d) .* $0/ {
            return 0;
        }
    }

    return 1;
}

sub sub-box-check($i, @s) {
    my $r = do given $i {
        when 0|1|2 { 0 }
        when 3|4|5 { 3 }
        when 6|7|8 { 6 }
    }

    for ([0..2], [3..5], [6..8]) -> @c {
        if (@s[$r  ][@c], 
            @s[$r+1][@c], 
            @s[$r+2][@c]).flat.join ~~ /(\d) .* $0/ {
                return 0;
        }
    }

    return 1;
}

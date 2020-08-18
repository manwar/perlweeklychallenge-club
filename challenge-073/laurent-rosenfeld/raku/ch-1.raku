use v6;

my @a = 1, 5, 0, 2, 9, 3, 7, 6, 4, 8;
my $s =  @*ARGS[0] // 3;

my @result = gather {
    for 0..@a.elems - $s  -> $i {
        take min @a[$i..^$i + $s];
    }
}
say @result;

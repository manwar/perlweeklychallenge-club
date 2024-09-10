sub order-game (@in is copy) {
    my $min = True;
    loop {
        my @next-list;
        for @in -> $i, $j {
            my $new = $min ?? min $i, $j !! max $i, $j;
            push @next-list, $new;
            $min = not $min;
        }
        return @next-list[0] if @next-list.elems == 1;
        @in = @next-list;
    }
}

my @tests = (2, 1, 4, 5, 6, 3, 0, 2), (0, 5, 3, 2),
            (9, 2, 1, 4, 5, 6, 0, 7, 3, 1, 3, 5, 7, 9, 0, 8);
for @tests -> @test {
    printf "%-8s ... => ", "@test[0..3]";
    say order-game @test;
}

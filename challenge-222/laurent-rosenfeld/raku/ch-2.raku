sub last-member (@ints) {
    my @in = reverse sort @ints;
    while @in.elems > 1 {
        @in = @in[0] == @in[1] ?? @in[2..@in.end].sort.reverse !!
              (@in[1] - @in[0], @in[2..@in.end]).flat.sort.reverse;
    }
    return @in.elems;
}

for (2, 7, 4, 1, 8, 1), (1,), (1, 1) -> @test {
  printf "%-12s => ", "@test[]";
  say last-member @test;
}

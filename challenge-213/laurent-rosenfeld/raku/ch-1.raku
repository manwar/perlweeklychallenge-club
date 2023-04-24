sub fun-sort (@in) {
    return (@in.grep({$_ %% 2}).sort,
            @in.grep({$_ % 2}).sort).flat;
}

for <1 2 3 4 5 6>, <1 2>, (1,),
     1..15, (1..15).reverse -> @test {
    say fun-sort @test;
}

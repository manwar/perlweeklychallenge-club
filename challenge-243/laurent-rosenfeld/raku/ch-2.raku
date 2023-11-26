sub floor-sum (@in) {
    my $count = @in.elems;
    for @in.combinations: 2 -> @pair {
        $count +=  floor(@pair[0]/@pair[1])
               + floor(@pair[1]/@pair[0]);
    }
    return $count;
}

for <2 5 9>, <4 9 3 2>, <7 7 7 7 7 7 7> -> @test {
    printf "%-15s => ", "@test[]";
    say floor-sum @test;
}

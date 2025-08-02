sub distribute-elements (@in is copy) {
    my @arr1 = shift @in;
    my @arr2 = shift @in;
    for @in -> $item {
        if @arr1[*-1] > @arr2[*-1] {
            push @arr1, $item;
        } else {
            push @arr2, $item;
        }
    }
    return (@arr1, @arr2).flat;
}
my @tests = <2 1 3 4 5>, <3 2 4>, <5 4 3 8>;
for @tests -> @test {
    printf "%-10s => ", "@test[]";
    say distribute-elements @test;
}

sub equalize (@nums is copy) {
    my $sum = [+] @nums;
    return -1 if $sum % @nums.elems;
    my $target = $sum / @nums.elems;
    my $count = 0;
    my $carry = 0;
    for @nums <-> $num {
        $num -= $carry;
        $carry = $target - $num;
        $count += $carry.abs;
    }
    return $count;
}

for <1 0 5>, <0 2 0>, <0 3 0>, <3 0 3>, <2 2 2>,
    <1 0 5 2>, <2 5 0 1>, <1 0 5 3>, <6 0 0> -> @test {
    say @test, " \t -> ", equalize @test;
}

sub to-single-digit ($in) {
    my $prod = $in;
    my $count = 0;
    while $prod > 9 {
        $prod = [*] $prod.comb;
        $count++;
    }
    return $count;
}

sub my-sort (@in) {
    my @sorted = sort @in;
    return sort &to-single-digit, @sorted;
}

my @tests = <15 99 1 34>, <50 25 33 22>;
for @tests -> @test {
    printf "%-15s => ", "@test[]";
    say join ", ", my-sort @test;
}

sub complete-day (@in) {
    my $count = 0;
    for @in.combinations: 2 -> @pair {
        $count++ if ([+] @pair) %% 24;
    }
    return $count;

my @tests = <12 12 30 24 24>, <72 48 24 5>, <12 18 24>;
for @tests -> @test {
    printf "%-15s => ", "@test[]";
    say complete-day @test;
}

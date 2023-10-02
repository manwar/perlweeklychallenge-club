sub lrsd (@in) {
    my @l = (0, [\+] @in[0..@in.end - 1]).flat;
    my @r =
    (( [\+] @in.reverse[0..@in.end - 1]).reverse, 0).flat;
    return map { (@l[$_] - @r[$_]).abs }, 0..@l.end;
}
my @tests = (10, 4, 8, 3), (1,), (1, 2, 3, 4, 5);
for @tests -> @test {
    printf "%-10s => ", "@test[]";
    say lrsd @test;
}

sub find-zeros (@in, $count) {
    return False if $count == 0 or @in.elems < $count;
    my $str = join "", @in;
    return so ($str ~~ / <!after 1> [0 ** {$count}] <!before 1>/)
}

for <0 0 0 1>, <0 0>, <1 0 0 1>, <1 0 0 0 1>,
    <1 0 0 0 0 0 0 1> -> @test {
    for 0..5 -> $cnt {
        printf "%d - %-16s => ", $cnt, "@test[]";
        say + find-zeros @test, $cnt;
  }
}

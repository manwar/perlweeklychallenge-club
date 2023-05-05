sub find-non-sorted (@in) {
    my @out = @in[0];
    my $count = 0;
    for 1..@in.end -> $i {
        if @in[$i] lt @in[$i-1] {
            $count++;
        } else {
            push @out, @in[$i];
        }
    }
  say @out;
    return $count;
}
for <abc xyz tsu>, <rat cab dad>, <x y z> -> @test {
    printf "%-15s => ", ~@test;
    say find-non-sorted @test;
}

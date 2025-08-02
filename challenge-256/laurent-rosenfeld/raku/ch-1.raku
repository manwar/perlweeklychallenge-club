sub find-pairs (@in) {
    my $nb-pairs = 0;
    for 0..@in.end -> $i {
        for $i^..@in.end -> $j {
            $nb-pairs++ if @in[$i] eq @in[$j].flip;
        }
    }
    return $nb-pairs;
}

my @tests = <ab de ed bc>, <aa ba cd ed>, <uv qp st vu mn pq> ;
for @tests -> @test {
    printf "%-20s => ", "@test[]";
    say find-pairs @test;
}

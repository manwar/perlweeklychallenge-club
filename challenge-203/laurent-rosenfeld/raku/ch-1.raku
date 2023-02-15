sub find-quadruplets (@in) {
    my $count = 0;
    my $last = @in.end;
    for 0..$last-3 -> $i {
        for $i^..$last-2 -> $j {
            for $j^..$last-1 -> $k {
                my $target = [+] @in[$i, $j, $k];
                for $k^..$last -> $m {
                    $count++ if @in[$m] == $target;
                }
            }
        }
    }
    return $count;
}
for <1 2 3 6>, <1 1 1 3 5>, <1 1 1 3 5 5>, <3 3 6 4 5>,
    <3 3 6 12 21> -> @test {
        say "@test[]".fmt("%-15s -> "), find-quadruplets @test;
}

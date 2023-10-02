sub shuffle-string ($string, @indice) {
    my @index;
    @index[@indice[$_]]= $_ for 0..@indice.end;
    # say @index;
    return ($string.comb)[@index].join("");
}

for ('lacelengh', (3,2,0,5,4,8,6,7,1)),
    ('rulepark', (4,7,3,1,0,5,2,6)) -> @test {
    printf "%-10s - %-20s => ", @test[0], "@test[1]";
    say shuffle-string @test[0], @test[1];
}

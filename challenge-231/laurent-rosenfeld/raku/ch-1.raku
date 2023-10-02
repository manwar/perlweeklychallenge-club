sub min-max (@in) {
    my @vals = grep {$_ != @in.min && $_ != @in.max}, @in;
    return @vals ?? @vals !! [-1];
}

for <3 2 1 4>, <3 1>, <2 1 3> -> @test {
    printf "%-10s => ", "@test[]";
    say min-max @test;
}

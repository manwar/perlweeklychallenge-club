my @s = "abc", "dea", "cd";

sub test-chain (@input) {
    return False if (substr @input[0], 0, 1)
        ne substr @input[*-1], (@input[*-1]).chars - 1, 1;
    for 1..@input.end -> $i {
        return False if (substr @input[$i], 0, 1)
            ne substr @input[$i-1], (@input[$i-1]).chars -1, 1;
    }
    True;
}

sub find-circle (@in) {
    for @in.combinations(2..@in.elems) -> $combin {
        for $combin.permutations -> $permute {
            next unless test-chain $permute;
            say $permute;
            return 1;
        }
    }
    return 0;
}

say find-circle @s;

sub greatest-eng-let ($in) {
    my $uc = (grep { / <:Lu> / }, $in.comb).Set;
    my $lc = (map { .uc }, grep {/ <:Ll> /}, $in.comb).Set;
    return  ($uc ∩ $lc).keys.sort.tail // "''";
}

my @tests = < PeRlwEeKLy ChaLlenge The >;
for @tests -> $test {
    printf "%-15s => ", $test;
    say greatest-eng-let $test;
}

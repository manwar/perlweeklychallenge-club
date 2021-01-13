
sub gcdsum (Int $N){
    (1..$N).combinations(2).map(-> ($a, $b) { $a gcd $b }).sum();
}

for @*ARGS -> $n {
    say gcdsum( $n.Int );
}

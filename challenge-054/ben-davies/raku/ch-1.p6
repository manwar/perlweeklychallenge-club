use v6.d;
unit sub MAIN(Int:D $n where * >= 1, Int:D $k where * >= 1) {
    say (1...$n).permutations.map(*.join).sort(* > *).[$k - 1]
}

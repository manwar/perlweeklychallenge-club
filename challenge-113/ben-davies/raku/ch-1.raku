use v6;
unit sub MAIN(IntStr:D $n where 1..*, IntStr:D $d where 1..9) {
    say Int(+$n ∈ (1..$n).grep({ m/$d/ }).combinations».sum);
}

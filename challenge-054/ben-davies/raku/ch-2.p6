use v6.d;
unit proto sub MAIN(|) {*}
multi sub MAIN(Int:D $n where * >= 1) {
    .say for ($n,&collatz...1);
}
multi sub MAIN(Bool:D :extra-credit($)!) {
    # Warning: This takes a long time to run! This took approximately half an
    # hour on my machine.
    # OUTPUT:
    # Value   Elements
    # 837799  525
    # 626331  509
    # 939497  507
    # 704623  504
    # 910107  476
    # 927003  476
    # 511935  470
    # 767903  468
    # 796095  468
    # 970599  458
    # 546681  452
    # 818943  450
    # 820022  450
    # 820023  450
    # 410011  449
    # 615017  447
    # 886953  445
    # 906175  445
    # 922524  445
    # 922525  445
    react whenever supply for 1..1_000_000 {
        emit ($_,&collatz...1);
    }.map({
        @^collatz.head => @^collatz.elems
    }).sort({
        $^a.value < $^b.value
    }).head(20) {
        once printf "%-7s %s$?NL", 'Value', 'Elements';
        printf "%-7d %d$?NL", .key, .value;
    }
}
sub collatz(Int:D $n --> Int:D) { $n %% 2 ?? $n div 2 !! 3 * $n + 1 }

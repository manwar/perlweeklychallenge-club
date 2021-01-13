use v6;
unit sub MAIN(+@array where .all ~~ Int:D) {
    say (0...^+@array).map({
        my (@prev, Int:D $cur) := @array[0..^$_, $_];
        @prev && (my Int:D $min = @prev.min) < $cur ?? $min !! 0
    });
}

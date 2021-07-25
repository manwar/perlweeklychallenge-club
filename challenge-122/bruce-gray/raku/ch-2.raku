sub b'ball-ways ( UInt:D $S ) {
    constant @SHOT_VALUES = 1, 2, 3;
    return if $S == 0;

    return gather for @SHOT_VALUES -> $n {
        next if $S - $n < 0;

        if b'ball-ways($S - $n) -> @ways {
            take ($n, |.list)  for @ways;
        }
        else {
            take ($n,);
        }
    }
}

unit sub MAIN ( UInt:D $final_score );
.put for b'ball-ways(  $final_score );

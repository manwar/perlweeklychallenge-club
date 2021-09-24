use v6;
unit sub MAIN(**@xs where .all ~~ Int:D & &(* > 0) && .&[~~](.sort)) {
    say gather @xs .= skip: take [@xs[0...&end-of-seq]] while @xs;
    sub end-of-seq(Int:D $i) { $i >= @xs - 1 or @xs[$i + 1] != @xs[$i] + 1 }
}

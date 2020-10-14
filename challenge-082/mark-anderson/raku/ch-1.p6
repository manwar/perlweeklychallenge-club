unit sub MAIN(UInt $m, UInt $n);

say (1..($m, $n).min).grep(($m, $n).all %% *).join(", ").List;

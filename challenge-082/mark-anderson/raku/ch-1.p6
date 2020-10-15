unit sub MAIN(UInt $m, UInt $n);

say (1..($m gcd $n)).grep(($m, $n).all %% *).join(", ").List;

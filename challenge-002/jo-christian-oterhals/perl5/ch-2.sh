perl -E '%d = map { $_ => $c++ } (0..9,A..Y); $i = 1; for (reverse(split("", @ARGV[0]))) { $e += $i * $d{$_}; $i = $i * 35; } say $e' 1M5

perl -E '%d = map { $c++ => $_ } (0..9,A..Y); while ($ARGV[0] > 0) { push @n, $d{$ARGV[0] % 35}; $ARGV[0] = int($ARGV[0] / 35); } say join("", reverse(@n));' 2000

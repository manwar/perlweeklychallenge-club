chomp $_; @arr = split /\D+/, $_; $m = 0; for (1..$#arr) {$m = $_ if $arr[$_] > $arr[$m];}; say $m;

# perl -nE '...'

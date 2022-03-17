my $P := 1, 1, 1, -> $a, $b, $c {$b + $a} ... *;
$P.grep(*.is-prime).unique.head(10).join(', ').say;

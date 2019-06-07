perl6 -e 'sub MAIN($a, $b) { say "Equal point: " ~ ( $b - $a == 100 ?? "None" !! $a / (1 - (($b - $a) / 100))) }' 32 212

<?php

function gcd($a, $b) {
    // could of used https://www.php.net/manual/en/function.gmp-gcd.php
    return ($a % $b) ? gcd($b,$a % $b) : $b;
}
function solutions($N) {
    // $N can't be less than 2
    if ($N <= 1) {
        return false;
    }
    $total = 0;
    for ($i = 1; $i <= $N; $i++) {        
        for ($next = $i + 1; $next <= $N; $next++) {
            // debug purpose
            printf ("gcd(%s, %s)\n", $i, $next);
            $total += gcd($i, $next);
        }        
    }
    return $total;
}

echo solutions(3), "\n";
echo solutions(4), "\n";
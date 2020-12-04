<?php
    // Run as:
    // $ php ch-1.php 100
    // 13015

    function gcd($a, $b) {
        while ($b) {
            $t = $b;
            $b = $a % $b;
            $a = $t;
        }

        return $a;
    }

    $n = $argc == 2 ? $argv[1] : 3;

    $s = 0;
    for ($x = 1; $x <= $n; $x++) {
        for ($y = $x + 1; $y <= $n; $y++) {
            $s += gcd($x, $y);
        }
    }

    echo "$s\n";

?>

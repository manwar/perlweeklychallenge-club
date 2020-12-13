<?php

/**
 * You are given two positive numbers $A and $B.
 * Write a script to demonstrate Ethiopian Multiplication using the given numbers.
 * - see https://threesixty360.wordpress.com/2009/06/09/ethiopian-multiplication/
 * 
 * Example: 10 x 20
 * 10 20 - dont keep because 10 is even
 * 5  40 - we keep 40, - because 5 is odd
 * 2  80 - we dont keep because of 2 is even
 * 1  160 - we keep
 * 
 * 40+160 = 200;
 */

function ethiopian_muliply($A, $B) {
    $total = 0;
    while ($A >= 1) {
        if ($A % 2 == 1) {
            $total += $B;
        }
        $A = floor($A / 2 );
        $B = $B * 2;
    };
    return $total;
}

echo ethiopian_muliply(10, 20);
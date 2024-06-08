<?php

const PARENS = ['(', ')'];
const SQUARE_BRACKETS = ['[', ']'];
echo '@ints = ';
$ints = json_decode(str_replace(PARENS, SQUARE_BRACKETS, fgets(STDIN)));
echo '$k = ';
$k = fgets(STDIN);
$result = 0;
foreach ($ints as $index => $value) {
    $needed_factor = intdiv($k, gmp_intval(gmp_gcd($index, $k)));
    $next_valid = ceil(($index + 1) / $needed_factor) * $needed_factor;
    $values_to_check = array_column(array_chunk(array_slice($ints, $next_valid), $needed_factor), 0);
    $result += @array_count_values($values_to_check)[$value];
}
echo $result;
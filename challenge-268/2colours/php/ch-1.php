<?php


const PARENS = ['(', ')'];
const BRACKETS = ['[', ']'];
echo '@x = ';
$x = json_decode(str_replace(PARENS, BRACKETS, fgets(STDIN)));
echo '@y = ';
$y = json_decode(str_replace(PARENS, BRACKETS, fgets(STDIN)));

sort($x);
sort($y);

$expected_difference = $y[0] - $x[0];

$all_expected = array_product(array_map(fn($a, $b) => $b - $a === $expected_difference, $x, $y));

echo $all_expected ? $expected_difference : 'N/A';

<?php

const PARENS = ['(', ')'];
const SQUARE_BRACKETS = ['[', ']'];
echo '@ints = ';
$ints = json_decode(str_replace(PARENS, SQUARE_BRACKETS, fgets(STDIN)));
echo max(...array_map(fn ($pred) => count(array_filter($ints, $pred)), [fn ($x) => $x > 0, fn ($x) => $x < 0]));
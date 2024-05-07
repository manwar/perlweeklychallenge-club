<?php

const PARENS = ['(', ')'];
const BRACKETS = ['[', ']'];
echo '@ints = ';
$ints = json_decode(str_replace(PARENS, BRACKETS, fgets(STDIN)));

sort($ints);

echo str_replace(BRACKETS, PARENS, json_encode(array_merge(...array_map(array_reverse(...), array_chunk($ints, 2)))));

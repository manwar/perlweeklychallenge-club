<?php

echo '$line1 = ';
$line1 = preg_split('/\s+/', rtrim(fgets(STDIN)));
echo '$line2 = ';
$line2 = preg_split('/\s+/', rtrim(fgets(STDIN)));

$word_frequencies = array_count_values($line1);
foreach (array_count_values($line2) as $key => $value) {
    @$word_frequencies[$key] += $value;
}

$solution = array_keys(array_filter($word_frequencies, fn($freq) => $freq === 1)) ?: [''];
var_dump($solution);

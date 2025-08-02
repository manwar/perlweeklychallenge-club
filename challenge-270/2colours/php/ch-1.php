<?php

$matrix = json_decode(file_get_contents('php://stdin'));
$solutions = $matrix;

foreach ($matrix as $row => $content) {
        $valid_row = array_sum($content) === 1;
        foreach ($solutions[$row] as &$value) {
                $value *= $valid_row;
        }
}
foreach (array_map(null, ...$matrix) as $column => $content) {
        $valid_column = array_sum($content) === 1;
        foreach (array_keys($solutions) as $row) {
                $solutions[$row][$column] *= $valid_column;
        }
}

$result = 0;
array_walk_recursive($solutions, function ($elem) use (&$result) { $result += $elem; });
echo $result;
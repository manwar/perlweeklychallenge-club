<?php

$matrix = json_decode(file_get_contents('php://stdin'));
$size = count($matrix[0]); # let's hope it's actually a square matrix...

// all 0's except for those 2 - which may be one if it's the middle
function is_row_compliant($row, $diagonal_position, $size)
{
    $is_middle = $diagonal_position === $size - 1 - $diagonal_position;
    return @array_count_values($row)[0] === $size - ($is_middle ? 1 : 2) && $row[$diagonal_position] !== 0 && $row[$size - 1 - $diagonal_position] !== 0;
}

//[$diagonal_position, $solution] = array_reduce($matrix, fn ($state, $row) => [$state[0] + 1, $state[1] && is_row_compliant($row, $state[0], $size)], [0, true]); # is this really worth it? :D
$solution = true;
foreach ($matrix as $row_index => $row) {
    if (!is_row_compliant($row, $row_index, $size)) {
        $solution = false;
        break;
    }
}

var_dump($solution);
<?php
function max_min_pair_sum($array) {
    // Sort the array in ascending order
    sort($array);

    // Use pairwise iteration to get pairs of adjacent elements
    // (0,1), (2,3), (4,5), ...
    $pairwise_array = array_chunk($array, 2);

    // Calculate the sum of the minimum of each pair
    $sum = 0;
    foreach ($pairwise_array as $pair) {
        $sum += min($pair);
    }

    return $sum;
}

// Define test cases
$test1 = [1, 2, 3, 4];
$expected1 = 4;
$test2 = [0, 2, 1, 3];
$expected2 = 2;

// Run tests
assert(max_min_pair_sum($test1) == $expected1);
assert(max_min_pair_sum($test2) == $expected2);


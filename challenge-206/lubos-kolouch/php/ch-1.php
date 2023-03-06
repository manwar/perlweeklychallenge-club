<?php

// Define function to convert a time in HH:MM format to minutes since midnight
function time_to_minutes($time) {
    [$hours, $minutes] = explode(':', $time);
    return 60 * $hours + $minutes;
}

// Define function to find the shortest time in minutes between any two times
function shortest_time($times) {
    $min_diff = 1440;  // initialize with maximum possible value
    $num_times = count($times);
    for ($i = 0; $i < $num_times - 1; $i++) {
        for ($j = $i + 1; $j < $num_times; $j++) {
            $diff = abs(time_to_minutes($times[$j]) - time_to_minutes($times[$i]));
            $diff = min($diff, 1440 - $diff);  // handle wraparound from midnight to 00:00
            if ($diff < $min_diff) {
                $min_diff = $diff;
            }
        }
    }
    return $min_diff;
}

// Define test cases
$test1 = array("00:00", "23:55", "20:00");
$expected1 = 5;
$test2 = array("01:01", "00:50", "00:57");
$expected2 = 4;
$test3 = array("10:10", "09:30", "09:00", "09:55");
$expected3 = 15;

// Run tests
if (shortest_time($test1) === $expected1) {
    echo "Test 1 passed\n";
} else {
    echo "Test 1 failed\n";
}

if (shortest_time($test2) === $expected2) {
    echo "Test 2 passed\n";
} else {
    echo "Test 2 failed\n";
}

if (shortest_time($test3) === $expected3) {
    echo "Test 3 passed\n";
} else {
    echo "Test 3 failed\n";
}


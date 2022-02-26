<?php

function calculate_factorial(int $what){

    $fact = 1;

    foreach (range(1, $what) as $i) {
        $fact *= $i;
    }

    return $fact;
}


function get_factorions_sum(int $what){

    $my_sum = 0;
    foreach (str_split($what) as $i) {
        $my_sum += calculate_factorial($i);
    }

    return $my_sum;
}


function is_equal(int $what){
    return $what == get_factorions_sum($what);
}


is_equal(145) == 1 or throw new Exception("Test 1 failed");
is_equal(123) == 0 or throw new Exception("Test 2 failed");

?>

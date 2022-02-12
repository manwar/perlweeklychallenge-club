<?php

$cache = [];

function get_houses_max($houses) {

    global $cache;

    if (in_array(implode(",",$houses), $cache)) {
        return $cache[implode(",",$houses)];
    }
        
    $max_value = 0;
    $house_index = 0;

    foreach (array_slice($houses, 2) as $house) {
        $next_houses_values = get_houses_max(array_slice($houses, 2+$house_index));
        if ($next_houses_values > $max_value) {
            $max_value = $next_houses_values;       
        }

        $house_index++;
    }

    $cache[implode(",",$houses)] = $houses[0] + $max_value;
    return $houses[0] + $max_value;

}


if (get_houses_max([2,4,5]) != 7) {
    throw new Exception('Failed test 1');
}

$cache = [];

if (get_houses_max([4, 2, 3, 6, 5, 3]) != 13) {
    throw new Exception('Failed test 2');

}
?>

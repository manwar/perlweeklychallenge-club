<?php

function get_min_depth($input) {

    #Input: '1 | 2 3 | 4 5'

    # iterate through the layers. If the next layer does not have 2^n items,
    # there must be a leaf node
    
    $layers = preg_split("/\|/", $input);

    $layer_count = 1;
    foreach ($layers as $layer) {
        # if not defined means we are at the last layer

        try {
            $items_count = count(preg_split("/\s+/",$layers[$layer_count]));
            if ($items_count != 2**$layer_count+2) {
                return $layer_count; 
            }

            $layer_count++;

        } catch (Exception $e) {
         return $layer_count;
        }

    }
}

get_min_depth('1 | 2 3 | 4 5') == 2 or throw new Exception('Test failed');
get_min_depth('1 | 2 3 | 4 *  * 5 | * 6') == 3 or throw new Exception('Test 2 failed');


?>

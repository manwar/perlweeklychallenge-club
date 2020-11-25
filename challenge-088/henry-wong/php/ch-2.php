<?php
# 0. take row
# 1. delete row
# 2. rotate matrix 90 degrees
# 3. repeat again till no matrix

# 1. transpose matrix 
# 2. reflect horizontal axis 

$a = array(
  array(1,2,3),
  array(4,5,6),
  array(7,8,9)
);

$c = array(
  array( 1,  2,  3,  4 ),
  array(5,  6,  7,  8 ),
  array(9, 10, 11, 12 ),
  array(13, 14, 15, 16)
);

function rotate($a) {
  # transpose array
  $b = array();
  if (isset($a[0]) && is_array($a[0])) {
    $column_size = count($a[0]);
    for($i = 0; $i < $column_size; $i++) {
      $b[] = array_column($a, $i);
    };
    # then reflect horizontal axis
    $b = array_reverse($b);
      
  }
  return $b;
}

function solution($a) {
  $b = array();  
  $shift = true;
  while ($shift) {
    $b = array_merge($b, array_values($a[0]));
    array_shift($a);
    if (empty($a)) {
      $shift = false;
    }
    $a = rotate($a);
  }
  return $b;
}

print_r(solution($a));
print_r(solution($c));

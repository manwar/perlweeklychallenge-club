<?php
/**
TASK #1 › Array of Product
**/

function solution($a) {
  $b = array();
  for ($i = 0; $i < count($a); $i++) {
      $c = $a;
      unset($c[$i]);
      $b[] = array_product($c);
  }
  return $b;
}

$a = array(5, 2, 1, 4, 3);
print_r(solution($a));

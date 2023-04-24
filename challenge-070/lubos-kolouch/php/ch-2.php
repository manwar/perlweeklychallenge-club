<?php

$N = 4;
$grayCode = ['0', '1'];

for ($i = 2; $i <= $N; $i++) {
    $revGrayCode = array_reverse($grayCode);
    $grayCode = array_map(function ($x) { return '0' . $x; }, $grayCode);
    $revGrayCode = array_map(function ($x) { return '1' . $x; }, $revGrayCode);
    $grayCode = array_merge($grayCode, $revGrayCode);
}

$grayCode = array_map(function ($x) { return bindec($x); }, $grayCode);
echo implode(', ', $grayCode), "\n";

?>

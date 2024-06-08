<?php

const SCREEN_WIDTH = 100;
echo '$str = ';
$str = rtrim(fgets(STDIN));
echo '@width = ';
$width = array_combine(range('a', 'z'), explode(' ', rtrim(fgets(STDIN))));

$current_line_number = 1;
$current_line_content = '';
$current_column = 0;
$characters = str_split($str);

foreach ($characters as $current_char) {
    $current_width = $width[$current_char];
    if ($current_column + $current_width > SCREEN_WIDTH) {
        echo "Line $current_line_number: $current_line_content ($current_column pixels)\n";
        $current_line_content = "$current_char";
        $current_column = $current_width;
        $current_line_number++;
        continue;
    }
    $current_column += $current_width;
    $current_line_content .= $current_char;
}
echo "Line $current_line_number: $current_line_content ($current_column pixels)";
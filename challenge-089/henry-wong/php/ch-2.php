<?php

/**
There are two rules for constructing an odd magic square 
1. "top right" 
2. "if the place is occupied, go one down"
**/

function solution($N) {
    if ($N % 2 == 0) {
        // I only know how to solve odd size magic squares for now.
        // I'll have figure out even magic squares later.
       return false;
    }
    $board = [];
    $numbers = $N * $N;
    for ($i = 1 ; $i <= $numbers; $i++) {
        if ($i == 1) {
            // top middle
            $y = 0;
            $x = ((int)($N / 2));  # would have add +1 but we starting with base 0
            $board[$y][$x] = $i;
            
        } else {
            // check if top right is empty
            $y-=1;
            $x+=1;
            $sy = $y < 0 ? $N - 1 : $y;
            $sx = $x >= $N ? 0 : $x;
            if (! isset($board[$sy][$sx])) {
                 // if empty - then assign number
                $board[$sy][$sx] = $i; 
                $y = $sy;
                $x = $sx;
            } else {
                // else go down a row.                
                $x-=1;
                $y+=2;
                $board[$y][$x] = $i;
                
            }           
        }
    }
    // clean up sort the key correctly
    
    for($i = 0; $i < $N; $i++) {
        ksort($board[$i]);
    };
    ksort($board);
    return $board;
}

print_r(solution(3)); // 3x3
print_r(solution(5)); // 5x5
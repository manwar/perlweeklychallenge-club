<?php

function solve($values, $cost1, $cost2)
{
    $array_length = count($values);
    
    # special cases for short arrays
    switch ($array_length) {
        case 0: # nothing can be done, let's define the cost as the sum of the empty set
            return 0;

        case 1: # nothing needs to be done - if we consider negative costs, this can be infinitely cheap
            return $cost1 < 0 ? -INF : 0;

        case 2:
            if ($cost1 < 0 || $cost2 < 0) # either operation can carry the value to arbitrarily low numbers
                return -INF;
            
            return $cost1 * abs($values[0] - $values[1]); # only "level 1" operation can actually get us to equal
    }

    # proper sizes
    if ($cost1 < 1 || $cost2 < 0) # either operation can carry the value to arbitrarily low numbers
        return -INF;

    if ($cost1 === 0) # trivial free solution available
        return 0;

    $minimum_goal = max($values);
    $minimum_increments = array_map(fn ($elem) => $minimum_goal - $elem, $values);
    $sum_minimum_increments = array_sum($minimum_increments);
    $most_increment_in_minimal_arrangement = max($minimum_increments);
    $sum_of_rest = $sum_minimum_increments - $most_increment_in_minimal_arrangement;

    if ($cost2 >= 2 * $cost1) # "level 2" is not worth using over "level 1" which is always applicable - trivial solution wins
        return $cost1 * $sum_minimum_increments;

    $S = $sum_minimum_increments;
    $M = $most_increment_in_minimal_arrangement;
    $SR = $sum_of_rest;
    $N = $array_length;
    $L1 = $cost1;
    $L2 = $cost2;

    # we need to figure out the actual goal: minimum_goal + variable d, we will figure out the d values that can lead to an optimum solution
    $candidates = [];

    # if d >= D_det then we can use "level 2" all we want; there is no outlier value - only parity is a challenge
    #CASE 1 - either the parity is good - we use 0 "level 1" operations
    #CASE 2 - or the parity needs to be fixed by using 1 "level 1" operation
    # if d < D_det then we have to add a calculable number of "level 1" operations
    #CASE 3 here, the parity won't be a problem at the optimum value
    # (we increment the outlier until the further increments needed will exactly match the total increments needed for all the rest of the slots -> pairing will succeed)
    $D_det = max(0, ceil(($M-$SR)/($N-2)));

    # CASE 1, 2
    $d_valid_parity_no_outlier = match ($N % 2) {
        0 => # the total number of increments is S + N*d - it's all or nothing based on the parity of S
            $S % 2 === 1 ? [] : [0, 1],
        1 => # it will oscillate because of the N*d part, S decides which is the one right parity
            [$S % 2]
    };
    
    # CASE 1
    if (!empty($d_valid_parity_no_outlier)) { # if a good parity even exists; we want the minimum d value (either D_det or D_Det + 1 will have the right parity, maybe both)
        $D1 = in_array($D_det % 2, $d_valid_parity_no_outlier) ? $D_det : $D_det + 1;
        # only "level 2" operations used
        $candidates[] = $L2 * ($S + $N * $D1) / 2;
    }

    # CASE 2
    if (count($d_valid_parity_no_outlier) < 2) { # if a bad parity even exists; we want the minimum d value (either D_det or D_Det + 1 will have bad parity, maybe both)
        $D2 = !in_array($D_det % 2, $d_valid_parity_no_outlier) ? $D_det : $D_det + 1;
        # one "level 1" operation to fix the parity, the remaining needed increments (all - 1) are paired "level 2" operations
        $candidates[] = $L1 + $L2 * ($S + $N * $D2 - 1) / 2;
    }

    # CASE 3
    # if there is a possible d value for this case at all
    if ($D_det > 0) {
        $D3_min = 0;
        $D3_max = $D_det - 1; # D_det is defined as an integer, safe to subtract 1
        # this is actually more than one case: depending on the costs, 0 <= d < D_det might be optimal at the maximum or the minimum
        $d_diff_sign_outlier = gmp_sign(($N - 1) * $L2 - $L1 * ($N - 2)); # 0 constant, -1 decreasing, 1 increasing with d
        $D3 = $d_diff_sign_outlier >= 0 ? $D3_min : $D3_max;
        $candidates[] = $L1 * ($M - $SR + (2 - $N) * $D3) + $L2 * ($SR + ($N - 1) * $D3);
    }

    return min($candidates);
}

const PARENS = ['(', ')'];
const BRACKETS = ['[', ']'];
echo '@ints = ';
$ints = json_decode(str_replace(PARENS, BRACKETS, fgets(STDIN)));
echo '$x = ';
$x = +fgets(STDIN);
echo '$y = ';
$y = +fgets(STDIN);

echo solve($ints, $x, $y);

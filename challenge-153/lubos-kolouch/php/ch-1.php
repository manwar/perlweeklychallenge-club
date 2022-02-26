<?php

class LeftFactCalculator {

    public function __construct() {
        # keep seen factorials in a cache to speed things up
        $this->fact_cache = [0 => 1];
        $this->left_fact_cache = [0 => 0];
    }

    public function calculate_factorial(int $what) {

        if (array_key_exists($what, $this->fact_cache)) {
            return $this->fact_cache[$what];
        }

        # let's utilize the fact that we are processing the numbers in sequence
        $this->fact_cache[$what] = $what * $this->fact_cache[$what - 1];

        return $this->fact_cache[$what];
    }

    public function calculate_left_fact(int $what) {

        if (array_key_exists($what, $this->left_fact_cache)) {
            return $this->left_fact_cache[$what];
        }

        # let's utilize the fact that we are processing the numbers in sequence
        $this->left_fact_cache[$what] = $this->calculate_factorial($what - 1) + $this->left_fact_cache[$what - 1];

        return $this->left_fact_cache[$what];
    }

    public function get_left_factorial(int $what) {

        $output = [];

        foreach (range(1, $what) as $i) {
            $output[] =  $this->calculate_left_fact($i);
        }

        return $output;
    }
}

$calculator = new LeftFactCalculator();
array_diff($calculator->get_left_factorial(10), [
        1,
        2,
        4,
        10,
        34,
        154,
        874,
        5914,
        46234,
        409114,
    ]) == [] or throw new Exception("Failed test 1");

?>

<?php

function sign_of_product(array $ints)
{
    return array_reduce($ints, fn($acc, $current) => $acc * gmp_sign($current), 1);
}

echo 'The sign of the product is ' . sign_of_product(array_slice($argv, 1));

#! /usr/bin/env raku

# Kronecker Product
# https://wikiless.org/wiki/Kronecker_product

use Math::Matrix :ALL;

put MM [[1,2],
        [3,4]] ⊗ MM [[5,6],
                     [7,8]]

my &fun = { @^ints.pairs.first({ .key % 10 == .value }, :k) // -1 };

#`{
- Make use of the implicit signature feature with the @^ twigil
    - A signature `-> @ints` is automatically generated under the hood
    - So we have a function accepting a single positional Positional argument :)

- We'd like to reach the indexes as well as the values of the array passed
    - There are many ways to this end -- `.kv`, `.pairs` are the primary candidates
    - Since we are looking a "first", and it takes values off of the iterable 1-by-1
      unlike `map` can do more, we either need `.kv.batch(2)` or `.pairs`
    - I went for `.pairs` as it is a bit clearer I think

- We now have a stream (a Sequence) of pairs coming into `.first`
    - .key's of the pairs are 0, 1, 2... and .value's are the elements of @^ints

- Then we check if index modulo 10 is equal to the element itself
    - `.first` will find the first such "thing"
    - How that "thing" is presented can be adjusted with "adverb"s
        - We want the *index* of the first occurence (if any), so we use the `:k` adverb
        - "k" for key; the default is `:v` for the value itself (`:kv` and `:p` are also available)

- We are almost done -- what if no such index exists to satisfy `.first`?
    - Then `.first` returns `Nil`, and we need to detect it and return -1 instead
    - Since `.first(:k, ...)` either returns 0, 1, 2... or Nil, we can check for "defined"ness
    - In case of an undefined value out of `.first(:k)`, we return -1 via the "defined or" `//` operator
}

use Test;
my @tests of Pair =
    (0, 1, 2) => 0,
    (4, 3, 2, 1) => 2,
    (1, 2, 3, 4, 5, 6, 7, 8, 9, 0) => -1;

for @tests -> (:key($input), :value($expected-output)) {
    ok fun($input) eqv $expected-output;
    LAST done-testing;
}

//
// Challenge:
//
//   You are given a positive number $N.
//
//   Write a script to count the total numbrer of set bits of the binary
//   representations of all numbers from 1 to $N and return
//   $total_count_set_bit % 1000000007.
//
// https://perlweeklychallenge.org/blog/perl-weekly-challenge-079/
//

//
// This is A000778 (https://oeis.org/A000788). There's a recursive formala
// for the number of bits in the binary representation of 0 .. $N:
//
//    bits (0)         = 0
//    bits (2 * N)     =     bits (N) + bits (N - 1) + N
//    bits (2 * N + 1) = 2 * bits (N)                + N + 1
//

//
// Create an interface to read from STDIN
//
const rl = require ('readline') . createInterface ({
    input:  process . stdin,
});

//
// Read lines of input, calculate the result, and print it.
//
rl . on ('line', (line) => {
    console . log (bits (+line));  // Unary + numifies
});


//
// Recursive function to calculate the results (see above).
// 
let cache = [];
function bits (n) {
    if (n == 0) {
        return 0;
    }

    if (!cache [n]) {
        let half = Math . floor (n / 2);
        cache [n] = bits (half) + half + 
                      (n % 2 ? bits (half) + 1 : bits (half - 1));
    }
    return cache [n];
}


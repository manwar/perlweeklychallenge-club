#!/bin/env raku

#`[
    Perl weekly chanllege 114, Task #2 Higher Integer Set Bits

    You are given a positive integer $N.
    Write a script to find the next higher integer having the same number of 1 bits in binary representation as $N.

    Example

    Input: $N = 3
    Output: 5

    Binary representation of $N is 011. There are two 1 bits. So the next higher integer is 5 having the same the number of 1 bits i.e. 101.

    Input: $N = 12
    Output: 17

    Binary representation of $N is 1100. There are two 1 bits. So the next higher integer is 17 having the same number of 1 bits i.e. 10001.
#]

my method bits-number(UInt:D $n: --> UInt:D) { $n.base(2).comb.grep(1).elems }
my method has-bits(UInt:D $n: UInt:D $bits --> Bool:D) { $n.&bits-number == $bits }

sub MAIN(UInt:D $N) {
    put ($N ^.. *).grep(*.&has-bits($N.&bits-number))[0];
}

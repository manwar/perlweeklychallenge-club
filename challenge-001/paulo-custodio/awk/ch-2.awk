#!/usr/bin/gawk

# Challenge 001
#
# Challenge #2
# Write a one-liner to solve the FizzBuzz problem and print the numbers 1
# through 20. However, any number divisible by 3 should be replaced by the word
# 'fizz' and any divisible by 5 by the word 'buzz'. Those numbers that are both
# divisible by 3 and 5 become 'fizzbuzz'.

BEGIN {
    num = ARGV[1] ? ARGV[1] : 20;
    for (i=1; i<=num; i++)
        print (i%15)==0 ? "fizzbuzz" : (i%3)==0 ? "fizz" : (i%5)==0 ? "buzz" : i;
    exit 0;
}

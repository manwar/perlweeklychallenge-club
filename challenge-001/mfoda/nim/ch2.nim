#[
    Write a one-liner to solve the FizzBuzz problem and print the numbers 1 through 20. 
    However, any number divisible by 3 should be replaced by the word ‘fizz’ and any divisible by 5 by the word ‘buzz’. 
    Those numbers that are both divisible by 3 and 5 become ‘fizzbuzz’.
]#

import strutils

var result: seq[string]
for i in 1..20:
    let 
        div3 = i mod 3 == 0
        div5 = i mod 5 == 0
    if div3: result &= "fizz"
    if div5: result &= "buzz"
    if not div3 and not div5: result &= $i
        
echo result.join
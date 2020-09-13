#!/usr/bin/env perl6
# 
#
#     your_pasta_lies_add_up.raku
#
#     TASK #1 › Fibonacci Sum
#     Submitted by: Mohammad S Anwar
#     You are given a positive integer $N.
# 
#     UPDATE: 2020-09-07 09:00:00
#     Write a script to find out all possible combination of Fibonacci Numbers
#     required to get $N on addition.
# 
#     You are NOT allowed to repeat a number. Print 0 if none found.
# 
# 
#     Example 1:
#         Input: $N = 6
#     
#         Output: 3 as (1 + 2 + 3 = 6)
# 
#     Example 2:
#         Input: $N = 9
#     
#         Output: 2 as (1 + 8 = 9)
#
#
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN (Int $target = 9998) ;

## make a fib sequence up to the target
my @fib = 0, 1 ;
while @fib.tail(2).sum <= $target {
    @fib.push: @fib.tail(2).sum ;
}

## remove F(0), F(1) -- we choose to exclude these values
@fib .= tail(*-2);

## race runs the grep on 8 cores in batches of 200, for about a 4x speedup
my @output = @fib.combinations.race:8degree:200batch.grep( *.sum == $target );


say "target: $target";
say "found ", @output.elems, " solutions:\n";
(.join: ' + ').say for @output.sort;












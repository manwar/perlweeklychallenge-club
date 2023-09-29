# Challenge # 236 Task 2, Array Loops
>
## Table of Contents
[Submitted By: Mark Anderson](#submitted-by-mark-anderson)  
[The Challenge](#the-challenge)  
[Example 1](#example-1)  
[Example 2](#example-2)  
[Example 3](#example-3)  
[The Solution](#the-solution)  
[AUTHOR](#author)  
[LICENCE AND COPYRIGHT](#licence-and-copyright)  

----
# Submitted By: Mark Anderson
# The Challenge
You are given an array of unique integers.

Write a script to determine how many loops are in the given array.

> **To determine a loop: Start at an index and take the number at array[index] and then proceed to that index and continue this until you end up at the starting index.**  


## Example 1
```
Input: @ints = (4,6,3,8,15,0,13,18,7,16,14,19,17,5,11,1,12,2,9,10)
Output: 3

To determine the 1st loop, start at index 0, the number at that index is 4,
proceed to index 4, the number at that index is 15, proceed to index 15 and so
on until you're back at index 0.

Loops are as below:
[4 15 1 6 13 5 0]
[3 8 7 18 9 16 12 17 2]
[14 11 19 10]


```
## Example 2
```
Input: @ints = (0,1,13,7,6,8,10,11,2,14,16,4,12,9,17,5,3,18,15,19)
Output: 6

Loops are as below:
[0]
[1]
[13 9 14 17 18 15 5 8 2]
[7 11 4 6 10 16 3]
[12]
[19]

```
## Example 3
```
Input: @ints = (9,8,3,11,5,7,13,19,12,4,14,10,18,2,16,1,0,15,6,17)
Output: 1

Loop is as below:
[9 4 5 7 19 17 15 1 8 12 18 6 13 2 3 11 10 14 16 0]

```
# The Solution




```
    1| subset UniqueIntArray of Array where .elems == 0 ||
    2|                                      .unique.elems == .elems and .all ~~ IntStr;
    3| 
    4| multi MAIN (*@input where .all ~~ Int &&
    5|                           .unique.elems == .elems,
    6|         ) {
    7|     my Int @ints        = @input>>.Int;
    8|     my Int $num-elems   = @ints.elems;
    9|     my Int $start-index = 0;
   10|     my Int $cur-index   = $start-index;
   11| 
   12|     my UniqueIntArray $cur-loop;
   13|     my UniqueIntArray @all-loops;
   14| 
   15|     LOOP:
   16|     while $start-index.defined {
   17|         my $cur-value  = @ints[$cur-index];
   18|         my $next-index = $cur-value;
   19| 
   20|         $cur-loop.push: $cur-value;
   21|         @ints[$cur-index] = Nil;
   22| 
   23| 
   24|         given $next-index {
   25| 
   26|             when * ≥ $num-elems {
   27|                 @all-loops.push: for $cur-loop;
   28|             }
   29| 
   30|             when $start-index {
   31|                 @all-loops.push: $cur-loop;
   32|             }
   33| 
   34|             default {
   35|                 $cur-index = $cur-value;
   36|                 next LOOP;
   37|             }
   38|         } 
   39| 
   40|         $cur-loop = [];
   41|         $start-index = $cur-index = @ints.first(*.defined, :k);
   42| 
   43|     } 
   44| 
   45| 
   46|     say @all-loops.elems;
   47| } 

```




# AUTHOR
Shimon Bollinger (deoac.shimon@gmail.com)

Source can be located at: https://github.com/deoac/... . Comments and Pull Requests are welcome.

# LICENCE AND COPYRIGHT
© 2023 Shimon Bollinger. All rights reserved.

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See [perlartistic](http://perldoc.perl.org/perlartistic.html).

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.





```
   48| multi MAIN (Bool :$test!) {
   49|     use Test;
   50| 
   51|     my @tests = [
   52|         %{ got => '', op => 'eq', expected => '', desc => 'Example 1' },
   53|     ];
   54| 
   55|     for @tests {
   56|     } 
   57| } 
   58| 
   59| my %*SUB-MAIN-OPTS =
   60|   :named-anywhere,             
   61|   :bundling,                   
   62|   :allow-no,                   
   63|   :numeric-suffix-as-value,    
   64| ;
   65| 
   66| multi MAIN(Bool :$doc!, Str :$format = 'Text') {
   67|     run $*EXECUTABLE, "--doc=$format", $*PROGRAM;
   68| } 

```






----
Rendered from  at 2023-09-29T00:30:04Z

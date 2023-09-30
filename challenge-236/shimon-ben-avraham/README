# The Perl Weekly Challenge
>Submitted By: Mark Anderson


## Table of Contents
[Challenge #236 Task 2, Array Loops](#challenge-236-task-2-array-loops)  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Example 1](#example-1)  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Example 2](#example-2)  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Example 3](#example-3)  
[The Solution](#the-solution)  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[The Basic Algorithm](#the-basic-algorithm)  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Initialize variables](#initialize-variables)  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[The Main Loop](#the-main-loop)  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Print and return the number of loops found.](#print-and-return-the-number-of-loops-found)  
[Sample run with debug prints](#sample-run-with-debug-prints)  
[AUTHOR](#author)  
[LICENCE AND COPYRIGHT](#licence-and-copyright)  

----
## Challenge #236 Task 2, Array Loops
You are given an array of unique integers.

Write a script to determine how many loops are in the given array.

> **To determine a loop: Start at an index and take the number at array[index] and then proceed to that index and continue this until you end up at the starting index.**  


### Example 1
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
### Example 2
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
### Example 3
```
Input: @ints = (9,8,3,11,5,7,13,19,12,4,14,10,18,2,16,1,0,15,6,17)
Output: 1

Loop is as below:
[9 4 5 7 19 17 15 1 8 12 18 6 13 2 3 11 10 14 16 0]

```
## The Solution




### The Basic Algorithm
We will create a pointer to the first index of the array and attempt to find a loop that starts with that element.

It's important to remember that each element can be a part of only _one_ loop, even if it is a loop by itself.

Every time we find an element, we will push it to a current-loop array and set the element to `Nil` so that we don't use it again.

If we find a loop[ 1 ], we will push it to an array of loops. Note that a loop can consist of a single element. After we find a loop, we will move the start pointer to the next defined element and try again.

First we will only accept input that is a list of unique integers.





```
    1| multi MAIN (#| A list of unique integers
    2|             *@input where .all ~~ Int &&
    3|                           .unique.elems == .elems,
    4|         ) {

```




### Initialize variables




```
    5|     my Int @ints          = @input>>.Int;
    6|     my Int $num-elems     = @ints.elems;
    7|     my Int $start-pointer = 0;
    8|     my Int $cur-index     = $start-pointer;

```




The current loop we are working on is stored in `@cur-loop`. The list of all found loops is stored in `@all-loops`.





```
    9|     my @cur-loop  = [];
   10|     my @all-loops = [];

```




### The Main Loop
As long as there is a defined element in the array, `$start-pointer`, we will try to find a loop that starts with that element.





```
   11|     INDEX:
   12|     while $start-pointer.defined {

```




We get the value of the current element and use it as the index of the next element in the loop.





```
   13|         my $cur-value  = @ints[$cur-index];
   14|         my $next-index = $cur-value;

```




Each value we are looking at gets pushed to the current loop array and set to `Nil` so that we don't use it again.





```
   15|         @cur-loop.push: $cur-value;
   16|         @ints[$cur-index] = Nil;

```




At this point there are three possibilities:





```
   17|         given $next-index {

```




*  We have reached an index that is greater than the number of elements in the original array.

Thus, we have found a loop that is not closed. Each element we've found so far is a loop by itself. So we push each element to the list of all loops.





```
   18|             when * ≥ $num-elems {
   19|                 @all-loops.push: $_ for @cur-loop;
   20|             } 

```




*  We have found a closed loop

When the next index is the same as the start pointer, we have found a closed loop. We push the current loop to the list of all loops.





```
   21|             when $start-pointer {
   22|                 @all-loops.push: @cur-loop.clone;
   23|             } 

```




*  We have found a value that is not in the current loop.

So we continue looking for the next element in the loop by updating the current index.





```
   24|             default {
   25|                 $cur-index = $cur-value;
   26|                 next INDEX;
   27|             } 
   28| 
   29|         } 

```




At this point we have found a loop or single-item loop[s]. We need to find the next start pointer by looking for the next defined element in the array.





```
   30|         @cur-loop = [];
   31|         $start-pointer = $cur-index = @ints.first(*.defined, :k);
   32| 
   33|     } 
   34| 

```




### Print and return the number of loops found.




```
   35|     say @all-loops.elems;
   36| 
   37|     return @all-loops.elems;
   38| } 

```




## Sample run with debug prints
(The option `--verbose` and the debug print statements are not shown in the above code.)

```
$ ./ch-2.raku --verbose 1 0 8 5 4 3 9

Array[Int] @ints = Array[Int].new(Int, 0, 8, 5, 4, 3, 9)
Int $start-pointer = 0
Int $cur-index = 0
Int $next-index = 1
Int $cur-value = 1
Array @cur-loop = [1]
Continuing loop: 1
Array[Int] @ints = Array[Int].new(Int, Int, 8, 5, 4, 3, 9)
Int $start-pointer = 0
Int $cur-index = 1
Int $next-index = 0
Int $cur-value = 0
Array @cur-loop = [1, 0]
Found a loop: 1 0

Starting new loop at index 2
Array[Int] @ints = Array[Int].new(Int, Int, Int, 5, 4, 3, 9)
Int $start-pointer = 2
Int $cur-index = 2
Int $next-index = 8
Int $cur-value = 8
Array @cur-loop = [8]
Found single-item loop[s]: [8]

Starting new loop at index 3
Array[Int] @ints = Array[Int].new(Int, Int, Int, Int, 4, 3, 9)
Int $start-pointer = 3
Int $cur-index = 3
Int $next-index = 5
Int $cur-value = 5
Array @cur-loop = [5]
Continuing loop: 5
Array[Int] @ints = Array[Int].new(Int, Int, Int, Int, 4, Int, 9)
Int $start-pointer = 3
Int $cur-index = 5
Int $next-index = 3
Int $cur-value = 3
Array @cur-loop = [5, 3]
Found a loop: 5 3

Starting new loop at index 4
Array[Int] @ints = Array[Int].new(Int, Int, Int, Int, Int, Int, 9)
Int $start-pointer = 4
Int $cur-index = 4
Int $next-index = 4
Int $cur-value = 4
Array @cur-loop = [4]
Found a loop: 4

Starting new loop at index 6
Array[Int] @ints = Array[Int].new(Int, Int, Int, Int, Int, Int, Int)
Int $start-pointer = 6
Int $cur-index = 6
Int $next-index = 9
Int $cur-value = 9
Array @cur-loop = [9]
Found single-item loop[s]: [9]


All loops:
1 0
8
5 3
4
9

Number of loops: 5

```




# AUTHOR
Shimon Bollinger (deoac.shimon@gmail.com)

Comments and Pull Requests are welcome.

# LICENCE AND COPYRIGHT
© 2023 Shimon Bollinger. All rights reserved.

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See [perlartistic](http://perldoc.perl.org/perlartistic.html).

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

----
###### 1 A 'loop' is defined as a list of array element values, not a list of the array's indices.

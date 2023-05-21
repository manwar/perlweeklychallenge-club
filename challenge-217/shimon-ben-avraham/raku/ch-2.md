TITLE
=====



Task 2: Max Number
------------------

SUBTITLE
========



Submitted by: Mohammad S Anwar
------------------------------

CHALLENGE
=========



You are given a list of positive integers. Write a script to concatenate the integers to form the highest possible value.
-------------------------------------------------------------------------------------------------------------------------

### Example 1:

    Input: @list = (1, 23)

    Output: 231

### Example 2:

    Input: @list = (10, 3, 2)

    Output: 3210

### Example 3:

    Input: @list = (31, 2, 4, 10)

    Output: 431210

### Example 4:

    Input: @list =   (5, 15, 4, 123, 2)

    Output: 542111

### Example 5:

    Input: @list = (1, 10)

    Output: 110

SOLUTION
========



```raku
  1| use v6.*;
  2| 
  3| sub max-number-cmp (UInt:D $a, UInt:D $b --> Order:D) {
  4|     my @a=$a.comb; 
  5|     my @b=$b.comb; 
  6|     my $l = max(+@a, +@b); 
  7|     for ^$l -> $i {  
  8|         my $a = @a[$i] // @a[$i-1];
  9|         my $b = @b[$i] // @b[$i-1];
 10|         return $b <=> $a unless $a == $b;
 11|     } 
 12|     return Same;
 13| } 
 14| 
 15| sub max-number (@list where .all ~~ UInt --> UInt) {
 16|    return @list.sort(&max-number-cmp).join.UInt;
 17| } 
 18| 
 19| multi MAIN (:$test!) {
 20|     use Test;
 21| 
 22|     my @tests = [
 23|         %{ input => (1, 23),          output => 231,    text => 'Example 1' },
 24|         %{ input => (10, 3, 2),       output => 3210,   text => 'Example 2' },
 25|         %{ input => (31, 2, 4, 10),   output => 431210, text => 'Example 3' },
 26|         %{ input => (5, 11, 4, 1, 2), output => 542111, text => 'Example 4' },
 27|         %{ input => (1, 10),          output => 110,    text => 'Example 5' },
 28|     ];
 29| 
 30|     for @tests {
 31|         is max-number( .<input> ), .<output>, .<text>;
 32|     } # end of for @tests
 33| } # end of multi MAIN (:$test! )
```

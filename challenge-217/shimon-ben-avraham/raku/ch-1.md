```raku

```

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

    Input: @list = (5, 11, 4, 1, 2)

    Output: 542111

### Example 5:

    Input: @list = (1, 10)

    Output: 110

SOLUTION
========



```raku
  1| use v6.*;
  2| 
  3| sub max-number (@list where .all ~~ UInt) {
  4|    my UInt $retval = 0; 
  5| 
  6|    return $retval
  7| } 
  8| 
  9| multi MAIN (:$test! ) {
 10|     use Test;
 11| 
 12|     my @tests = [
 13|         %{ input => (1, 23),          output => 231,    text => 'Example 1' },
 14|         %{ input => (10, 3, 2),       output => 3210,   text => 'Example 2' },
 15|         %{ input => (31, 2, 4, 10),   output => 431210, text => 'Example 3' },
 16|         %{ input => (5, 11, 4, 1, 2), output => 542111, text => 'Example 4' },
 17|         %{ input => (1, 10),          output => 110,    text => 'Example 5' },
 18|     ];
 19| 
 20|     for @tests {
 21|         is max-number( .<input> ), .<output>, .<text>;
 22|     } # end of for @tests
 23| } # end of multi MAIN (:$test! )
```

# Weekly Challenge #250

### Task 2: Alphanumeric String Value
**Submitted by: Mohammad S Anwar**

You are given an array of alphanumeric strings.

Write a script to return the maximum value of alphanumeric string in the given array.

The value of alphanumeric string can be defined as
```
a) The numeric representation of the string in base 10 if it is made up of digits only.
b) otherwise the length of the string
```

##### Example 1
```
Input: @alphanumstr = ("perl", "2", "000", "python", "r4ku")
Output: 6

"perl" consists of letters only so the value is 4.
"2" is digits only so the value is 2.
"000" is digits only so the value is 0.
"python" consits of letters so the value is 6.
"r4ku" consists of letters and digits so the value is 4.
```

##### Example 2
```
Input: @alphanumstr = ("001", "1", "000", "0001")
Output: 1
```
---

### Solution

We'll use a [map](https://docs.raku.org/type/Any#routine_map) block to process each string in @alphanumstr.

If the string only consists of characters "0".."9" then [parse-base](https://docs.raku.org/type/Str#routine_parse-base)(10) will return its numeric equivalent - otherwise [chars](https://docs.raku.org/type/Str#routine_chars) will return the string's character count.
These return values are returned from map as a [Seq](https://docs.raku.org/type/Seq).

Finally, we use [max](https://docs.raku.org/type/Any#routine_max) to return the max element in that sequence.

Note the [//](https://docs.raku.org/language/5to6-perlop#Logical_Defined-Or) operator instead of the [||](https://docs.raku.org/language/operators#infix_||) operator. The // operator tests if the result from parse-base is defined. || tests whether the value is True. If we used || then our map block would incorrectly return the character count for any string that evaluates to 0 such as "000".parse-base(10) because 0 evaluates to False in a [Boolean context](https://docs.raku.org/language/contexts#Boolean).

Putting it all together:

    max map { .parse-base(10) // .chars }, @alphanumstr

[The full program](https://github.com/manwar/perlweeklychallenge-club/blob/master/challenge-250/mark-anderson/raku/ch-2.raku)

Thank you for reading my solution to the [Weekly Challenge #250 Task #2](https://theweeklychallenge.org/blog/perl-weekly-challenge-250/)

*-Mark Anderson*

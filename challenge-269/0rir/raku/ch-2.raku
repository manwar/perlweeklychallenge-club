#!/usr/bin/env raku
#    :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d; use Test; 

=begin comment

This spec is questionable regarding the reduction of @ints to an empty
array.  Step 2 indicates preservation, which is contradicted by the following
rule;  a trivial change in Raku.

269-2: Distribute Elements    Submitted by: Mohammad Sajid Anwar  (Edited)

You are given an array of distinct integers, @ints.

Write a script to distribute the elements as described below:

1) Put @ints[0] into @arr1.
2) Put @ints[1] into @arr2.

Then follow the rule: If @arr1.tail > @arr2.tail then add @ints[0] to
@arr1 otherwise to @arr2.

When done distribution, return the concatenated arrays. @arr1 and @arr2.

Example 1
Input: @ints = (2, 1, 3, 4, 5)
Output: (2, 3, 4, 5, 1)

1st operation:
Add 1 to @arr1 = (2)

2nd operation:
Add 2 to @arr2 = (1)

3rd operation:
Now the last element of @arr1 is greater than the last element
of @arr2, add 3 to @arr1 = (2, 3).

4th operation:
Again the last element of @arr1 is greate than the last element
of @arr2, add 4 to @arr1 = (2, 3, 4)

5th operation:
Finally, the last element of @arr1 is again greater than the last
element of @arr2, add 5 to @arr1 = (2, 3, 4, 5)

Mow we have two arrays:
@arr1 = (2, 3, 4, 5)
@arr2 = (1)

Concatenate the two arrays and return the final array: (2, 3, 4, 5, 1).
Example 2
Input: @ints = (3, 2, 4)
Output: (3, 4, 2)

1st operation:
Add 1 to @arr1 = (3)

2nd operation:
Add 2 to @arr2 = (2)

3rd operation:
Now the last element of @arr1 is greater than the last element
of @arr2, add 4 to @arr1 = (3, 4).

Mow we have two arrays:
@arr1 = (3, 4)
@arr2 = (2)

Concatenate the two arrays and return the final array: (3, 4, 2).
Example 3
Input: @ints = (5, 4, 3 ,8)
Output: (5, 3, 4, 8)

1st operation:
Add 1 to @arr1 = (5)

2nd operation:
Add 2 to @arr2 = (4)

3rd operation:
Now the last element of @arr1 is greater than the last element
of @arr2, add 3 to @arr1 = (5, 3).

4th operation:
Again the last element of @arr2 is greate than the last element
of @arr1, add 8 to @arr2 = (4, 8)

Mow we have two arrays:
@arr1 = (5, 3)
@arr2 = (4, 8)

Concatenate the two arrays and return the final array: (5, 3, 4, 8).

=end comment

my @Test =
    [],  [],
    [0], [0],
    [1], [1],
    [1,2], [1,2],
    [5, 4, 3, 8],       [5, 3, 4, 8],
    [3, 2, 4],          [3, 4, 2],
    [2, 1, 3, 4, 5],    [2, 3, 4, 5, 1],
;

plan @Test ÷ 2;

multi func( [] ) { []}
multi func( @a is copy  where +@a ≤ 1 ) { @a }

multi func( @a is copy  where @a ~~ @a.unique -->Array) {
    $_ := @a;
    my @l .push: .shift;
    my @r .push: .shift;
    while @a { ( @l.tail > @r.tail  ?? @l !! @r ).push: .shift; }
    @l.append: @r;
}

for @Test -> @in, @exp {
    is func(@in), @exp, "@exp.raku() <- @in.raku()";
}
done-testing;

my @x = [2, 1, 3, 7, 30, 4, 9, -100,  5];

say "\nInput: @int = @x.raku()\nOutput: &func( @x).raku()";

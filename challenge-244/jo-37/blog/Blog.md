# Smaller Heroes

## Task 1: Count Smaller
**Submitted by: Mohammad S Anwar**

---
You are given an array of integers.

Write a script to calculate the number of integers smaller than the integer at each index.

### Example 1
```
Input: @int = (8, 1, 2, 2, 3)
Output: (4, 0, 1, 1, 3)

For index = 0, count of elements less 8 is 4.
For index = 1, count of elements less 1 is 0.
For index = 2, count of elements less 2 is 1.
For index = 3, count of elements less 2 is 1.
For index = 4, count of elements less 3 is 3.
```
### Example 2
```
Input: @int = (6, 5, 4, 8)
Output: (2, 1, 0, 3)
```
### Example 3
```
Input: @int = (2, 2, 2)
Output: (0, 0, 0)
```
---
### Solution
The number of integers smaller than a member of a list is just the number's statistical rank reduced by 1.
Similar rank calculations have already been done in task 2 from week 9 and in task 1 from week 214.
Taking a different approach here.

The module `List::Rank` has a `rank` subroutine that can be used with a little post processing:

 1. Equal scores an equal sign appended to their rank that needs to be removed.
 2. The rank is one more than the number of smaller values in the list.

This leads to a very terse implementation:
```
sub count_smaller {
	map tr/=//dr - 1, rank @_;
}
```
## Task 2: Group Hero
**Submitted by: Mohammad S Anwar**

---

You are given an array of integers representing the strength.

Write a script to return the sum of the powers of all possible combinations; power is defined as the square of the largest number in a sequence, multiplied by the smallest.

### Example 1
```
Input: @nums = (2, 1, 4)
Output: 141

Group 1: (2) => square(max(2)) * min(2) => 4 * 2 => 8
Group 2: (1) => square(max(1)) * min(1) => 1 * 1 => 1
Group 3: (4) => square(max(4)) * min(4) => 16 * 4 => 64
Group 4: (2,1) => square(max(2,1)) * min(2,1) => 4 * 1 => 4
Group 5: (2,4) => square(max(2,4)) * min(2,4) => 16 * 2 => 32
Group 6: (1,4) => square(max(1,4)) * min(1,4) => 16 * 1 => 16
Group 7: (2,1,4) => square(max(2,1,4)) * min(2,1,4) => 16 * 1 => 16

Sum: 8 + 1 + 64 + 4 + 32 + 16 + 16 => 141
```
---
### Preliminary Considerations
The concept of a "combination" is based on a set of distinct objects.
So the question arises, how to deal with non-unique strengths.
There is more the one way to do it:

  1. Require unique values.
  2. Consider the strengths as "multi-sets".
  3. Consider a set of unique elements having a "strength" property that need not be unique.

The first would be too simple. The second and third have substantial differences:

Consider the multi-set `[a, a, b]`. The sub-multi-sets thereof are:
```
[], [a], [b], [a, a], [a, b], [a, a, b]
```
Compare it with a set of uniquely indexed elements `{0:a, 1:a, 2:b}` having these subsets:
```
{}, {0:a}, {1:a}, {2:b}, {0:a, 1:a}, {0:a, 2:b}, {1:a, 2:b}, {0:a, 1:a, 2:b}
```
The "sets of combinations" are basically different and would lead to different results for this task.
The task's wording mentions "heroes" having a certain "strength" which suggests to look at it in the third way.

### Solution
At first glance it looks like we need to loop over all (nonempty) combinations of the given list of strengths, resulting in a complexity of `O(2^L)` with L as the length of the list.

But this is not necessary: From each combination we need only the smallest and the largest elements.
By picking two elements `nums[i]` and `nums[k]` (where `i <= k`) from the **sorted list**, we find all `L * (L + 1) / 2` pairs of minimum and maximum.
Regardless of which elements come between them from the sorted list, the group power will always be the same.
All we need to know is the number of combinations having the selected elements as "borders".

If the offset `offs = k - i` is positive, then there are `offs - 1` elements between min and max, resulting in `2^(offs - 1)` combinations.
If `i` equals `k`, then there is only one singleton combination.

Thus we may find the sum over the powers in a complexity of `O(L^2)`.

Consider a list of 64 elements.
It has `2^64 (~ 1.8E19)` combinations that are practical impossible to enumerate, while it is easy to calculate the sum of the powers in `64 * 65 / 2 = 2080` iterations.
Though the sum will become large, this is not a problem when `bigint` is in effect and it will be calculated in an instant.

#### Example:
Let `@nums = (2, 3, 5, 7)`. For the total sum of powers, each power needs to be multiplied with the number of corresponding combinations (columns "count" and "power").

| min | max | offs |count| combinations                  | power |
|-----|-----|------|-----|-------------------------------|-------|
|   2 |   2 |    0 |   1 |(2)                            |     8 |
|   2 |   3 |    1 |   1 |(2,3)                          |    18 |
|   2 |   5 |    2 |   2 |(2,5),(2,3,5)                  |    50 |
|   2 |   7 |    3 |   4 |(2,7),(2,3,7),(2,5,7),(2,3,5,7)|    98 |
|   3 |   3 |    0 |   1 |(3)                            |    27 |
|   3 |   5 |    1 |   1 |(3,5)                          |    75 |
|   3 |   7 |    2 |   2 |(3,7),(3,5,7)                  |   147 |
|   5 |   5 |    0 |   1 |(5)                            |   125 |
|   5 |   7 |    1 |   1 |(5,7)                          |   245 |
|   7 |   7 |    0 |   1 |(7)                            |   343 |

```
number of iterations: (4 * 5) / 2 = 10
sum: 1 * 8 + 1 * 18 + 2 * 50 + 4 * 98 + 1 * 27 + 1 * 75 + 2 * 147 + 1 * 125 + 1 * 245 + 1 * 343 = 1627
```
#### Implementation
We take the first element of the sorted list as the current minimum and loop over the whole list for the current maximum.
Afterwards we remove the first element and continue with the next minimum.
Maximum and offset may be retrieved simultaneously by calling `each` on the array.
The minimum and maximum define the power of all corresponding combinations and from the offset we find the number of combinations.
```
sub total_power {
    my @s = sort {$a <=> $b} @_;
    my $power;
    while (defined (my $min = $s[0])) {
        while (my ($offs, $max) = each @s) {
            $power += $min * $max**2 * ($offs ? 2**($offs - 1) : 1);
        }
    } continue {
        shift @s;
    }

    $power;
}

```
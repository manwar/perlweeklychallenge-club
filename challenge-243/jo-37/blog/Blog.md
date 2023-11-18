# Count the Pairs on the Floor

## Task 1: Reverse Pairs
**Submitted by: Mohammad S Anwar**

---

You are given an array of integers.

Write a script to return the number of reverse pairs in the given array.

A reverse pair is a pair `(i, j)` where:
a) `0 <= i < j < nums.length` and
b) `nums[i] > 2 * nums[j]`.

### Example 1
```
Input: @nums = (1, 3, 2, 3, 1)
Output: 2

(1, 4) => nums[1] = 3, nums[4] = 1, 3 > 2 * 1
(3, 4) => nums[3] = 3, nums[4] = 1, 3 > 2 * 1
```
### Example 2
```
Input: @nums = (2, 4, 3, 5, 1)
Output: 3

(1, 4) => nums[1] = 4, nums[4] = 1, 4 > 2 * 1
(2, 4) => nums[2] = 3, nums[4] = 1, 3 > 2 * 1
(3, 4) => nums[3] = 5, nums[4] = 1, 5 > 2 * 1
```
---
### Solution
Using the Perl Data Language to solve this task.

First we create a 1-d long ndarray from the given numbers.
```
$nums = long 1, 3, 2, 3, 1;
```
Then we create a sequence in the same shape as `$nums`, i.e. a 1-d ndarray holding the column indices of `$nums` and a second sequence as a single column holding the row indices.
When combining these index ndarrays, according to PDL's broadcasting rules both will be extended by replicating along a dimension to fit each other.
For visualization, these replications may be performed explicitly:

A) Add a dummy dimension 1 to the row and replicate it five times.
```
say sequence(5)->dup(1, 5);
[
 [0 1 2 3 4]
 [0 1 2 3 4]
 [0 1 2 3 4]
 [0 1 2 3 4]
 [0 1 2 3 4]
]
```
B) Replicate dimension 0 of the column five times.
```
say sequence(1, 5)->dup(0, 5);
[
 [0 0 0 0 0]
 [1 1 1 1 1]
 [2 2 2 2 2]
 [3 3 3 3 3]
 [4 4 4 4 4]
]
```
Hence we get an upper right triangular matrix of ones when comparing the indices:
```
say sequence($nums) > sequence(1, $nums->dim(0));
[
 [0 1 1 1 1]
 [0 0 1 1 1]
 [0 0 0 1 1]
 [0 0 0 0 1]
 [0 0 0 0 0]
]
```
In the same manner we can compare `$nums` as a column with itself as a doubled row:
```
say $nums->dummy(0) > 2 * $nums
[
 [0 0 0 0 0]
 [1 0 0 0 1]
 [0 0 0 0 0]
 [1 0 0 0 1]
 [0 0 0 0 0]
]
```
The "bit and" of both matrices literally follows the definition of reverse pairs.
The sum over the and'ed matrices yields the total number of reverse pairs:
```
((sequence($nums) > sequence(1, $nums->dim(0)))
    & ($nums->dummy(0) > 2 * $nums))->sum;
```
## Task 2: Floor Sum
**Submitted by: Mohammad S Anwar**

---
You are given an array of positive integers (`>=1`).

Write a script to return the sum of `floor(nums[i] / nums[j])` where `0 <= i,j < nums.length`. The `floor()` function returns the integer part of the division.
### Example 1
```
Input: @nums = (2, 5, 9)
Output: 10

floor(2 / 5) = 0
floor(2 / 9) = 0
floor(5 / 9) = 0
floor(2 / 2) = 1
floor(5 / 5) = 1
floor(9 / 9) = 1
floor(5 / 2) = 2
floor(9 / 2) = 4
floor(9 / 5) = 1
```
### Example 2
```
Input: @nums = (7, 7, 7, 7, 7, 7, 7)
Output: 49
```
---
### Solution
Again, using PDL.

Creating a 1-d double ndarray from the given numbers:
```
$nums = pdl 2, 5, 9;
```
Divide `$nums` as row by `$nums` as column in the same manner as in task 1 and apply `floor()`:
```
say floor $nums / $nums->dummy(0);
[
 [1 2 4]
 [0 1 1]
 [0 0 1]
]
```
Finally, sum over this matrix:
```
floor($nums / $nums->dummy(0))->sum;
```
This works not only for positive integers but for all non-zero integers.

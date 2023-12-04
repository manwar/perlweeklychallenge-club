# Recurring Lotteries

## Task 1: 6 out of 49
**Submitted by: Andreas Voegele**

---
6 out of 49 is a German lottery.

Write a script that outputs six unique random integers from the range 1 to 49.

Output
```
3
10
11
22
38
49
```
---
### Solution
There is a trivial solution to this task using `List::MoreUtils::sample`:
```
sample 6, 1 .. 49;
```
Emulating a "lottery device" instead.
There is a pool of initially 49 numbered balls.
In every turn, one ball is selected randomly and removed from the pool.

The task description suggests the numbers being sorted in ascending order.
```
sub sixoutoffortynine {
	my @pool = (1..49);
    my @winning;
    push @winning, splice @pool, rand @pool, 1 for 1 .. 6;
    sort {$a <=> $b} @winning;
}
```
## Task 2: Linear Recurrence of Second Order
**Submitted by: Jörg Sommrey**

---
You are given an array @a of five integers.

Write a script to decide whether the given integers form a linear recurrence of second order with integer factors.

A linear recurrence of second order has the form

```
a[n] = p * a[n-2] + q * a[n-1] with n > 1

where p and q must be integers.
```
### Example 1
```
Input: @a = (1, 1, 2, 3, 5)
Output: true

@a is the initial part of the Fibonacci sequence a[n] = a[n-2] + a[n-1]
with a[0] = 1 and a[1] = 1.
```
### Example 2
```
Input: @a = (4, 2, 4, 5, 7)
Output: false

a[1] and a[2] are even. Any linear combination of two even numbers with integer factors is even, too.
Because a[3] is odd, the given numbers cannot form a linear recurrence of second order with integer factors.
```
### Example 3
```
Input: @a = (4, 1, 2, -3, 8)
Output: true

a[n] = a[n-2] - 2 * a[n-1]
```
---
### Solution
In the following an asterisk `*` denotes matrix multiplication as well as vector or scalar multiplication depending on the type of its operands.

From the formula
```
a[n] = p[0] * a[n-2] + p[1] * a[n-1]
```
and an initial sequence `a[0],...,a[3]` we need to derive the 'hidden' parameters `p[0]` and `p[1]`:
```
a[2] = a[0] * p[0] + a[1] * p[1]
a[3] = a[1] * p[0] + a[2] * p[1]
```
Using vectors and a matrix
```
a23 = (a[2])
      (a[3])
p = (p[0])
    (p[1])
M = (a[0], a[1])
    (a[1], a[2])
```
we may write:
```
a23 = M * p
```
#### Regular case
Suppose `M` is regular, i.e. `det(M) = a[0] * a[2] - a[1]^2 != 0`

Then `M` has an inverse matrix and we find:
```
p = inv(M) * a23
```
We need to check if:

  * all elements of `p` are integer and
  * the fifth element `a[4]` fits into the sequence.

The latter is the case if
```
a[4] = pT * a23
```
#### Degenerated case
Next we need to consider the degenerated case where `det(M) = 0`, i.e.
```
a[0] * a[2] = a[1]^2
```
Here the middle element `a[1]` is the geometric mean of its neighbors.
This is the characteristic property of a geometric sequence, which may be regarded as a linear recurrence of order 1:
```
a[n] = p[1] * a[n-1]
```
Suppose `a[1] != 0`.
Then we have `p[1] = a[2] / a[1]`.
The initial element `a[0]` becomes irrelevant and we need to check if

  * `p[1]` is integer and
  * the fourth and fifth elements `a[3]` and `a[4]` fit into the found geometric sequence.

#### Doubly degenerated case
Finally we have the case where the determinant of `M` is zero and `a[1] = 0`.  
From `a[0] * a[2] = a[1]^2` it follows, that `a[0]` or `a[2]` must be zero, too.
This means there are two neighboring zeroes in the sequence and thus we need to check if:

  * `a[2]`, `a[3]` and `a[4]` are all zero.
### Implementation
Using `PDL` it is not too complicated to implement the above steps. Furthermore they may
be extended to more than five numbers with little effort.
Some attention must be payed to comparing floating point numbers, though.
Therefore using `PDL`'s relaxed `approx` instead of `==`.
```
  1 use PDL;
  2 use PDL::NiceSlice;
  3 sub is_lin_recur_2 {
  4     my $a = pdl @_;
  5     my $m = cat $a(0:1), $a(1:2);
  6     if ($m->determinant) {
  7         my $p = $m->inv x $a(2:3)->transpose;
  8         return all(approx $p, $p->rint) &&
  9            all approx $a(4:), $p->transpose x cat $a(2:-3), $a(3:-2);
 10     }
 11     if ($a(1)) {
 12         my $p1 = $a(2) / $a(1);
 13         return approx($p1, $p1->rint) && all approx $a(3:), $p1 * $a(2:-2);
 14     }
 15     return all $a(2:) == 0;
 16 }
```
line 4: Create a `double` ndarray from the given numbers.  
line 5: Create the matrix `M` as the concatenation of two ndarray slices.  
line 6: The determinant of a matrix must be nonzero to be invertible.   
line 7: Multiply the inverse of `M` with the column vector `(a[2],  a[3])T` to find the parameters `p`.  
line 8: Check if `p` is integer.  
line 9: Check if the fifth to last element follow the recurrence defined by the initial four elements. For this purpose build a (L-4)x2 ndarray holding successive pairs from the given numbers starting with `(a[2], a[3])`, transform these with the recurrence relation and compare the result with the numbers themselves starting with `a[4]`.  
line 11: Here we have `a[0] * a[2] = a[1]^2`. We may divide by `a[1]` if it is not zero.  
line 12: `p1` is the factor in the geometric sequence.  
line 13: Check if `p1` is integer and if the fourth to last element follow the recurrence defined by the first three elements.  
line 15: Here the determinant is zero and `a[1]` is zero, too. Check if the third to last elements are all zero.  
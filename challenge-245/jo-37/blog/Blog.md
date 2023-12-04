# The Most Popular of Three

## Task 1: Sort Language
**Submitted by: Mohammad S Anwar**

---
You are given two array of languages and its popularity.

Write a script to sort the language based on popularity.

### Example 1
```
Input: @lang = ('perl', 'c', 'python')
       @popularity = (2, 1, 3)
Output: ('c', 'perl', 'python')
```
### Example 2
```
Input: @lang = ('c++', 'haskell', 'java')
       @popularity = (1, 3, 2)
Output: ('c++', 'java', 'haskell')
```
---
### Solution
Performing an index sort on the popularity and using the result as slice indices for the languages leads to a one-line solution:
```
sub sort_by_popularity ($lang, $p8y) {
	$lang->@[sort {$p8y->[$a] <=> $p8y->[$b]} 0 .. $p8y->$#*];
}

```

## Task 2: Largest of Three
**Submitted by: Mohammad S Anwar**

---
You are given an array of integers >= 0.

Write a script to return the largest number formed by concatenating some of the given integers in any order which is also multiple of 3. Return -1 if none found.

### Example 1
```
Input: @digits = (8, 1, 9)
Output: 981

981 % 3 == 0

```
### Example 2
```
Input: @digits = (8, 6, 7, 1, 0)
Output: 8760
```
### Example 3
```
Input: @digits = (1)
Output: -1
```
---

### Solution
Some considerations:

  * The largest number that can be formed from given digits has all the digits in descending order
  * Any number without leading zeroes is larger than any other number that has less digits.
  * A number is divisible by 3 if and only if the sum of its decimal digits is divisible by 3.

To form the largest number divisible by 3 from the given digits, we primarily must use the maximum number of digits and secondarily the largest digits.
Suppose we have `p = sum(d[i]) mod 3`.

  * If `p = 0` we may use all the given digits
  * If there are digits within the given set having `d = p mod 3`, we may drop the smallest of these digits to get the maximum number.
  * Otherwise there must be two or more digits having `d = -p mod 3`. We may drop the smallest two of these to get the maximum number.

If the remaining set of digits is not empty, the largest number is formed from the digits in descending order.
Otherwise there is no solution.

It turns out, that sorting the digits using a standard algorithm would
be the most expensive operation in this approach.  Thus using a specific
O(N) sort for a collection of decimal digits.

This results in the following implementation:
```
sub largest_of_three {
    my (@digits, @ind, $mod) = dsort(@_);
    for (0 .. $#digits) {
        # The digit modulo 3
        my $digit = $digits[$_] % 3;
        # Store indices of digits that are not a multiple of 3
        push $ind[$digit - 1]->@*, $_ if $digit;
        # Update the digit sum
        $mod += $digit;
    }
    $mod %= 3;
    # Delete the fewest smallest digits to obtain a digit sum
    # divisible by 3.
    delete @digits[
        !$mod-- ? () : $ind[$mod] ? $ind[$mod][0] : $ind[!$mod]->@[0, 1]
    ];

    # Build the maximum number from the remaining digits in descending
    # order or fail.
    @digits ? 0 + join '', reverse grep defined, @digits : -1;
}

sub dsort {
    my @digits;
    $digits[$_]++ for @_;
    map +($_) x ($digits[$_] // 0), 0 .. 9;
}

```

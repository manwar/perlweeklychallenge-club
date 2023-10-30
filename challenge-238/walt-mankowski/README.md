Solutions by Walt Mankowski.

# Perl Weekly Challenge #176: Permuted Multiples and Reversible Numbers

I did this week's challenge in Perl. Each of my solutions this week
has a 1-line helper function. I'm going to focus on those this week
since the rest of the programs are quite straightforward.

## Task #1: Permuted Multiples

For this task we're asked to find the smallest positive integer _x_
such that x, 2x, 3x, 4x, 5x, and 6x all have exactly have the same set
of digits, only in a different order.

My trick here was to sort the digits of x and each of its
multiples. Here's the function I wrote to do that:

```perl
sub sorted_digits($x) {
    return join '', sort split //, $x;
}
```

I call that once for each multiple, then just compare the sorted
digits with `==`.

## Task 2: Reversible Numbers

For this task we're asked to find all the Reversible Numbers
below 100. A number is **Reversible** if the sum of the number and its
reverse has only odd digits. For example, 36 is reversible because
36 + 63 = 99, but 17 is not reversible because 17 + 71 = 88.

My helper function here adds the number and its reverse, then uses a
regex to check if the sum contains any even digits:

```perl
sub is_reversible($i) {
    return ($i + scalar reverse $i) !~ /[02468]/;
}
```

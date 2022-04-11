[< Previous 158](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-158/james-smith) |
[Next 161 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-161/james-smith)
# The Weekly Challenge 160

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-160/james-smith

# Challenge 1 - Four Is Magic

***You are given a positive number, `$n < 10`.  Write a script to generate english text sequence starting with the English cardinal representation of the given number, the word ‘is’ and then the English cardinal representation of the count of characters that made up the first word, followed by a comma. Continue until you reach four.***

## The solution

We use `num2en` from `Lingua::EN::Numbers` for this to simplify things - it converts a number into the string representation.

We simplify loop through making `$n` the length of the string until we get to the case where `$n==4`.

```perl
sub magic {
  my $r = ucfirst num2en( my $n = shift ).' is ';
  $r .= join num2en( $n = length num2en($n)=~s/\W//rg ), '', ', ', ' is ' until $n==4;
  $r.'magic.';
}
```

### Notes
 * The second line looks a bit odd - we can use join to insert the number string in twice without recalulating by making it the "connector" rather than one of the strings to join together.

# Challenge 2 - Equilibrium Index

***You are give an array of integers, `@n`.  Write a script to find out the Equilibrium Index of the given array, if found. For an array `@n` consisting n elements, index `$i` is an equilibrium index if the sum of elements of subarray `@n[0..$i-1]` is equal to the sum of elements of subarray `@n[$i+1..-1]`.

## Definition

Instead of computing the sum for values either side of the `$i`th index. We note that the sum of values to the right of the index is the total value minus the value at the index and the sum of the values to the left of the index. We therefore compute the sum of the values first, and iterate through the loop from the start seeing if:

  * `sum @n[0..$i-1] == sum @n[$i+1..-1]`
  * `sum @n[0..$i-1] == sum @n - sum @n[0..$i-1] - $n[$i]`
  * `$n[$i] = sum @n - 2 * sum @n[0..$i-1]`

We further note that this can be simplified again as if we design `$s = sum @n`;
 
  * This simlifies to `$s == $n[$i]` {we know one value is `$i` - so return it}
  * subtract `2*$n[$i]` from `$s` and repeat;


```perl
sub equilibrium_index {
  my $s = 0;
  $s += $_ for @_;
  ($s==$_[$_]) ? (return $_) : ($s-=2*$_[$_]) for 0..$#_;
  -1;
}
```


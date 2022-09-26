[< Previous 181](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-181/james-smith) |
[Next 183 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-183/james-smith)

# The Weekly Challenge 182

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-182/james-smith

# Task 1 - Max index

***You are given a list of integers. Write a script to find the index of the first biggest number in the list.***

## Solution

A relatively simple first challenge - we keep a track of the max index `$m`, looping through the array and updating
this everytime the value at the entry is greater than the value at the max index. We can do this two ways: (a) without keeping a separate variable for the max value and (b) with, giving us:

```perl
sub max_index {
  return unless @_;
  my $m=0;
  $_[$_] > $_[$m] && ( $m = $_ ) for 1 .. $#_;
  $m
}
```
and
```perl
sub max_index_var {
  return unless @_;
  my $v = $_[ my $m=0 ];
  $_[$_] > $v && ( $v = $_[$m=$_] ) for 1 .. $#_;
  $m
}
```
**Notes:**

 * We use `{condition} && ({assignment}) for {list}`

   to allow us the compactness of an `if` and a post-prefix `for`.

 * As we need the index we can't loop over the array `@_`, instead we loop over it's index:

   Often we use `@_` which in scalar context is the length of the list, and `@_-1` for the last
   index. But perl (as usual) has another way to do that - and that is to use the special
   variable `$#_` which gives the last index of the array.

 * Now, the question of the two methods is which one is better? Well this depends on the numbers...

   * If you find max index on a "semi-sorted" increasing list then the first method is faster.
   * If you find max index on a "semi-sorted" decreasing list the second method is better.

   If we try it on a truly random list of numbers {well as good as `rand` is at being truly random} we see the variable method is better by about 40%.

   Why then is it bad for the "semi-sorted" list. The slowdown is caused by the number of variable assignments. With a sorted list there would be `n` comparisons and `2n` updates [one for `$v` & one for `$m` for each number] - a reversed list there would be `n` comparisons but only `2` updates.

   For a random list of `1,000` numbers the number of updates is around `10`-`20` so we can see it is nearer the "semi-sorted" list.

# Task 2 - Common path

***Given a list of absolute Linux file paths, determine the deepest path to the directory that contains all of them.***

## Solution

We could use lots of comparison operators here, but instead we are going to go for a different solution for finding the common string.

If you use the XOR-operator `^` in perl on a string then it XORs each character. If two characters are the same then `$a^$b` is `\0`.

So to get the common prefix of two strings we XOR them together, grab the sequence of `\0`s from the start of the string, the common
string has the same length;

This is what `substr $l, 0, length( (($_^$l) =~ m{^(\0+)})[0])` does. We repeat this comparing the common string with all the rest of
the paths.

This isn't quite what we want as `/a/bc.txt` and `/a/bd.txt` have the common string `/a/b`, so we can remove the trailing directory
by removing anything after the last `/`.

This works when we are working with absolute paths... if we are working with relative paths it can't handle the "null" case of not
having a common directory BUT the top-level directory having a common prefix `ab` & `ac/q.txt` have common string `a`. So we return
the empty sting `''` if the shortest path does not contain a `/`.


```perl
sub common_path {
  my $l = shift;
  $l = substr $l, 0, length( (($_^$l) =~ m{^(\0+)})[0]) for @_;
  $l=~m{/} ? substr $l, 0, rindex $l, '/' : ''
}
```

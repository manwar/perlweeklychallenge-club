[< Previous 207](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-207/james-smith) |
[Next 209 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-209/james-smith)

# The Weekly Challenge 208

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-208/james-smith

# Task 1: Keyboard Word

***You are given an array of words. Write a script to print all the words in the given array that can be types using alphabet on only one row of the keyboard. (Assuming as English this is a QWERTY keyboard)***

## Solution

The obvious solution here is to use a regular expression, where each row of the keyboard is separated by a `|` to make them separate clauses.

```perl
sub keyboard_words { grep { m{^([qwertyuiop]+|[asdfghjkl]+|[zxcvbnm]+)$}i } @_ }
```

We can loop through a file with the following code to find the longest keyboard words in the dictionary

```perl
m{^([qwertyuiop]+|[asdfghjkl]+|[zxcvbnm]+)$}i && print while <>
```

**or** as a bash one-liner:

```bash
perl -ne 'm{^([qwertyuiop]+|[asdfghjkl]+|[zxcvbnm]+)$}i&&print' /usr/share/dict/british-english-huge
```

This gives us the following for longest words:

Length 11:

 * rupturewort

Length 10:
 * peppertree
 * pepperwort
 * perpetuity
 * perruquier
 * pirouetter
 * prerequire
 * proprietor
 * repertoire
 * typewriter

Note these are all on the top row of the keyboard - So no **typewriter** isn't the longest word in the English language you can make from the top row of the keyboard.

Using this extreme dictionary - we have:

| Length | Count |
+--------+-------+
|     11 |     1 |
|     10 |     9 |
|      9 |    27 |
|      8 |    70 |
|      7 |   128 |
|      6 |   224 |
|      5 |   278 |
|      4 |   322 |
|      3 |   285 |
|      2 |   218 |
|      1 |    52 |

Note: the definition of a word is a bit vague at times....

Note: there are 5 9-letter words which are not from the top row - these are all of Jewish origin.

# Task 2: Duplicate and Missing

***You are given an array of integers in sequence with one missing and one duplicate. Write a script to find the duplicate and missing integer in the given array. Return `-1` if none found. For the sake of this task, let us assume the array contains no more than one duplicate and missing.***

## Observation

It is not 100% clear in the desciption - but we have assumed that it means a list of integers from `n` ... `m` with a step of `1`.

## Solution

We loop through looking for a duplicate `$p[n+1]==$p[$n]` or gap `$p[n+1]!=$p[$n]+1`.

We have two special cases - if there are no duplicates return -1 

```perl
sub dup_missing {
  my($p,$d,$m) = shift;
  ($_==$p ? ($d=$_) : $_ == $p+2 && ($m=$_-1)), $p=$_ for @_;
  defined $d ? ( defined $m ? [ $d, $m ] : [ $d,$p+1  ] ): [-1]
}

```

We can either start at the beginning of the list and count backwards *OR* from the start.

`h_index_3` starts from the beginning of the list. We assume if we are not past the threshold then the `h-index` is the previous index - as in the real world our list is 1-based and in the perl world 0-based - then this is just `$_`. We short cut the loop and return the value. If we don't short cut the loop then the index must be the length of the list.

`h_index` is slightly longer! But we start from the end of the list (we `reverse` the indicies). Again we use the same criteria but switch the *logic* to `&&` which is the equivalent of `if`. And loop until we match the criteria. In this case we return `$_+1` as it is the current one we are interested in. **Note** in this case we will always short cut the loop so need no additional `return` state - definitely a one-liner!

`h_index_2` is effectively the same as 1, but removes the nasty use of `&&`/`||` to replace and `if`/`unless` - by putting the logic in the `while` statement and `pop`ping off values..

[< Previous 181](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-181/james-smith) |
[Next 185 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-185/james-smith)

# The Weekly Challenge 184

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-184/james-smith

# Task 1 - Sequence number

***You are given list of strings in the format aa9999 i.e. first 2 characters can be anything 'a-z' followed by 4 digits '0-9'. Write a script to replace the first two characters with sequence starting with '00', '01', '02' etc***

## Solution

This weeks challenge is relatively simple. We start by making the assumption that the input sequence is valid, and has less than 101 entries (as ill defined if there are more).

We then need to

  1. Create the sequence '00', '01', '02', ....
  2. Replace the first two characters with this sequence

The first is simple - perl's pre/post increment '`++`' is 'clever' in that if it is given an integer it returns the value and increments the number, IF it is given a string then it returns the value increments the last character, and wraps the next digit, ... This increment is intelligent - if all the characters are numbers then it wraps when you get to '9', if letters (followed by numbers) it wraps the letters on 'z'.

The second we can try three approaches.

  * We can get the numeric part of the number with the 2/3 parameter version of `substr`
  * We can replace the two letters in the string by using the 4 parameter version for `substr`
  * We can replace the first two letters in the string with a regular expression

These are the codes:

```perl
sub seq_number_substr { my $s = '00'; return map { ($s++).substr $_,2 }     @_ }
sub seq_number_subrep { my $s = '00'; return map { substr $_,0,2,$s++; $_ } @_ }
sub seq_number_regexp { my $s = '00'; return map { s/../$s++/re }           @_ }
```

The ratio of speeds for the three methods is 3 : 2.25 : 1.

# Task 2 - Split array

***You are given list of strings containing 0-9 and a-z separated by space only.  Write a script to split the data into two arrays, one for integers and one for alphabets only.***

## Solution

Our first solution creates two arrays, the array of arrays of numbers `@r` and the array of arrays of letters `@s`.

If the loops through the input, creating two more arrays `@n` and `@l` which contain the numbers/letters in each entry.

We then push these arrays onto `@r`, `@s` if they have entries.

**Notes:** We use split with no parameters to split `$_` on whitespace; we use ` ? : ` to replicate an `if then else` inside a post-fix `for` loop.

```perl
sub split_array_code {
  my (@r,@s);
  for (@_) {
    my(@n,@l);
    m{\d} ? push( @n,$_ ) : push( @l,$_ ) for split;
    push @r, \@n if @n;
    push @s, \@l if @l;
  }
  [\@r,\@s]
}
```

We can write this more simply as a nested `map`/`grep`. So we don't need to use variables. This involves us looping over `@_` twice, once to find the numbers, once to find the letter.

We use `grep` twice - firstly to extract the numbers of letter, and secondly to remove any empty arrays.

```perl
sub split_array_map {
  return [
    [ grep { @{$_} } map { [ grep { m/\d/ } split ] } @_ ],
    [ grep { @{$_} } map { [ grep { m/\D/ } split ] } @_ ],
  ]
}
```

Performance wise - the first will be penalised by the need to create variables, the second because we have to loop through the input array twice.

The penalty for the latter is much higher the first method being about 84% faster


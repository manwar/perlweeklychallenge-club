[< Previous 211](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-211/james-smith) |
[Next 213 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-213/james-smith)

# The Weekly Challenge 212

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-212/james-smith

# Task 1: Jumping Letters

***You are given a word having alphabetic characters only, and a list of positive integers of the same length. 
Write a script to print the new word generated after jumping forward each letter in the given word by the integer in the list. The given list would have exactly the number as the total alphabets in the given word.***

## Solution

```perl
sub jumping_letters {
  join '',
  map { chr }
  map { (96&ord) | ( (31&ord) -1 + shift)%26 +1 }
  split //,
  shift
}
```

# Task 2: 

***You are given an array of integers. Write a script to find out if the given can be split into two separate arrays whose average are the same..***

## Solution

```perl
sub rearrange_groups {
  my($s,%f) = -1+shift;
  $f{$_}++ for @_;
  for my $k ( sort {$a<=>$b} keys %f ) {
    $f{$k}||next;
    exists $f{$_} && $f{$_}>=$f{$k} ? $f{$_}-=$f{$k} : return -1 for $k+1..$k+$s;
  }
  [ map { ([$_..$_+$s]) x $f{$_} } sort { $a<=>$b } keys %f ]
}
```
Now with some "craft" the main function can be rewritten as a series of maps to
generate a single statement for everything after we produce the list of frequences.

We replace the inner loop with a map to allow us to replace the outer loop with a map also.
A trick here - we map `$_` -> `$'` by running the empty regex `//`. `$'` the after value
is assigned to whole of the unmatch string of `$_`. We then extract this as it is what we
need by by returning it in the 2nd value of the array and accessing with `[1]`.

This leaves the hash `%f` containing the frequence of each list starting at a given point.
Which we again use map to generate the list of lists.

```perl
sub rearrange_groups_one_liner {
  my($s,%f) = -1+shift;
  $f{$_}++ for @_;
  [ map { ([$_..$_+$s]) x $f{$_} }
    map { ( //,
            $',
            $f{$'} && map {
              $f{$_}//0>=$f{$'}
            ? $f{$_}-=$f{$'}
            : return -1
            } $'+1..$'+$s
          )[1] }
    sort {$a<=>$b}
    keys %f ]
}
```

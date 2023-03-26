[< Previous 208](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-209/james-smith) |
[Next 210 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-210/james-smith)

# ED-209: The Weekly Challenge

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-209/james-smith

# Task 1: Special Bit Characters

***You are given an array of binary bits that ends with `0`. Valid sequences in the bit string are:
`[0]` decodes to `"a"`, `[1, 0]` to `"b"`, `[1, 1]` to `"c"`. Write a script to print `1` if the last character is an `"a"` otherwise print `0`.***

## Solution

Firstly we quickly check the last entry is a `0` if it isn't we return `-1` "error". We then look through each bit in turn - if it is `0` we go to the next bit; if it is a `1` we skip one bit and go to the next. We loop through to the end of the array. We loop till the array has `0` or `1` elements left - if we have one element left then the last character is an "a" if we have none it is not. So we can just return scalar @a`.
```perl
sub special_bit_chars {
  return 0 if $_[-1];
  ($_[0]&&shift), shift until @_<2;
  scalar @_
}
```
## Solution 2

As well as tracking from the front we can track from the back.

First we need to note:

 * Last character must be a `0`
 * If there is string ending in a `0` then we can ignore anything up to this, as `0` is always at the right hand character in a string;
 * Additionally if the last two characters are 0 then we know that the answer is true.
 * So breaking this down we need to work out whether the value is true or false if the list ends: `.....,1,0`. If the string consists of series of `n` pairs of `1`s then this converts to "...CCA" and so the last character is `A` so we return 0; If it is an odd number of 1s we have the string "...CCB" so the return value is false.

```perl
sub special_bit_chars_reverse {
  my$f,pop?return 0:pop||return 1;
  $f++,pop||last while@_;
  1&$f
}
```
# Task 2: Merge Account

Try all combinations and 
***You are given an array of accounts i.e. name with list of email addresses. Write a script to merge the accounts where possible. The accounts can only be merged if they have at least one email address in common.***

## Observation

It is not 100% clear in the desciption - whether or not to assume the name must be the same - I am going to assume it isn't and that we chose one name from the list.

## Solution

The first pass at a solution, keeps a track of which emails that we have seen and links together an account with the current one if we have already seen the email address. This works most of the time - but it can go wrong - when there are three accounts with overlapping emails BUT they have no common email address.  This is the `for my $acc` loop below. To resolve this we can allow ourselves to do multiple passes reducing the list each time.

Now 

```perl
sub merge_accounts {
  my($in,$out,%seen,$t) = ([],shift);
  while(@{$out}!=@{$in}) {
    ($in,$out,%seen) = ($out,[]);
    O: for my $acc (@{$in}) {
      my( $name, @e )=@{ $acc };
      for(@e) {
        if( exists $seen{$_} ) {
          my( $m, @f ) = @{ $out->[ $t = $seen{$_} ] };
          my %T        = map { $_=>1 } @e, @f;
          $seen{$_}    = $t for keys %T;
          $out->[ $t ] = [ $m, keys %T ];
          next O;
        }
      }
      $seen{$_} = @{$out} for @e;
      push @{$out},$acc;
    }
  }
  $out
}
```


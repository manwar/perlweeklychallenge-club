[< Previous 162](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-162/james-smith) |
[Next 164 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-164/james-smith)
# The Weekly Challenge 163

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-163/james-smith

# Challenge 1 - Sum bitwise operator

***You are given list positive numbers, `@n`. Write script to calculate the sum of bitwise `&` operator for all unique pairs.***

## The solution

As with all code there is:

 * an initial phase where we set the sum to 0.
 * a processing phase where we compute the sum:
   * In this we repeatedly shift the first element of the list and:
   * and it with all remaining elements keeping the sum.
 * a final phase where we just return this sum.

If we can't guarantee there are no duplicates in the list we add an 
extra part to the initial phase to remove these duplicates. Note we include the `map { $_ + 0 }` to guarentee that the numbers are all numbers rather than strings.
If they get treated as strings then `15 & 16` becomes `('1'&'1').('5'&'6') = '14'` rather than `0`.

This gives us:

```perl
sub bit_sum {
  my $t = 0;

  my %hash = map { $_ => 1 } @_;
  @_ = map { $_ + 0 } keys %hash;

  while(@_>1) {
    my $a = shift;
    $t+= $a&$_ for @_;
  }

  $t;
}

```

We can write a shorter version by converting the outer loop and the initial phase into a C-style for loop.

```perl
sub bit_sum_splat {
  for($a=0,(%^H=map{$_=>1}@_),(@_=map{$_+0}keys%^H),$b=shift;@_;$b=shift){
    $a+=$b&$_ for@_;
  }
  $a;
}
```

***Notes:*** to remove the need for `my` and to resolve a related issue (`my` in comma-separated statements) we use
some special variables which we don't use here (in the special way) `$a`, `$b` the sort variables and `%^H` the only
special hash that you can safely use in most cases. Note we have to do the `$b=shift` twice - once before the first
loop and once after each loop, it's just the way that the C-loop works...

### "Unreadable" versions of the code.

Below are code equivalent to the above - but written in as compact as possible. To avoid `my` we use the special
variables `%^H`, `$a` and `$b`. All of which are safe to be written to (usually!). Note although `shift` feels
the most natural way of executing the code - in fact it doesn't matter which way we reduce the array so we can
also use `pop` which is two bytes shorter..

```perl
#--------1---------2---------3---------4---------5---------6---------7---------8---------9
#23456789012345678901234567890123456789012345678901234567890123456789012345678901234567890

sub bsm{$a=0;%^H=map{$_,1}@_;@_=map{$_+0}keys%^H;$b=pop,map{$a+=$b&$_}@_ while@_;$a}  ## 84 chars
sub bsu{$a=0;@_=map{$_+0}@_;$b=pop,map{$a+=$b&$_}@_ while@_;$a}                       ## 63 chars
```

# Challenge 2 - Summations

***You are given a list of positive numbers, `@n`. Write a script to find out the summations as described below.***

## Solution.

For a given row we drop the first element, then the remaining cells are the cumulative sum of the previous row. *e.g.*

```
  a   b   c   d
      b   b+c b+c+d
          b+c b+c+b+c+d
              b+c+b+c+d = 2b+2c+d
```

Similarly to the first element we at each interation shift of the first element.

 * This time our initial phase is empty (except for showing the input when dumping the table)
 * Our loop phase:
   * throws away the first entry (`shift`)
   * initializes the cumulative sum (`t=0`)
   * computes the next row `@_ = map { $t+$_ } @_`
   * {we just `say @_` at each loop if we want to see the table}
 * The final stage again just returns the last element of the array - the total we want.

```perl
sub summation_with_table {
  my $t;
  say "@_";
  shift, ($t=0), say join ' ', @_ = map { $t+=$_ } @_ while @_>1;
  shift;
}
```

If we don't need the table but just the final value at the end, we can simplify this to:

```perl
sub summation {
  my $t;
  shift, ($t=0), @_ = map { $t+=$_ } @_ while @_>1;
  shift;
}
```

In both these challenges we use the *perl*ism that within a postfix loop we can stitch together multiple statements into a single statement by the use of `,` (or any operator usually `||`, `&&` or `?:`). This leaves the beauty of the postfix loop while allowing multiple statements.

### Pretty print.

The print above is rudimentary to say the least, this does a pretty print version with columns lining up.

```perl
sub summation_with_pretty_table {
  my ($in,$t)='';
  say map { sprintf ' %11d', $_ } @_;
  ($in.='            '),shift, ($t=0), say $in, map { sprintf ' %11d', $_ } @_ = map { $t+=$_ } @_ while @_>1;
  shift;
}
```

### No so "pretty print"... 

Below are code equivalent to the above - with all spaces removed - we use the special variable `$a` to store the total to avoid `my` again.
```perl
#--------1---------2---------3---------4---------5
#2345678901234567890123456789012345678901234567890

sub sum{shift,$a=0,@_=map{$a+=$_}@_ while@_>1;$a}      ## 49 chars

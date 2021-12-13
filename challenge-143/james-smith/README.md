# Perl Weekly Challenge #143

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-143/james-smith

# Challenge 1 - Calculator

***You are given a string, `$s`, containing mathematical expression. Write a script to print the result of the mathematical expression. To keep it simple, please only accept `+ - * ()`.***`

## The solution

The simple solution is just to "`eval`" the string, but where is the fun in that... We can either go for a tokenizing parser - where we create an array of elements brackets, symbols, numbers, or we can use regular expressions to reduce the equation.

All students will remember BODMAS - Brackets, order, Division/Multiplication, Addition/Division. (or BIDMAS, PIDMAS, PEMDAS or whatever you used to remember it). So we have to break our prasing down into:

 * Brackets
 * Order    - we don't have this in our equations
 * Division/Multiplication - we only have the latter
 * Addition/Subtraction.

So our logic becomes:

 * Find brackets without brackets within - for these we evaluate the contents using the same algorithm;
 * If there are no brackets left - we then looking for multiplications from left to right and evaluate these.
 * If there are no brackets or multiplications we look at the addition/subtraction again left to right.
 * This gives the following perl function:

```perl
sub evaluate  {
  my $str = shift;
  1 while $str =~ s/\(\s*([^()]*?)\s*\)/       evaluate($1)             /e;
  1 while $str =~ s/(-?\d+)\s*\*\s*(-?\d+)/    $1 * $2                  /e;
  1 while $str =~ s/(-?\d+)\s*([-+])\s*(-?\d+)/$2 eq '+' ? $1+$3 : $1-$3/e;
  return $str;
}
```

For small strings - this is about the same speed as `eval`, for larger strings not so, but in both cases it is "safer" as string `eval` of "tainted" input is a real security risk.

# Challenge 2 - Stealthy Number

***You are given a positive number, `$n`.  Write a script to find out if the given number is Stealthy Number. A positive integer `N` is stealthy, if there exist positive integers `a`, `b`, `c`, `d` such that `a * b = c * d = N` and `a + b = c + d + 1`.***

## The solution

First we find all the factors of `N` (well the ones for where `N=a*b` and `a<b`)

We then store the sum of the factors in a hash (as the keys), we also store the sum of the factors + 1 in the hash {using `++` so what is stored is the count of these numbers}.

So if we have the condition `a+b == c+d+1` is equivalent to seeing which keys in the hash have a value greater than 1. In which case we have our value. For the problem we don't need this value - just whether there is a value. So our function comes down to this.

```perl
sub stealthy_number {
  my($n,%c) = shift;
  $n%$_||($c{$n/$_+$_ }++,$c{$n/$_+$_+1}++) for 1..sqrt$n;
  (grep { $_ > 1 } values %c) ? 1 : 0;
}
```


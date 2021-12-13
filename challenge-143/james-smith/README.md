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

```perl
sub evaluate  {
  my $str = shift;
  1 while $str =~ s/\(\s*([^()]*?)\s*\)/       evaluate($1)             /e;
  1 while $str =~ s/(-?\d+)\s*\*\s*(-?\d+)/    $1 * $2                  /e;
  1 while $str =~ s/(-?\d+)\s*([-+])\s*(-?\d+)/$2 eq '+' ? $1+$3 : $1-$3/e;
  return $str;
}
```

# Challenge 2 - Stealthy Number

***You are given a positive number, `$n`.  Write a script to find out if the given number is Stealthy Number. A positive integer `N` is stealthy, if there exist positive integers `a`, `b`, `c`, `d` such that `a * b = c * d = N` and `a + b = c + d + 1`.***

## The solution

```perl
sub stealthy_number {
  my($n,%c) = shift;
  $n%$_||($c{$n/$_+$_ }++,$c{$n/$_+$_+1}++) for 1..sqrt$n;
  (grep { $_ > 1 } values %c) ? 1 : 0;
}
```


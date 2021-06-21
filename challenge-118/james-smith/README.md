# Perl Weekly Challenge #118

You can find more information about this weeks, and previous weeks challenges at:

  https://perlweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-117/james-smith/perl

# Task 1 - Binary Palindrome
***You are given a positive integer `$N`. Write a script to find out if the binary representation of the given integer is Palindrome. Print `1` if it is otherwise `0`.***
## The solution

```perl
sub is_binary_palindrome_string {
  my $t = sprintf '%b', shift;
  return ($t eq reverse $t) || 0;
}
```

# Task 2 - Adventure of Knight

***There are 6 squares with treasures. Write a script to find the path such that Knight can capture all treasures. The Knight can start from the top-left square.***

## The solution

```perl
my @dir = ([-2,1],[2,1],[-2,-1],[2,-1],[-1,2],[1,2],[-1,-2],[1,-2]);
my @treasures = qw(a2 b1 b2 b3 c4 e6);
my( $sol, $best_len, $best_rt ) = ( 0, 65 );
$sol |= 1 <<  8 * (substr $_,1) - 105 + ord $_ foreach @treasures;
walk( 0, 7, 0, q() );   ## Walk the tree starting from top-left
say length $best_rt, q( - ), show_rt( $best_rt ); ## Show best route
```

```perl
sub walk {
  my( $x, $y, $seen, $rt ) = @_;
  return if $x < 0 || $y < 0 || $x > 7 || $y > 7
         || $seen & ( my $v = 1 << ( my $t = 8*$y + $x ) );
  $seen |= $v;
  $rt   .= chr $t;
  return ($best_rt,$best_len) = ($rt,-1+length $rt)
    if ($seen & $sol) == $sol;
  return if $best_len <= length $rt;
  walk( $x + $_->[0], $y + $_->[1], $seen, $rt ) foreach @dir;
}
```

```perl
sub show_rt {
  my %t = map { $_ => 1 } @treasures;
  return join q(),
          map { sprintf ' %s%s', exists$t{$_}?q(*):q( ), $_ }
          map { chr( ($_&7) + 97 ).(1 + ($_>>3)) }
          map { ord $_ }
        split m{}, shift;
}
```


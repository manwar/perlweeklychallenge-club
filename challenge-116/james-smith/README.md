# Perl Weekly Challenge #116

You can find more information about this weeks, and previous weeks challenges at:

  https://perlweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-116/james-smith/perl

# Challenge 1 - Number Sequence

***You are given a number `$N >= 10`. Write a script to split the given number such that the difference between two consecutive numbers is always 1 and it shouldn’t have leading 0. Print the given number if it impossible to split the number.***

## The solution

We first need to get the possible leading numbers.. to do this we split the
string into individual digits. We then concatenate each digit on to the end
of the sequence (`$start.=$_`)....

Within each loop we just stitch together the string by incrementing the
number each time through the loop..

 * We reduce the maximum calculations by a factor of 2 by spliting just the first half of the string   
 * We use string (in)equalities so this will work with arbitrary numbers.
 * We have to check length as well as the strings in the while condition (because we are using string comparison)

```perl
sub splitnum {
  my( $in, $start ) = ( shift, '' );
  for( split //, substr $in, 0, (length $in) >> 1) {
    my @range = ( my $string = my $end = $start .= $_ );
    ($string .= ++$end) && push @range, $end
      while $in gt $string && length $in > length $string;
    return \@range if $string eq $in;
  }
  return [$in];
}

```

# Challenge 2 - Sum of Squares

***Write a script to find out if the given number $N is such that sum of squares of all digits is a perfect square. Print 1 if it is otherwise 0.***

## The solution

Another week where challenge 2 is simpler than challenge 1.

Just split the input number and sum the square of it's digits... Then just return 1/0 depending on whether the sum is 0/1

```perl
sub sum_square {
  my $sum = 0;                            ## Initialize sum
  $sum += $_*$_ foreach split //, shift;  ## Sum digits..
  return $sum == (int sqrt $sum)**2 || 0; ## Check is squared
}
```

Nothing really clever here - just a note the equality returns `1`/`''` so to get it to return `1`/`0` we use `||` to assign `0` to the result.

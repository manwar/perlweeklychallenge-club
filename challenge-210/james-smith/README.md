[< Previous 209](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-209/james-smith) |
[Next 211 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-211/james-smith)

# The Weekly Challenge 210

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-210/james-smith

# Task 1: Kill and Win

***You are given a list of integers. Write a script to get the maximum points. You are allowed to take out (kill) any integer and remove from the list. However if you do that then all integers exactly one-less or one-more would also be removed. Find out the total of integers removed.***

## Solution

Although it's not fully clear on the rules - we make the assumption that it means once we chose one number all those above and below are killed.

Firstly we compute counts of each of the numbers, we then for each value compute:

```
  count{n-1}*(n-1) + count{n}*n + count{n+1}*(n+1)
```

We just loop through all the keys of the count and compute the maximum value:

```perl
sub kill_and_win {
  my($m,%c,$x)=0;
  $c{$_}++ for @_;                             ## Get freq in hash
  ( ( $x = ( $c{$_-1} ? $c{$_-1}*($_-1) : 0 )  ## Compute value
         + ( $c{$_  } ? $c{$_  }* $_    : 0 )  ## for current
         + ( $c{$_+1} ? $c{$_+1}*($_+1) : 0 )  ## integer
    ) > $m ) && ($m = $x) for keys %c;         ## if max reset max
  $m                                           ## return value
}
```

### A neater solution.... 

```perl
sub kill_and_win {
  my($m,%t,$x)=0;
  $t{$_} += $_ for @_;                 ## Get freq in hash
  ( ( $x = ( $t{$_-1} // 0 )           ## Compute value
         + ( $t{$_  } // 0 )           ## for current
         + ( $t{$_+1} // 0 )           ## integer
    ) > $m ) && ($m = $x) for keys %t; ## if max reset max
  $m                                   ## return value
}
```

About the same efficiency as above - we can simplify the sum part of the operation by computing the sum of each number before the 2nd loop. So instead of incrementing by 1 to get the count we just add the value each time..

# Task 2: Number Collision

***You are given an array of integers which can move in right direction if it is positive and left direction when negative. If two numbers collide then the smaller one will explode. And if both are same then they both explode. We take the absolute value in consideration when comparing. All numbers move at the same speed, therefore any 2 numbers moving in the same direction will never collide. Write a script to find out who survives the collision.***

## Solution

We can use a stack to achieve this. We start with an empty stack and follow these simple rules.

 1) **IF**
     1) the list is empty
     2) the next value is +ve
     3) the last number on the stack is -ve
 
    **THEN** we push the next value onto the stack;

 2) **IF** the absolute value for the top of the stack and the next value **THEN** we remove the value from the stack and throw away the current value;

 3) **IF** the absolute value for the top of the stack is less than the absolute value of the next value **THEN** we remove the value from the top of the stack;

 4) **Otherwise (IF)** the absolute value for the top of the stack is greater than the absolute value of the next value **THEN** we just throw the current value away.

```perl
sub collision {
  my @s;
    !@s              ||
     $_[0] >       0 ||
     0     >  $s[-1] ? push @s,   shift
  : -$_[0] == $s[-1] ? pop  @s && shift
  : -$_[0] >= $s[-1] ? pop  @s
  :                               shift
    while @_;
  @s
}
```


[< Previous 186](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-186/james-smith) |
[Next 188 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-188/james-smith)

# The Weekly Challenge 187

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-187/james-smith

# Task 1 - Days Together

***Two friends, Foo and Bar gone on holidays seperately to the same city. You are given their schedule i.e. start date and end date.***

***To keep the task simple, the date is in the form DD-MM and all dates belong to the same calendar year i.e. between 01-01 and 31-12. Also the year is non-leap year and both dates are inclusive.***

***Write a script to find out for the given schedule, how many days they spent together in the city, if at all.***

## Solution

A slightly contrived one liner, which uses *self-executing closures* to perform the calculations without the need for creating intermediate variables.

We are used to using *closures* or *anonymous functions* as callbacks in various functions - like `sort`, `map`, `grep` etc, but we can also use them
as self executing functions `sub { ..code.. }->( ..data.. )`, this is similar to the approach used in javascript to alias methods/variables.

e.g.
```php
(function($){
  $.fn.function_name = function(x){};
})(jQuery);
```

Working inward to outward, and bottom to top...

We:
  * flatten the array refs into a single array;
  * compute their year-day;
  * from this we compute the last start & the first end;
  * check to see if the last start < first end if so returns the value o/w returns 0.

```perl
sub days_together {
  sub { $_[1]<$_[0] ? 0 : $_[1]-$_[0]+1 }->(
    # *4* If start [0] > end[1] then return the difference + 1 otherwise return 0

    sub { ( $_[2] > $_[0] ? $_[2] : $_[0], $_[3] < $_[1] ? $_[3] : $_[1] ) }->(
      # *3* Calculate max start & min end...
      #     If bar->start [2] > foo->start [0] then overlap->start = bar->start else it's foo->start
      #     If bar->end   [3] < foo->end   [1] then overlap->end   = bar->end   else it's foo->end

      map { [ 0,0,31,59,90,120,151,181,212,243,273,304,334 ]->[ substr $_,3 ] + substr $_,0,2 }
        # *2* Compute year day - array contains offsets for the start of each month [ there is a
        #     padding 0 so we don't have to adjust month by 1...

      map { @{$_} }
        # *1* Flatten two arrays into one... could have written this as @{$_[0]}, @{$_[1]} to avoid
        # the map.

      @_
    )
  )
}
```

and now without the comments:

```perl
sub days_together {
  sub { $_>[1]<$_[0] ? 0 : $_[1]-$_[0]+1 }->(
    sub { ( $_[2] > $_[0] ? $_[2] : $_[0], $_[3] < $_[1] ? $_[3] : $_[1] ) }->(
      map { [ 0,0,31,59,90,120,151,181,212,243,273,304,334 ]->[ substr $_,3 ] + substr $_,0,2 }
      map { @{$_} }
      @_
    )
  )
}
```
# Task 2 - Split array

***You are given a list of positive numbers, `@n`, having at least 3 numbers. Write a script to find the triplets `(a, b, c)` from the given list that satisfies the following rules.***

## Solution

This is a permutation challenge, so we loop through the values with 3 nested loops.

By sorting we can make the assumption that `$a,$b,$c` are automatically sorted highest to lowest..

This has two advantages:
 1. The results will always be sorted `$a>=$b>=$c`
 2. The 3 inequalities can reduce to a single inequality - all three are satisfied if `$b+$c > $a`, as this is the smallest sum of two numbers and the largest single number;
 3. The first solution we find will have the largest sum of `$a+$b+$c` so we don't need to keep track of the maximum solution - but return the first we can find...

Each time through we use shift to get the first element of each loop until there are no values left. Note in this case we use `while` for the outer two loops...

```perl
sub magical {
  @_ = sort { $b <=> $a } @_;
  while(@_>2) {
    my($a,$b,@c)=@_;
    while(@c) {
      ( $b+$_ > $a ) && ( return $a,$b,$_ ) for @c;
      $b = shift @c;
    }
    shift;
  }
  ();
}
```

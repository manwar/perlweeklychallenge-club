# Maximal Great Day!

**Challenge 237 solutions in Perl by Matthias Muth**

## Task 1: Seize The Day

> Given a year, a month, a weekday of month, and a day of week (1 (Mon) .. 7 (Sun)), print the day.<br/>
> <br/>
> Example 1<br/>
> Input: Year = 2024, Month = 4, Weekday of month = 3, day of week = 2<br/>
> Output: 16<br/>
> The 3rd Tue of Apr 2024 is the 16th<br/>
> <br/>
> Example 2<br/>
> Input: Year = 2025, Month = 10, Weekday of month = 2, day of week = 4<br/>
> Output: 9<br/>
> The 2nd Thu of Oct 2025 is the 9th<br/>
> <br/>
> Example 3<br/>
> Input: Year = 2026, Month = 8, Weekday of month = 5, day of week = 3<br/>
> Output: 0<br/>
> There isn't a 5th Wed in Aug 2026<br/>

My idea for solving this task is to

- get the first day of the given month,
- check its day of week, and comparing it with the day of week we want,
to determine how many days we need to move forward to the first such day of week,
- then add as many weeks as needed to reach the $n$ th 'Weekday of month'.
- Before returning the day of month of the day we found,
make sure we haven't passed into the following month when we moved forward.

For dealing with dates, I find `Time::Piece` objects much more intuitive
than the 9-element integer list that the core functions `localtime` and `gmtime` return.
Maybe at the time when `struct tm` was invented for early versions of Unix it was appropriate,
but with its specification that is sometimes zero based
(for months, 0 is January -- not really intuitive),
sometimes one-based (days count from 1 to 31),
and even 1900-based (years have an offset of 1900)
it feels a bit outdated today.

The only problem with `Time::Piece` is that when you want to set up an object
with a given date and/or time, there is no constructor like
```perl
        Time::Piece->new( year => 2023, month => 10, day => 8 );
```
So we are stuck between 

* using the `timegm` function from the `Time::Local` core module,<br/>
which takes 6 parameters for time and date, with said strange offsets,
and returns a time value in seconds,
which we then can use to pass it into the `Time::Piece` `gmtime` constructor:
  ```perl
  use Time::Piece;
  use Time::Local;
  my $first_of_month =
          gmtime( timegm_posix( 0,0,0, 1, $month - 1, $year - 1900 ) );
  ```

* using the `strptime` function to parse a date string (I prefer ISO format, like `"2023-10-01"`):
  ```perl
  my $first_of_month = Time::Piece->strptime( "$year-$month-01", "%F" );
  ```
  I don't like the overhead of first constructing a string,
  and then immediately parsing it again, but it is much easier to read.
  We also don't need to load the `Time::Local` module,
  and we only have exactly one call per example in the task description.<br/>
  So let's go for this one.<br/>
  (And good that `strptime` is forgiving about not always having leading zeros, especially for the month.)

Once we have a `Time::Piece` object for the first of month, it is not difficult to do the rest.<br/>
I left the comments in the code, so I guess there's no need to repeat everything here.

```perl
use Time::Piece;
use Time::Seconds;

sub seize_the_day( $year, $month, $weekday_of_month, $day_of_week ) {

    # Set up a Time::Piece object for the first day of the month
    # (good that strptime '%F' does not insist in leading zeros).
    my $first_of_month = Time::Piece->strptime( "$year-$month-01", "%F" );

    # The Time::Piece day_of_week method is based on 0=Sunday.
    # We map our $day_of_week (1=Monday...7=Sunday) to that range by a '% 7'.
    # We get to the first $day_of_week of the month by subtracting the
    # weekday of the first of month, then adding our weekday number.
    # If the difference is negative, another '% 7' will move it one week
    # forward if necessary.
    my $t = $first_of_month
        + ( ( $day_of_week % 7 )
            - $first_of_month->day_of_week ) % 7
            * ONE_DAY;

    # Add the number of weeks needed.
    $t += 7 * ONE_DAY * ( $weekday_of_month - 1 );

    # Make sure we still are in this month.
    my $next_month = $first_of_month->add_months( 1 );
    return $t->mon == $month ? $t->day_of_month : 0;
}
```

## Task 2: Maximise Greatness

> You are given an array of integers.<br/>
> Write a script to permute the give array such that you get the maximum possible greatness.<br/>
> To determine greatness, nums[i] < perm[i] where 0 <= i < nums.length<br/>
> <br/>
> Example 1<br/>
> Input: @nums = (1, 3, 5, 2, 1, 3, 1)<br/>
> Output: 4<br/>
> One possible permutation: (2, 5, 1, 3, 3, 1, 1) which returns 4 greatness as below:<br/>
> nums[0] < perm[0]<br/>
> nums[1] < perm[1]<br/>
> nums[3] < perm[3]<br/>
> nums[4] < perm[4]<br/>
> <br/>
> Example 2<br/>
> Input: @ints = (1, 2, 3, 4)<br/>
> Output: 3<br/>
> One possible permutation: (2, 3, 4, 1) which returns 3 greatness as below:<br/>
> nums[0] < perm[0]<br/>
> nums[1] < perm[1]<br/>
> nums[2] < perm[2]<br/>

For sure we could generate all possible permutations of the numbers,
get the score for each, and find the maximum.<br/>
The problem is that the number of permutations rises very fast, as it is $n!$
($n$ being the number of numbers in the array).
Still, for the size of the example input data this probably would not matter too much. 

But there is another approach that is much easier to implement than that.<br/>
And it works -- after sorting the array -- using only one pass through the array.

Let's start by sorting the numbers, highest to lowest,
and by creating a copy of that,
which is going to be the 'permuted' array
(even if we will develop only exactly one permutation).

For visualizing what happens, we line up the two arrays next to each other:
```perl
@nums       5   3   3   2   1   1   1
@permuted   5   3   3   2   1   1   1
```
Now let's walk through the positions of the arrays, one by one.

For the first position (at the left), we have the same numbers, so this is a draw, not a win.

We don't have any higher number that we could use to win against the original number in that position, so let's do something different:<br/>
We assign our *lowest* number to match that original number.<br/>As we are sure to lose that fight, we kind of 'sacrifice' the lowest number in order to keep better chances for winning other numbers later on. 

In the permuted array this means that we move the all entries one to the right, starting with the current position, and we move the last entry to the current position to fill in the gap that we just opened.<br/>It is kind of a 'rotate right' of the array elements, starting at the current position.  
```perl
@nums      *5*  3   3   2   1   1   1
@permuted  -5-  3   3   2   1   1   1
             \   \   \   \   \   \  /             |
            .-\---\---\---\---\---\-
            V  \   \   \   \   \   \
@permuted   1   5   3   3   2   1   1
```
For the next rounds, we do the same:

-  If the next available 'permuted' number (which is always the highest available) wins against the next original number, we leave it like that.
-  If we can't win that position, we do a 'rotate right' from that position. 

```perl
@nums       5  -3-  3   2   1   1   1
@permuted   1  *5*  3   3   2   1   1

@nums       5   3  *3*  2   1   1   1
@permuted   1   5  -3-  3   2   1   1
                     \   \   \   \  /             |
                    .-\---\---\---\-
                    V  \   \   \   \
@permuted   1   5   1   3   3   2   1

@nums       5   3   3  -2-  1   1   1
@permuted   1   5   1  *3*  3   2   1

@nums       5   3   3   2  -1-  1   1
@permuted   1   5   1   3  *3*  2   1

@nums       5   3   3   2   1  -1-  1
@permuted   1   5   1   3   3  *2*  1

@nums       5   3   3   2   1   1  *1*
@permuted   1   5   1   3   3   2  -1-

Final result:
@permuted  -1- *5* -1- *3* *3* *2* -1-
```

The code for this solution is quite straightforward:

```perl
sub maximise_greatness( @nums ) {
    # Sort the numbers, highest first.
    @nums = sort { $b <=> $a } @nums;

    # Our 'permuted' array starts out the same, highest values first.
    my @permuted = @nums;

    # Now we compare the corresponding numbers one by one.
    # If the current 'attacker' value is greater than the number, that's great!
    # (pun intended!) and we can leave the attacker in that position.
    # If instead the 'attacker' is less or equal than the number, we have no
    # chance of finding a better one (remember the available values are
    # sorted highest first).
    # We therefore move the *lowest* attacker value into that position,
    # 'waisting it' on the number that we could not win.
    # This keeps our best chances of winning other numbers.
    # We also move all the rest of the permuted to the right by one position.
    # The current attacker will then have another chance with the next number.

    my $greatness = 0;
    for ( 0..$#nums ) {
        if ( $permuted[$_] > $nums[$_] ) {
            ++$greatness;
        }
        else {
            # Move the last element to the current position,
            # shifting the rest to the right.
            splice @permuted, $_, 0, pop @permuted;
        }
    }
    return $greatness;
}
```

A solution that scales well like this makes a maximal great day!

#### **Thank you for the challenge!**

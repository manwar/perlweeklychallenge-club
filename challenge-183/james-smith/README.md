[< Previous 182](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-182/james-smith) |
[Next 184 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-184/james-smith)

# The Weekly Challenge 183

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-182/james-smith

# Task 1 - Unique array

***You are given list of arrayrefs. Write a script to remove the duplicate arrayrefs from the given list.***

## Examples

| Input                          | Output                   |
| ------------------------------ | ------------------------ |
| `([1,2], [3,4], [5,6], [1,2])` | `([1,2], [3,4], [5,6])`  |
| `([9,1], [3,7], [2,5], [2,5])` | `([9, 1], [3,7], [2,5])` |

## Solution

We will look at two-solutions to this - one which creates a simple index of the sub-arrays, and one which loops
through the sub-arrays.

We will then look to see which is the better solution! Which is not always as obvious as you think!

### Solution 1 using a stingified array

```perl
sub unique_array_stringify {
  my(@r,%seen);
  $seen{ "@{$_}" } ++ || push @r, $_ for @_;
  \@r 
}
```

We can simply stringify an array by embedding it in a double quoted string *e.g.* `$Q=[1,2,3]` to stringify this
we just do "@{$Q}" and this gives '`1 2 3`'. We just see if the string is an a list of seen strings...

We use our usual trick of using `&&`, `||` and `?:` to replicate if, unless & if/else blocks inside a postfix
loop which can't have them

In this case we have `$seen{ "K" }++ || push @r`. If $seen has no key `"K"` then the first parts is zero, so
we execute the the `push @r, $_`. If already seen then the left hand evaluates to 1 or more and therefor does
not execute the last bit.

### Solution 2 using a stringified array - but fixing a bug.

```perl
sub unique_array_stringify_fixed {
  local $" = '\0\0\0';
  my(@r,%seen);
  $seen{ "@{$_}" } ++ || push @r, $_ for @_;
  \@r
}
```

We have a problem if any of the strings contain a "space" we can't tell the difference between it and two other
strings, i.e. if we stringify `['1 2']` and `[1,2]` we end up with "`1 2`" in both cases. We can "fix" this
by using a different separator (setting `$"` to something VERY unlikely)....

### Solution 2 comparing arrays

```perl
sub unique_array_array {
  my @r = (shift);
  O: for my $e (@_) {
    R: for my $s (@r) {
      next if @{$s} != @{$e};
      $_->[0] eq $_->[1] || next R for zip6 @{$e}, @{$s};
      next O;
    }
    push @r, $e;
  }
  \@r
}
```

On my test box - running some tests with 5000 element array (with up to 5000 elements per sub-array), we see that
the string method runs in around 0.5 seconds and the array method takes 1.75 seconds.

But if we increase the size to a 6000 element array (with up to 6000 elements per sub-array), we see that the
array method now takes around 4 seconds BUT the string mehod now takes 200 seconds - all down to hitting swap...

## Comparison

The string based solution is about `2x` - `2.5x` faster than the array solution **BUT** the array solution uses
less memory - so if large arrays is an issue or a small server - then better performance

# Task 2 - Date Difference

***You are given two dates, $date1 and $date2 in the format YYYY-MM-DD. Write a script to find the difference between the given dates in terms on years and days only.***

## Solution

This one may be a bit left field so I'll explain the process..

  #1 foreach date convert YYYY-MM-DD into to YYYY, MM, DD
  #2 foreach each get value of "special variable"
  #3 merge together and work out the day of year and whether year is leap year for both ends
  #4 format output

```perl
sub date_diff {
  sub {
    join ' ', map {
                $_[$_]
              ? $_[$_]
                . ' '
                . ( $_         ? 'day' : 'year' )
                . ( $_[$_] > 1 ? 's'   : ''     )
              : ()
              } 0 , 1
  }->(
    sub {
       $_[1][3] >= $_[0][3]
     ? ( $_[1][0] - $_[0][0],       $_[1][3] - $_[0][3]
                                  - ( $_[1][1] > 2 && $_[0][1] < 3 && $_[1][2] && 1 ) )
     : ( $_[1][0] - $_[0][0] - 1,   $_[1][3] - $_[0][3] + 366
                                  - ( $_[1][1] > 2 &&                 $_[1][2] && 1 )
                                  + (                 $_[0][1] < 3 && $_[0][2] && 1 ) )
    }->(
      map {
        [ $_->[0], $_->[1],
          ( $_->[0] % 400 ) ^ ( $_->[0] % 100 ) ^ ( $_ ->[0] % 4 ),
          $FIRST_OF_MONTH[ $_->[1] ] + $_->[2]
        ]
      }
      map { [ split/-/ ] } @_
    )
  );
}


  

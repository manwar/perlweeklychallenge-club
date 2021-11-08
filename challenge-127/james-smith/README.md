# Perl Weekly Challenge #127

You can find more information about this weeks, and previous weeks challenges at:

  https://perlweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-127/james-smith/perl

# Task 1 -  Disjoint Sets

***You are given two sets with unique integers. Write a script to figure out if they are disjoint.***

## The solution

This is a rewording of simple perl, which is to see if there any elements of set 1 in set 2. To avoid nested loops, we use the efficiency of perl's hash key search to search for members. So for set 1 we create a hash who's keys are the members of set 1. We then search through set 2 to see which members are keys in this hash (and so in both sets). If there are any we return 0 o/w return 1.

```perl
sub disjoint_sets {
  my %m = map { $_=>1 } @{$_[0]};
  return grep( { $m{$_} } @{$_[1]}) ? 0 : 1;
}
```

# Task 2 - Conflict Intervals

***You are given a list of intervals. Write a script to find out if the current interval conflicts with any of the previous intervals.***

## Background

This is going back to my day job again - but I thought I would add a bit of background this time. I'm not a geneticist, but a web developer working at an institution that uses DNA sequencing to use genomics to investigate genetics. My first project was to develop/lead the developers for a genome browser. Often we had to display information about genomic features and whether or not they overlapped a particular region (to know whether to display them or not) or to bump them for display (to make sure features didn't merge/overlap)...

## Solution


There are six arrangements more any two regions..... See picture below...

```
         [============]
[------]    [++++++]    [------]
     [++++++++++++++++++++]
     [++++++]      [++++++]
```

Over the 6 we have two of regions which are disjoint from the top region: Where `region_2_start > region_1_end` or `region_1_start > region_2_end`...

Our loop finally becomes....

```perl
sub conflict_intervals {
  my @in = @{ $_[0] };
  my @conf;
  while( my $int = pop @in ) {
    foreach(@in) {
      next unless $int->[1] < $_->[0] || $int->[0] < $_->[1];
      unshift @conf, $int;
      last;
    }
  }
  return \@conf;
}
```

**Notes:**
 # Note we work from the end backwards - this is easier as we just pop the last interval off the loop each time and compare it with previous ones.
 # We then use unshift to add it to the start of what we return.

We can compact this slightly using the `&&` trick in the foor loop to do away with the `next`/`last` combination:

```perl
sub conflict_intervals_compact {
  my(@i,@o) = @{$_[0]};
  while(my $r = pop @i) {
    ($r->[1]<$_->[0] || $r->[0]<$_->[1]) && (unshift @o, $r) && last foreach @i;
  }
  return \@o;
}
```

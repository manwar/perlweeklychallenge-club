# Completed and Maximum Frequency Days

**Challenge 276 solutions by Andrew Schneider**

[PWC 276](https://theweeklychallenge.org/blog/perl-weekly-challenge-276/)

PWC 276 Back on Track!

Two Challenges this week. I thought the first one was easy, but that was because I misread the instructions. The second one had a trick to it too, but I'd say the first one was the hard one, contrary to recent experience.

## Task 1: Complete Day

> Task 1: Complete Day</br>
> </br>
> Submitted by: Mohammad Sajid Anwar</br>
> </br>
> You are given an array of integers, @hours.</br>
> </br>
> Write a script to return the number of pairs that forms a complete day.</br>
> </br>
> A complete day is defined as a time duration that is an exact multiple of 24 hours.</br>
> </br>
> Example 1</br>
> Input: @hours = (12, 12, 30, 24, 24)</br>
> Output: 2</br>
> </br>
> Pair 1: (12, 12)</br>
> Pair 2: (24, 24)</br>
> </br>
> Example 2</br>
> Input: @hours = (72, 48, 24, 5)</br>
> Output: 3</br>
> </br>
> Pair 1: (72, 48)</br>
> Pair 2: (72, 24)</br>
> Pair 3: (48, 24)</br>
> </br>
> Example 3</br>
> Input: @hours = (12, 18, 24)</br>
> Output: 0

On first reading, I thought we were looking only at adjacent items. So I hacked out a pretty quick solution looking at adjacent pairs of times to see if they summed to a multiple of 24. Easy! and not what we wanted. Oops

Double checking the examples I saw that we weren't limited to adjacent pairs. Trickier. We could of course check all possible pairs of times for a $\mathcal{O}(n^2)$, but we wouldn't be happy with that! (Actually I my *cleverer* Prolog solution had worse algorithmic runtime than that, due to Prologisms, so I went back to a $\mathcal{O}(n^2)$ solution.)

So after some thinking and pondering, I made some observations: if $t_1 + t_2 \bmod 24 = 0$ then $(t_1, t_2)$ constitutes a completed day, equivalently if $(t_1 \bmod 24 + t_2 \bmod 24) \bmod 24 = 0$. So we could find all values modulo 24 and figure it out from there.

Let's see some code

### C

My C code has the clearest illustration of my developing thinking, plus all Perl programmers also know C, so let's look at the C solution(s) first. Version 1 here:

```c
int count_completed_days_v1( int list[], int length ) {
  int day_count[24] = {0};
  for (int i=0; i < length; i++) {
    day_count[list[i] % 24]++;
  }
  
  int count = day_count[0] * (day_count[0] - 1) / 2;
  count += day_count[12] * (day_count[12] - 1) / 2;
  for (int i=1; i < 12; i++) {
    count += day_count[i] * day_count[24-i];
  }
  return count;
}
```

We go through the list and count how many at each value mod 24. Then ... well then we do some tricky math. There are two values we need to take special care of: 0 and 12. Let's hold off on explaining those for the moment and move on the second loop. 

```c
  for (int i=1; i < 12; i++) {
    count += day_count[i] * day_count[24-i];
  }
```

Skipping 0 and 12 we run this loop from 1 through 11 inclusive. The idea here is that for all hours that modulo to a certain value, we can complete a day by adding any of the hours that modulo to the reciprococal value. So like if we have 5 instances with 1 hour (or 1 hour after modulo 24) and 2 instances with 23 hours (or equivalent mod 24), then from these we can make $5 \times 2 = 10$ completed days. Also, we only go up to 11 so we don't double count, since a pair of $(t_1, t_2) = (t_2, t_1)$. Double count, actually that is why we treat 0 and 12 specially.

See for 0 and 12, they are their own reciprocals. So we have to do some clever maths. Thinking back to my school days, and getting out the pencil and paper, the proper way to sum these is n choose 2, ie, $\binom{n}2$, in code:

```c
  int count = day_count[0] * (day_count[0] - 1) / 2;
  count += day_count[12] * (day_count[12] - 1) / 2;
```

Boom done. Except... is there a better way to do it? This way I have two loops, plus some tricky mathy stuff. Well ... yes! there is a better algorithm in every conceivable way: more direct and more efficient.

```c
int count_completed_days( int list[], int length ) {
  int count = 0;
  int day_count[24] = {0};
  for (int i=0; i < length; i++) {
    count += day_count[(24 - list[i] % 24) % 24];
    day_count[list[i] % 24]++;
  }
  return count;
}
```

Here, for every value, we check how many of its reciprocal we have seen so far, and add this number to our total. Then we increment the number of the value. Easy! Loop once through the input and done. And no special thought needed to avoid double counting.

With the previous algorithm we implicitly ordered (at least mentally) pairs as (lower, higher). Here we kind of order them (occurs later in list, occurs earlier). If this doesn't make any sense to you then don't think too hard about it. It is just kind of how I think about it. 

That extra modulo `(24 - list[i] % 24) % 24` is there to handle the case of `list[i] % 24` which is 0 and $24 - 0 = 24$ when we want it to map to 0, so I do an extra mod.

### Perl

This one loop solution is basically what I did in C using a hashmap instead of an array.

```perl
sub check_completed_days( @hours ) {
    no warnings 'uninitialized';
    
    my $count;
    my %hours_rem_count;
    for (@hours) {
		my $idx = $_ % 24;
		my $inverse_idx = (24 - $idx) % 24;
		$count += $hours_rem_count{ $inverse_idx };
		++$hours_rem_count{ $idx };
    }
    return $count;
}
```

The hashmap holds our moduli and reciprocals. 

For my C solution, I spent some time trying to get glib.c running on macOS before deciding an array of size 24 (or 240, or 2400, ...) really shouldn't be a problem in C, but since hashmaps are easy in Perl, do what's easy. 

I had to `no warnings 'uninitialized';` since I have `use warnings; use strict;` above, and here I want to treat unseen keys as having value 0. That surprised me a little since apparently we can increment uninitialized values without issue, but I can see some sense in it. The latter case is surely much more common, and would seem more likely to be intended behavior, not a bug.

### Prolog 

I spent much time hacking together a series of of helper functions to shoehorn my Perl algorithm into Prolog, but at seemingly every step I had to iterate completely through a list, so there was surely no savings to be had using an *efficient* algorithm. Largely to blame is my insistence on writing for GProlog. Maybe next time around I'll target SWI-Prolog, the Rolls Royce of implementations.

Anyway, I decided to do the loop inside a loop approach, and coded this up in about 5 minutes. The outer loop takes the head of a list and calls the inner loop function to find how many reciprocals it has within the tail of the list

```prolog
check_completed_days_v1( [], 0 ).
check_completed_days_v1( [H|T], X ) :-
    check_reciprocal_count( H, T, X1 ),
    check_completed_days_v1( T, X2 ),
    X is X1 + X2.
```

And the inner loop function checks (recursively) how many values in the list, when added to value `V`, sum to a multiple of 24.

```prolog
check_reciprocal_count( _, [], 0 ).
check_reciprocal_count( V, [H|T], X ) :-
    0 =:= (V + H) mod 24,
    check_reciprocal_count( V, T, X1 ),
    succ(X1, X).
check_reciprocal_count( V, [H|T], X ) :-
    0 =\= (V + H) mod 24,
    check_reciprocal_count( V, T, X ).
```

Very easy Prolog implementation for this $\mathcal{O}(n^2)$ algorithm.

## Task 2: Maximum Frequency

> Task 2: Maximum Frequency</br>
> </br>
> Submitted by: Mohammad Sajid Anwar</br>
> </br>
> You are given an array of positive integers, @ints.</br>
> </br>
> Write a script to return the total number of elements in the given array which have the highest frequency.</br>
> </br>
> Example 1</br>
> Input: @ints = (1, 2, 2, 4, 1, 5)</br>
> Ouput: 4</br>
> </br>
> The maximum frequency is 2.</br>
> The elements 1 and 2 has the maximum frequency.</br>
> </br>
> Example 2</br>
> Input: @ints = (1, 2, 3, 4, 5)</br>
> Ouput: 5</br>
> </br>
> The maximum frequency is 1.</br>
> The elements 1, 2, 3, 4 and 5 has the maximum frequency.

The tricky part to this one, I found, is that we need a couple of loops. First loop over the list to get counts. Then loop over the counts to find the max values.

### Perl

```perl
sub max_freq_count( @list ){
    my %counts;
    map { ++$counts{ $_ } } @list;
    my $max_count = max values %counts;
    return $max_count * scalar grep { $_ == $max_count } values %counts;
}
```

Create a hashmap for counts and count the occurrence of each unique value. Then find the max of the counts, then effectively find the number of values that have the max value with `scalar grep`. The max value is the number of occurences, so we can multiply this by the number of unique values that occur this many times. Easy!

And no need to `no warnings 'uninitialized';` here, since we are merely incrementing uninitialized values.

### C

Ugh. This one gets a little ugly. Here it would have been very useful to have a convenient hashmap data structure. But I powered through without, relying on an indecent amount of sorting. First the forest, then the trees:

```c
int cf_func(const void* a, const void* b) {
  return *(const int*)a > *(const int*)b ? -1 : 1;
}

int max_freq_count( int list[], int length ) {
  qsort( list, length, sizeof( int ), cf_func );

  int j = 0;
  int current = list[0];
  list[0] = 1;

  for (int i=1; i < length; i++) {
    if (list[i] == current) {
      list[j]++;
    } else {
      current = list[i];
      list[++j] = 1;
    }
  }

  qsort( list, ++j, sizeof( int ), cf_func );

  int max = list[0];
  int sum = max;
  for (int i=1; i <= j; i++) {
    if (list[i] == max ) {
      sum += max;
    } else {
      break;
    }
  }

  return sum;
}
```

I define the comparison function so that we sort in descending order. This will be helpful below

```c
int cf_func(const void* a, const void* b) {
  return *(const int*)a > *(const int*)b ? -1 : 1;
}
```

Then use this to sort the array. 

```c
  qsort( list, length, sizeof( int ), cf_func );
```

This will put all occurrences of the same value next to each other, to facilitate counting. We iterate through the sorted array counting the number of occurrences of each value (using the same array! to show how clever I am). Then we sort this array of counts.

```c
  int j = 0;
  int current = list[0];
  list[0] = 1;

  for (int i=1; i < length; i++) {
    if (list[i] == current) {
      list[j]++;
    } else {
      current = list[i];
      list[++j] = 1;
    }
  }

  qsort( list, ++j, sizeof( int ), cf_func );
```

Now the highest count is the first element of the array because of descending ordering. We want to find how many unique values have the highest count, so we iterate along the count array until the value decreases, summing as we go, and this value is our answer.

```c
  int max = list[0];
  int sum = max;
  for (int i=1; i <= j; i++) {
    if (list[i] == max ) {
      sum += max;
    } else {
      break;
    }
  }
  
  return sum;
```

### Prolog

In Prolog the approach is basically the same as in C.

```prolog
max_freq_count( [], 0 ).
max_freq_count( L, X ) :-
    msort( L, L1 ), count_adjacents( L1, L2 ),
    msort( L2, L3 ), reverse( L3, L4 ),
    head( L4, H ),
    count_top( H, L4, X0 ),
    X is X0 * H.
```

We take a list `L`, sort it to `L1`, count the number of adjacent elements as `L2`. Next we sort `L2` giving `L3`, then reverse that so it is descending => `L4`. Take the first value of `L4` as `H`, the count how many values in the sorted list `L4` are equal to `H`. Times that count by the value `H` and, phew..., done!

To count the number of adjacent values, I do an old Prolog pattern using arity (number of args) to distinguish two identically named functions:

```prolog
count_adjacents( [], 0 ).
count_adjacents( [I|T], Out ) :-
    count_adjacents( I, T, Out ).
	
count_adjacents( _, [], [1] ).
count_adjacents( I, [I|Is], [O|Os] ) :-
    count_adjacents( I, Is, [O0|Os] ), succ( O0, O ), !.
count_adjacents( _, [I|Is], [1|Os] ) :-
    count_adjacents( I, Is, Os ).
```

The 2 arg version (`count_adjacents/2`) is what we expect to be outwardly called, while the 3 arg version is intended to be the internal, recursive function. 

If the list is empty the number of adjacent matching values is 0, otherwise, we take the head of the list, and try matching it against the tail of the list. I start the count at 1 since I have already removed the head from the list passed recursively. As long as the value matches the head, the count gets incremented, otherwise we add a new element to the array for the count of the next found value and recur.

```prolog
count_top( _, [], 0 ).
count_top( V, [H|_], X ) :-
    V =\= H, X is 0, !.
count_top( H, [H|T], X ) :-
    count_top( H, T, X0 ), succ( X0, X ).
```

To round it out, this function finds the number of consecutive elements in a list, starting from the beginning of the list, that have the value `V`. It recursively checks the first element of the list, and once it finds a value that doesn't match it stops checking.

Lots of recursive functions in Prolog this week!

## Conclusion

Some sneaky tricky challenges this week. I look forward to seeing what's in store for next week, and what appropriate/inappropiate languages I'll randomly select for myself.

Thanks as always!

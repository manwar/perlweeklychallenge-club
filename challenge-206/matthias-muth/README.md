# All the permutations...
**Challenge 206 solutions in Perl by Matthias Muth**

## Task 1: Shortest Time

> You are given a list of time points, at least 2, in the 24-hour clock format `HH:MM`.<br/>
> Write a script to find out the shortest time in minutes between any two time points.

The examples given are important for understanding that the shortest time between two time points might also span midnight.
That means that if the difference between two points of time is _n_ minutes, the 'shortest' difference may be either _n_ or (1440 - _n_)
(24 hours being 24 \* 60 = 1440 minutes).

I reduced the problem of finding the shortest time difference between *any two* timepoints to finding the shortest time difference of *one* timepoint with the rest of a list. which results in this function:

```perl
use List::Utils qw( min );

sub time_diffs( $fixed, @others ) {
    # Return all differences between one timestamp and a list of others.
    # Use the time difference spanning over midnight if it is shorter
    # (by simply using the minimum of both).
    return
        map { my $d = abs( $fixed - $others[$_] ); min( $d, (24*60) - $d ); }
            0..$#others;
}
```

Using this function, the rest is straightforward:<br/>
* Translate HH::MM times into minutes,
* Find the minimum of each time in the list with the rest of the list, using the above function.

```perl
sub shortest_time( @hhmm_times ) {
    # Turn HH:MM times into number of minutes.
    my @t = map { /^(\d+):(\d{2})$/; $1 * 60 + $2 } @hhmm_times;

    # Return the minimum of the time differences of every element with all
    # its successors. We can skip the last element, as it has no successor to
    # build a difference with.
    # We simplify the parameter list by just giving the whole
    # slice instead of giving the first element and its successors separately.
    return min( map time_diffs( @t[ $_ .. $#t ] ), 0 .. ( $#t - 1 ) );
}
```

Passing the parameters for `time_diffs`, I just pass a slice of the array. The first elemenet of the slice will be assigned to `$fixed` in the function, the rest of the parameters will be used for `@others`. I chose this as a compromise between self-explanation in the function and simplicity in the call.

Note that for the last element in the list we don't need to call the function, since there won't be any time difference if we have just one value.

## Task 2: Array Pairings

>You are given an array of integers having even number of elements..<br/>
>Write a script to find the maximum sum of the minimum of each pairs.

Ahm, what??<br/>
Ok, I see. the examples clear it up.<br/>
Actually we need to walk through all permutations of the given list.
Then for each permutation we need to use the 'minimum of each pair', sum them up, and then find the maximum of all those sums.
Ok, understood now.

So let's start by generating the permutations.

Again, there are good recommendations in the [Perl FAQ](https://perldoc.perl.org/perlfaq4#How-do-I-permute-N-elements-of-a-list%3F):
- Use the `List::Permutor` module on CPAN.
- If the list is actually an array (which it is in our case), try the `Algorithm::Permute` module (also on CPAN).

In any case, it is recommended to use an iterator to get the next permutation instead of generating all permutations beforehand, as the number of permutations (*n!*) rises very quickly with larger number of elements.

In our case, I did a thorough analysis of the possible set of input data ;-).<br/>
And as we only will need to solve the problem for two lists of only four elements each, I decided to go with a simple schoolbook recursive generation of the permutations.<br/>
The result of the function will be a list of arrayrefs, each one representing one permutation. And for symmetry reasoens, and to avoid shuffling values around, I chose to use an arrayref as input parameter, too. 

```perl
sub permute( $a_ref ) {
    return undef  unless defined $a_ref && ref $a_ref eq 'ARRAY';
    return ()     if @$a_ref == 0;
    return $a_ref if @$a_ref == 1;

    my @permutations;
    for my $i ( 0..$#$a_ref ) {
        my @others = @$a_ref;
        my $extracted = splice( @others, $i, 1, () );
        push @permutations, [ $extracted, @$_ ]
            for permute( [ @others ] );
    }
    return @permutations;
}
```

I have put each of the next two steps into a function of its own.<br/>
The first one splits the array into pairs and returns the sum on the smaller of the two values in each pair.<br/>
I am a fan of `map` calls, more efficient and most of the times easier to write than `for` loops.
My way of splitting up into pairs in a `map` uses the classical `0..$#a` loop values,
but skipping every other iteration using a `$_ % 2 == 0` criterion with a 0 to add to the sum.

The alternative is to increase the 'loop value' by two for each iteration, but I don't find a nice way to write that.
(Running through half of the array while doubling the loop variable doesn't look obvious enough for me.)

Actually, the iteration for the last value is not needed, so in fact we use `0..($#a-1)`.

```perl
use List::Util qw( min max sum );

sub sum_of_min_of_pairs( @a ) {
    return undef
        unless @a % 2 == 0;
    return sum(
        map $_ % 2 == 0 ? min( $a[$_], $a[ $_ + 1 ] ) : 0, 0..( $#a - 1 )
    );
}
```

The second function combines the generation of permutations and the `sum_of_min_of_pairs` computation for each of the permutations,
and returns the challenge result for the input array:

```perl
sub max_of_sums( @a ) {
    return undef
        unless @a % 2 == 0;
    return
        max( map sum_of_min_of_pairs( @$_ ), permute( [ @a ] ) );
}
```

**Thank you for the challenge!**

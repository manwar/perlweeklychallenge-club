# Take it to the Limits

**Challenge 344 solutions in Perl by Matthias Muth**

This week, both tasks have examples that do not really cover all the task's potential input ranges.<br/>
I tried to implement my solutions so that they also work well with some examples that test the limits and verify the solutions' scalability.  

## Task 1: Array Form Compute

> You are given an array of integers, @ints and an integer, \$x.<br/>
> Write a script to add \$x to the integer in the array-form.<br/>
> The array form of an integer is a digit-by-digit representation stored as an array, where the most significant digit is at the 0th index.
>
> **Example 1**
>
> ```text
> Input: @ints = (1, 2, 3, 4), $x = 12
> Output: (1, 2, 4, 6)
> ```
>
> **Example 2**
>
> ```text
> Input: @ints = (2, 7, 4), $x = 181
> Output: (4, 5, 5)
> ```
>
> **Example 3**
>
> ```text
> Input: @ints = (9, 9, 9), $x = 1
> Output: (1, 0, 0, 0)
> ```
>
> **Example 4**
>
> ```text
> Input: @ints = (1, 0, 0, 0, 0), $x = 9999
> Output: (1, 9, 9, 9, 9)
> ```
>
> **Example 5**
>
> ```text
> Input: @ints = (0), $x = 1000
> Output: (1, 0, 0, 0)
> ```

This tasks concept is about storing numbers as arrays of single digits. This immediately made me think of possible applications in arithmetics of *arbitrarily long numbers* like `BigInt`.

Bearing this in mind, I decided that my solution should also work with 'big' numbers, especially those that that exceed the typical 64-bit limit for normal scalars.

As the examples in the description are all dealing with small numbers only, I added these example to my tests:

> **Own Example 1**
>
> ```text
> Input: @ints = (9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9),
>        $x = 1
> Output: (1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 )
> ```

That's 20 digits of all 9s.<br/>
If we add 1 to it, we are getting a carryover in all positions, resulting in a 1 with 20 zeros.<br/>
$2^{64}$ is 18,446,744,073,709,551,616, a number with 20 digits, so both above numbers exceed the $2^{64}$ limit. 

> **Own Example 2**
>
> ```text
> Input: @ints = (1),
>     $x = 18446744073709551615
> Output: (1, 8, 4, 4, 6, 7, 4, 4, 0, 7, 3, 7, 0, 9, 5, 5, 1, 6, 1, 6)
> ```

That is $2^{64}-1$, the largest possible unsigned integer in 64-bit environments.<br/>
If this large number is added to the simple 1 in integer arithmetic, the result must be $2^{64}$.<br/>The example is not about whether the correct result can be expressed in the array output (of course it can!). The question is whether the implementation deals correctly with input edge cases.

Now let's talk about how exactly those big numbers can cause problems.

* If we use the value in `$x` as a permanent carryover that will be spread over the digits in `@ints`, we loop over the digits, starting with the least significant one, add the current value of `$x` to that digit, 
  then remove the last digit of the sum from `$x` and put that digit back into `@ints`, then we continue with the shortened value of `$x`.

  Problem: We can get an integer overflow when we add `$x` and the digit from `@ints`.<br/>
  The result then is unusable.

* We can reduce the number range by *first* splitting off the least significant digit. Then we only have to add two numbers in the range `0` to `9`. No problem.

  *Extracting* that last digit can be done using `$sum % 10`. No problem with that either.

  *Removing* the last digit is typically done using `int( $sum / 10 )`.

  Problem: The division by 10 internally is implemented as a floating point operation.<br/>
  And even if Perl uses _double precision floating point_, only integers up to around $2^{53}$ can be represented with all digits in floating point.<br/>This means that if we use the standard idiom, we risk losing correct digits that we need later if  `$x` is really big.

To avoid these problems, I chose an approach where splitting off digits is done only once, and it is done on the *string representation* of `$x`, something that is very easy in Perl:

```perl
    my @add_digits = split "", $x;
```

In fact, this extends the task to 'Adding *two* numbers in array representation'.<br/>But we will only have to deal with numbers in the range 0 to 9. Even if we add two of them we never risk any overflow.

Let's talk about the implementation:

Starting with a `$index` variable pointing to the least significant digit in the `@ints` array (that's the *last* element), the following is done in a loop, counting down `$index`:

* Remove the least significant digit from `@add_digits` and add it to the current `@ints` digit.

* If that digit now is greater than or equal to 10, subtract 10, and add 1 as a carryover to the now least significant `@add_digits` digit. Take caution that the `@add_digits` array could have been emptied completely in the previous step, so maybe a single new entry has to be recreated just for this carryover.  

* If `@add_digits` is empty, this ends the loop.<br/>
  All `$x` digits have been added to the existing array digits.

* If there are digits left in `@add_digits`, but all `@ints` digits have been processed, we can end the loop, too.<br/>We will deal with any leftover digits in `@add_digits` outside the loop.
  
* For the result, any leftover digits in `@add_digits` need to be prepended to the `@ints` digits.<br/>We can do so by simply returning `( @add_digits, @ints)` as the result.

This is the implementation of my solution. Note that `$ints` is an arrayref representing the `@ints`.


```perl
use v5.36;

sub array_form_compute( $ints, $x ) {
    my @add_digits = split "", $x;
    my $index = $ints->$#*;
    while ( @add_digits && $index >= 0 ) {
        $ints->[$index] += pop @add_digits;
        if ( $ints->[$index] >= 10 ) {
            $ints->[$index] -= 10;
            @add_digits ? ( $add_digits[-1] += 1 ) : ( $add_digits[0] = 1 );
        }
        --$index;
    }
    return ( @add_digits, $ints->@* );
}
```

## Task 2: Array Formation

> You are given two list: @source and @target.<br/>
> Write a script to see if you can build the exact @target by putting these smaller lists from @source together in some order. You cannot break apart or change the order inside any of the smaller lists in @source.
>
> **Example 1**
>
> ```text
> Input: @source = ([2,3], [1], [4])
>        @target = (1, 2, 3, 4)
> Output: true
>
> Use in the order: [1], [2,3], [4]
> ```
>
> **Example 2**
>
> ```text
> Input: @source = ([1,3], [2,4])
>        @target = (1, 2, 3, 4)
> Output: false
> ```
>
> **Example 3**
>
> ```text
> Input: @source = ([9,1], [5,8], [2])
>        @target = (5, 8, 2, 9, 1)
> Output: true
>
> Use in the order: [5,8], [2], [9,1]
> ```
>
> **Example 4**
>
> ```text
> Input: @source = ([1], [3])
>        @target = (1, 2, 3)
> Output: false
>
> Missing number: 2
> ```
>
> **Example 5**
>
> ```text
> Input: @source = ([7,4,6])
>        @target = (7, 4, 6)
> Output: true
>
> Use in the order: [7, 4, 6]
> ```

I can easily imagine a real-life puzzle like this, containing rectangular wooden pieces, similar to dominoes, bearing numbers on them. There would also be a game board with a longer sequence of numbers arranged in squares onto which the wooden pieces would be placed.

If I were to complete such a puzzle using the rules of this challenge task, I would start by checking the number on the first square of the board, and then selecting only pieces that start with that number.

To make this easier for me, I would first sort the pieces into **buckets**. Each bucket would contain only pieces with the same first number and would be labelled with that number.

After placing a piece, I would check the number on the next field to be covered, and again use only pieces from the corresponding bucket. If no match was possible at any point, I would use 'backtracking' (I can't deny my programming background!), and try a different available piece from the current or possibly from a previous bucket. 

This would reduce my search time drastically, compared to building every possible permutation of pieces and checking each one individually to see if it matches the target sequence. 

In Perl, the buckets can easily be implement using a hash. Each hash entry will contain an arrayref referencing the list of pieces in the bucket, while its key is the first element common to all those pieces:

```perl
    my %buckets;
    push $buckets{$_->[0]}->@*, $_
        for $source->@*;
```

My implementation then is based on

* a recursive function `can_be_formed( $buckets, $target )`<br/>that checks whether the target sequence can be formed using the pieces in the given buckets.
* and a helper function `array_starts_with( $try, $target )`<br/>that return `true` if the `$try` sequence matches the beginning of the `$target` sequence.

This is the helper function:

```perl
use v5.36;
use builtin qw( true false );
use List::Util qw( all );

sub array_starts_with( $try, $target ) {
    return $try->@* <= $target->@*
        && all { $target->[$_] eq $try->[$_] } keys $try->@*;
}
```

The `can_be_formed` recursive function first checks whether there is a bucket at all that corresponds to the first element in `$target`. If not, there is no chance of a complete match at all.

If there is a matching bucket, its pieces are tried in turn.

If a piece matches (checked using `array_starts_with`), we create a new target containing the rest of the target sequence that remains to do after the match.

If the new target sequence is empty, we have completed a full match, and we can return `true`.

If not, we need to try the remaining pieces against the rest of the target sequence, using a recursive call.

In preparation for that call, we create a new bucket list as a copy of the one we have, only that the matching piece is removed from its corresponding bucket. For this, we first do a shallow copy for all buckets. Then the bucket with the current label is replaced by a newly created one, copying all the pieces from the original bucket except the current matching piece.

If the recursive call returns true, the new target can be created from the remaining pieces in the buckets, and we can return `true`, too.<br/>If not, we continue the loop with the next piece.

If the loop exits after all the available pieces have been tried without finding a full match, we return `false`.

Put together, this is the recursive function:

```perl
sub can_be_formed( $buckets, $target ) {
    my $bucket_label = $target->[0];
    return false
        if ! exists $buckets->{$bucket_label};
    for ( keys $buckets->{$bucket_label}->@* ) {
        my $try = $buckets->{$bucket_label}[$_];
        next unless array_starts_with( $try, $target );

        # We have a match.
        my $new_target = [ $target->@[ $try->$#* + 1 .. $target->$#* ] ];
        
        # Maybe even a full match.
        return true
            if $new_target->@* == 0;

        my %new_buckets = $buckets->%*;
        $new_buckets{$bucket_label} = [
            $buckets->{$bucket_label}->@[
                0 .. $_ - 1,
                $_ + 1 .. $buckets->{$bucket_label}->$#*,
            ]
        ];

        # Recursive call for matching the rest.
        return true
            if can_be_formed( \%new_buckets, $new_target );
    }
    return false;
}
```

The main subroutine only creates the initial bucket list (as shown above already), and then returns the result of the first level call to `can_be_formed`. 

```perl
sub array_formation( $source, $target ) {
    my %buckets;
    push $buckets{$_->[0]}->@*, $_
        for $source->@*;
    return can_be_formed( \%buckets, $target );
}
```

For proving the efficiency of this approach, I added an own test case that consists of 12 pieces, with only one number in each piece, to form a 12 number target sequence.

> **Own Example 1**
>
> ```text
> Input: @source = ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12])
>        @target = (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
> Output: true
> ```

If all possible permutations of the source pieces are tried, there are up to more than 479 million of them that possibly need to be checked.<br/>
By contrast, my solution requires a total of 12 calls.<br/>I am OK with that.

#### **Thank you for the challenge!**

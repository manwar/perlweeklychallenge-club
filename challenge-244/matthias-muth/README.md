# ComPAIRisons, optimized

**Challenge 243 solutions in Perl by Matthias Muth**

## Task 1: Reverse Pairs

> You are given an array of integers.<br/>
> Write a script to return the number of reverse pairs in the given array.<br/>
> A reverse pair is a pair (i, j) where: a) 0 <= i < j < nums.length and b) nums[i] > 2 * nums[j].<br/>
> <br/>
> Example 1<br/>
> Input: @nums = (1, 3, 2, 3, 1)<br/>
> Output: 2<br/>
> (1, 4) => nums[1] = 3, nums[4] = 1, 3 > 2 * 1<br/>
> (3, 4) => nums[3] = 3, nums[4] = 1, 3 > 2 * 1<br/>
> <br/>
> Example 2<br/>
> Input: @nums = (2, 4, 3, 5, 1)<br/>
> Output: 3<br/>
> (1, 4) => nums[1] = 4, nums[4] = 1, 4 > 2 * 1<br/>
> (2, 4) => nums[2] = 3, nums[4] = 1, 3 > 2 * 1<br/>
> (3, 4) => nums[3] = 5, nums[4] = 1, 5 > 2 * 1<br/>

This is a typical challenge task of the class *'Combine every number with every other'*.<br/>
The obvious implementation is this:

```perl
sub reverse_pairs( @nums ) {
    my $count = 0;
    for my $i ( 0 .. $#nums - 1 ) {
        for my $j ( $i + 1 .. $#nums ) {
            ++$count
                if $nums[$i] > 2 * $nums[$j];
        }
    }
    return $count;
}
```

And it works fine out of the box.

I have recently become a fan of using a more 'functional' approach in my programming, and Perl actually offers a lot in this regard.
It starts with `map` and `grep` that use code blocks for processing lists of data. Next, any novice Perl programmer will rapidly appreciate the power of `sort`, using a simple code block to compare any type of data, allowing for complex sorting criteria without large programming efforts.

I also used to reckon that  
So I changed my solution above into this:

```perl
sub reverse_pairs_grep( @nums ) {
    my $count = 0;
    for my $i ( 0 .. $#nums - 1 ) {
        $count += scalar grep { $nums[$i] > 2 * $nums[$_] } $i + 1 .. $#nums;
    }
    return $count;
}
```

The whole inner loop now is in one statement, hiding the inner `for` loop in the `grep`.<br/>
To me, this also looks more efficient, because running the loop is now done 'under the hood', and can be implemented very efficiently.

Out of curiosity, I made a little benchmark, using the `Benchmark` core module.<br/>
I compared the two implementations, running the two small challenge examples in every iteration:

``` 
                       Rate reverse_pairs_grep      reverse_pairs
reverse_pairs_grep 184719/s                 --                -3%
reverse_pairs      190023/s                 3%                 --
```

Woah??<br/>
It seems that the `for` loop is more efficient than I expected!<br/>
Or, put the other way round, `grep` does not necessarily beat a `for` loop!
Maybe it plays a role that the parameters need to be passed into `grep`, which might involve copying the list.
Ok, lesson learned, good to know that `for` or `foreach` is nothing that needs to be avoided.

My curiosity then led me to try to see whether I could optimize the `for` loop version further.<br/>
I exchanged the inner and the outer loop, from
```perl
    for my $i ( 0 .. $#nums - 1 ) {
        for my $j ( $i + 1 .. $#nums ) {
```
to
```perl
    for my $j ( 1 .. $#nums ) {
        for my $i ( 0 .. $j - 1 ) {
```
This is the result of the benchmark:
```
                                 Rate reverse_pairs reverse_pairs_reversed_loops
reverse_pairs                187361/s            --                         -11%
reverse_pairs_reversed_loops 211017/s           13%                           --
```
Whoa again!!<br/>
The inside-out loop is faster than the original loop!

The inner and the outer loop have the same number of iterations in both cases:

`for $i` / `for $j` loop:<br/>
    `$i` iterations: $n - 1$<br/>
    all `$j` iterations: $(n-1) + (n-2) + \dots + 1 = \frac{(n-1)n}{2}$<br/>

`for $j` / `for $i` loop:<br/>
    `$j` iterations: $n - 1$<br/>
    all `$i` iterations: $1 + 2 + \dots + (n-1) = \frac{(n-1)n}{2}$<br/>

So the difference must be in the operations that are executed 'behind the scenes' implementing the iteration over the lists that are defined in the `for` statements.

My speculation is that probably the inner loop expressions `$i + 1 `  and `$#nums` for the first version
are more expensive to evaluate than `0` and `$j - 1` for the faster second version.<br/>
Which might make sense, because one might expect that the `$i + 1` and `$j - 1` complexity is the same,
and between `$#nums` and `0` it surely is more expensive to lookup the `@nums` array size than just using the constant `0`. 

As interesting as it may be to find why this 'optimization by chance' really works,
I expect that the performance difference will diminish when the `@num` array gets bigger.
So actually the 'out of the box' solution does a great job.

## Task 2: Floor Sum

> You are given an array of positive integers (>=1).<br/>
> Write a script to return the sum of floor(nums[i] / nums[j]) where 0 <= i,j < nums.length. The floor() function returns the integer part of the division.<br/>
> <br/>
> Example 1<br/>
> Input: @nums = (2, 5, 9)<br/>
> Output: 10<br/>
> floor(2 / 5) = 0<br/>
> floor(2 / 9) = 0<br/>
> floor(5 / 9) = 0<br/>
> floor(2 / 2) = 1<br/>
> floor(5 / 5) = 1<br/>
> floor(9 / 9) = 1<br/>
> floor(5 / 2) = 2<br/>
> floor(9 / 2) = 4<br/>
> floor(9 / 5) = 1<br/>
> <br/>
> Example 2<br/>
> Input: @nums = (7, 7, 7, 7, 7, 7, 7)<br/>
> Output: 49<br/>

This task, too, lets us *'combine every number with every other'*.<br/>
So let's see whether what we've learned from Task 1 can be applied here!<br/>
First, the obvious solution:

```perl
sub floor_sum( @nums ) {
    my $count = 0;
    for my $i ( 0..$#nums ) {
        for my $j ( 0..$#nums ) {
            $count += int( $nums[$j] / $nums[$i] );
        }
    }
    return $count;
}
```
Next, the '`grep`' version:
```perl
sub floor_sum_grep( @nums ) {
    my $count = 0;
    for my $i ( 0..$#nums ) {
        $count += sum( map int( $nums[$_] / $nums[$i] ), 0..$#nums );
    }
    return $count;
}
```
And the benchmark comparing the two:
```
                  Rate floor_sum_grep      floor_sum
floor_sum_grep 70447/s             --           -28%
floor_sum      97303/s            38%             --
```

The difference in favor of the `for` loop version is even more evident than in the previous task.
So let's stick with the `for` loops, for performance, and maybe also for readability.

I didn't run a benchmark with the loops turned around for this version,
because the loops are really identical here (both from `0` to `$#num`),
so there's nothing to expect from that.

**BUT!**<br/>
There's another possible optimization, and it even has nothing to do with Perl and choosing the right language constructs.<br/>
It actually is in the 'application domain'.

Let's visualize all combinations of the first example's numbers $( 2, 5, 9 )$ in a matrix,
with the division results as the matrix values. The values are sorted in ascending order already, which we could do for any list of numbers we get. Note that in the first example, all numbers are unique.

$$
\begin{array}{c|c & c & c}
   & 2 & 5 & 9 \\ 
  \hline
  2 & \text{int}(2/2) & \text{int}(2/5) & \text{int}(2/9) \\
  5 & \text{int}(5/2) & \text{int}(5/5) & \text{int}(5/9) \\
  9 & \text{int}(9/2) & \text{int}(9/5) & \text{int}(9/9) \\
 \end{array}
$$

From which we get these values to add up:

$$
\begin{array}{c|c & c & c}
   & 2 & 5 & 9 \\ 
  \hline
  2 & {\color{blue}1} & {\color{green}0} & {\color{green}0} \\
  5 & {\color{orange}2} & {\color{blue}1} & {\color{green}0} \\
  9 & {\color{orange}4} & {\color{orange}1} & {\color{blue}1}  \\
 \end{array}
$$

I have chosen colors for different parts of the matrix:<br/>

${\color{blue}Blue}$ for the diagonal.<br/>
All its values are always ${\color{blue}1}$.

${\color{green}Green}$ for the upper right part of the matrix.
All its values are ${\color{green}0}$, because the dividend is always smaller than the divisor (remembering that the numbers are sorted in ascending order).

${\color{orange}Orange}$ is the lower left part of the matrix. Here, we really need to divide the two numbers. We will get a non-zero result, because the divident is bigger than the divisor.

This means that we can reduce our loops to the lower left part of the matrix, because only there we will get significant numbers to add to our final result.
For the values of ${\color{blue}1}$ in the diagonal we add the matrix size (which is the length of the diagonal), and we are done.

Now what if the numbers are not unique, as in the second example?

In that case, a value will appear more than once, and it will be combined with its duplicate of the same value. We will encounter a division of $int(value/value) = 1$. The thing is that if that happens, there will also be a $1$ in the upper right part of the matrix at the same place. There, the values will be combined the other way round, but $int(value/value)$ will still be $1$.

This means that when we do the division, and the two values are the same, we add ${\color{orange}2}$ instead of ${\color{orange}1}$ to account for that. We don't actually need to do a division in that case.

Here is how this looks in code:

```perl
sub floor_sum_half_matrix( @nums ) {
    @nums = sort { $a <=> $b } @nums;
    my $count = 0;
    for my $i ( 0 .. $#nums - 1 ) {
        # Loop over larger or equal values only.
        for my $j ( $i + 1 .. $#nums ) {
            # Add 2 if the values are equal,
            # because each of $a/$b and $b/$a is 1.
            $count += $nums[$j] == $nums[$i] ? 2 : int( $nums[$j] / $nums[$i] );
        }
    }
    # Add 1 for each field in the diagonal.
    return $count + scalar @nums;
}      
```

The benchmark looks as if the change was worth it:
```
                          Rate             floor_sum floor_sum_half_matrix
floor_sum              95836/s                    --                  -40%
floor_sum_half_matrix 158906/s                   66%                    --
```

We then can squeeze out the last 3% by doing the 'reverse loop' trick from the previous task:

```perl
sub floor_sum_half_matrix_reversed( @nums ) {
    ...
    for my $j ( 1 .. $#nums ) {
        for my $i ( 0 .. $j - 1 ) {
            ...
        }
    }
    ...
}
```
```
                                   Rate floor_sum floor_sum_half_matrix floor_sum_half_matrix_reversed
floor_sum                       97713/s        --                  -38%                           -40%
floor_sum_half_matrix          158752/s       62%                    --                            -3%
floor_sum_half_matrix_reversed 163793/s       68%                    3%                             --
```
But this doesn't change a lot anymore, and knowing that my laptop can run the *Weekly Challenge 243 Task 2* examples in Perl around 160,000 times in one second is enough to give me a smile... :-)

#### **Thank you for the challenge!**

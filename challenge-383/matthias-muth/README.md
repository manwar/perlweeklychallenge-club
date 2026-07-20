# The Recursive Challenge

**Challenge 382 solutions in Perl by Matthias Muth**

## Task 1: Hamiltonian Cycle

*(Submitted by: Peter Campbell Smith)*

> You are given a target number.<br/>
> Write a script to arrange all the whole numbers from 1 up to the given target number into a circle so that every pair of side-by-side numbers adds up to a perfect square. Please make sure, the last number and the first must also add up to a square.
>
> **Example 1**
>
> ```text
> Input: $n = 32
> Output: 1, 8, 28, 21, 4, 32, 17, 19, 30, 6, 3, 13, 12, 24, 25, 11, 5, 31, 18, 7, 29, 20, 16, 9, 27, 22, 14, 2, 23, 26, 10, 15
>
> 1  + 8  = 9
> 8  + 28 = 36
> 28 + 21 = 49
> 21 + 4  = 25
> 4  + 32 = 36
> 32 + 17 = 49
> 17 + 19 = 36
> 19 + 30 = 49
>
> so on, all the way through the sequence.
> ```
>
> **Example 2**
>
> ```text
> Input: $n = 15
> Output: ()
>
> No valid circular list of numbers exists.
> ```
>
> **Example 3**
>
> ```text
> Input: $n = 34
> Output: 1, 8, 28, 21, 4, 32, 17, 19, 6, 30, 34, 15, 10, 26, 23, 2, 14, 22, 27, 9, 16, 33, 31, 18, 7, 29, 20, 5, 11, 25, 24, 12, 13, 3
>
> [2026-07-13 11:45]: Output was incorrect, corrected by E. Choroba.
> ```

A correct solution is a chain where the sum of two neighboring numbers is a perfect square.

If I want to construct such a chain, I start by choosing the first number as the start of the chain. It doesn't really matter which number I choose (from `1` to `$n`), because a correct chain is cyclic, and I can choose any of the numbers in the cycle as the first number. I make it simple and choose `1` as the first number.

I then have to choose the second number. I maintain a list of the numbers that have not yet been used (initially `2..$n`), and from this list I choose those numbers that added to the previous chain element add up to a perfect square.

For checking whether the sum of two numbers is a perfect square, I use a lookup table instead of computing the square root and checking whether it is integer every time I have to check. The lookup table contains a true value for each number that is a perfect square, from 1 to `( $n - 1 ) + $n`, which is the largest possible sum of two numbers that we may need to look up. This changes the square test from an expensive square-root computation into a simple array lookup, saving a lot of CPU cycles. At the same time the setup of the lookup table is simple enough:

```perl
    my @is_square;
    for ( my $i = 1; ( my $square = $i * $i ) <= ( $n - 1 ) + $n; ++$i ) {
        $is_square[ $square ] = 1;
    }
```

After assigning a matching number to the chain, I have to check whether the remaining numbers can complete a correct chain using the same mechanism. I use a recursive function to do that. The function gets the chain built so far as a parameter, and the list of numbers that are still available. It returns all correct chains found using the recursion:

```perl
use v5.36;
use builtin qw( true false );
no warnings 'experimental::builtin';
use Test2::V0 qw( -no_srand );

my @is_square;

sub descend_hamiltonian( $chain, $available ) {
    my @solutions;
    if ( $available->@* == 0 ) {
        return $is_square[ $chain->[-1] + $chain->[0] ] ? $chain : ();
    }
    for ( keys $available->@* ) {
        if ( $is_square[ $chain->[-1] + $available->[$_] ] ) {
            push @solutions,
                descend_hamiltonian(
                    [ $chain->@*, $available->[$_] ],
                    [ $available->@[ 0 .. $_ - 1, $_ + 1 .. $available->$#* ] ]
                );
            # If we want to stop searching after we found
            # the first solution, we return from here:
            # return @solutions
            #     if @solutions;
        }
    }
    # For all solutions, we return from here:
    return @solutions;
}
```

(Note that I moved the `@is_square` lookup table outside the main subroutine, so that the recursive subroutine can access it.)

Like most backtracking algorithms, this has exponential worst-case complexity. Fortunately, the challenge input sizes are small enough that this straightforward approach works well.

The main procedure initializes the square lookup table, then it invokes the recursive search and returns the first solution:

```perl
sub hamiltonian_cycle( $n ) {
    # Create a lookup table for all perfect squares up to the largest
    # possible sum of two numbers i, j <= n.
    # It is much faster to look up whether ( i + j ) is a square number than
    # repeatedly computing the square root of ( i + j ) and checking
    # whether it is an integer.
    for ( my $i = 1; ( my $square = $i * $i ) <= ( $n - 1 ) + $n; ++$i ) {
        $is_square[ $square ] = 1;
    }

    # Start recursion with the first element as the chain, and all other
    # numbers available for completing the chain.
    # Use an array for the solutions, as there can be many of them.
    my ( $chain, $available ) = ( [ 1 ], [ 2..$n ] );
    my @solutions = descend_hamiltonian( $chain, $available );
    note "found ", scalar( @solutions ),
        scalar @solutions == 1 ? " solution" : " solutions";

    # Even if there can be multiple solutions, only return the first one.
    return @solutions ? $solutions[0]->@* : ();
}
```

There may be no solution at all (as in Example 2).<br/>
But if there is a solution, there will be also be at least one other: the reversed chain of the first solution. The reversed chain fulfills the 'perfect square' criteria for all adjacent pairs of numbers just as the original chain does.



This is only to illustrate that there never is one single solution - we have either none, or several of them.

But this means that our subroutine might return a solution that is correct but is different from the one given as 'Output' in the task example. As a consequence, just testing whether the output of our program results in the example output does not necessarily work.

Typically, a test would look like this:

```perl
use Test2::V0;
is [ hamiltonian_cycle( 34 ) ],
    [ 1, 8, 28, 21, 4, 32, 17, 19, 6, 30, 34, 15, 10, 26, 23, 2,
        14, 22, 27, 9, 16, 33, 31, 18, 7, 29, 20, 5, 11, 25, 24, 12, 13, 3 ],
    "Example 3";
```

But this test will fail if the first chain produced by `hamiltonian_cycle( 34 )` is not the expected one.

I therefore changed my testing strategy, and implemented a checking function for use with `Test2::V0` that tests whether the output is a correct chain:

```perl
sub chain_check {
    my $chain = $_;		# Per Test2::V0 convention, validator callbacks
                        # receive the value to be checked in $_.
    return () unless $chain->@*;
    # Cheating for index 0 to compare with $chain->[-1], which miraculously
    # is the end of the chain.
    for ( keys $chain->@* ) {
        return false unless $is_square[ $chain->[$_] + $chain->[ $_ - 1 ] ];
    }
    return true;
}
```

Then, my tests look like this:

```perl
my @tests = (
    [ "Example 1", 32, validator( \&chain_check ) ],
    [ "Example 2", 15, [] ],
    [ "Example 3", 34, validator( \&chain_check ) ],
);

is [ hamiltonian_cycle( $_->[1] ) ], $_->[2], $_->[0]
    for @tests;

done_testing;
```

This was a good reminder that not every algorithm has a unique correct answer. Sometimes the right way to test is to validate the properties of the result rather than compare it with a single expected output.

I have learned about the `validator` checking function of `Test2::V0`. That's a useful lesson for me!

## Task 2: Replace Question Mark

*(Submitted by: Simon Green)*

> You are given a string that contains only 0, 1 and ? characters.<br/>
> Write a script to generate all possible combinations when replacing the question marks with a zero or one.
>
> **Example 1**
>
> ```text
> Input: $str = "01??0"
> Output: ("01000", "01010", "01100", "01110")
> ```
>
> **Example 2**
>
> ```text
> Input: $str = "101"
> Output: ("101")
> ```
>
> **Example 3**
>
> ```text
> Input: $str = "???"
> Output: ("000", "001", "010", "011", "100", "101", "110", "111")
> ```
>
> **Example 4**
>
> ```text
> Input: $str = "1?10"
> Output: ("1010", "1110")
> ```
>
> **Example 5**
>
> ```text
> Input: $str = "1?1?0"
> Output: ("10100", "10110", "11100", "11110")
> ```

If `$str` contains a question mark `'?'`, it can be replaced by a `'0'` or a `'1'`. If there are more question marks, they have to be replaced using both of these results as the base.

This lends itself to a recursive approach again. The solution subroutine returns the string given as parameter as it is if it doesn't contain any question marks. This serves as the end condition for the recursion.

If there is a question mark, the subroutine recursively calls itself for the string with the question mark replaced by `'1'` and with the question mark replaced by `'0'`. If it was the last question mark, both calls will just return their parameters. If more question marks remain, each recursive call repeats the same process until eventually every branch reaches a string without question marks.

For detecting the presence of a question mark, I keep it short and simple by using regular expressions.

A neat Perl feature is that an empty search pattern in `s///` reuses the most recent successful match. Since `/\?/` has already located the question mark, `s//0/r` and `s//1/r` can replace exactly that character without searching the string a second time.

The solution is quite a bit shorter and simpler than the previous one:

```perl
use v5.36;

sub replace_question_mark( $str ) {
    return
        $str =~ /\?/
        ? ( replace_question_mark( $str =~ s//0/r ),
            replace_question_mark( $str =~ s//1/r ) )
        : ( $str );
}
```

#### **Thank you for the challenge!**

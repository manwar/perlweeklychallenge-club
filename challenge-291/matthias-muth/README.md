# Take Me to the Luhn and Back

**Challenge 290 solutions in Perl by Matthias Muth**

A classical simple and short solution for Task 1.

For Task 2, I have found some ways to reduce the complexity of the computation a bit (read below),<br/> and implemented several solutions;  

* a 'short' solution, just calling the `is_valid` function from `Algorithm::LUHN` from CPAN,
* a 'classic' solution, simply following the task description word by word,
* a 'modern' solution, using some optimizations of the algorithm, and making use of recent Perl language additions,<br/>
   like `builtin 'indexes'` for numbering the elements of an array, and `feature 'for_list` for a multi-variable `for` loop,
*  a 'pairmap' solution, using `pairmap` from `List::Util` to avoid permanently checking whether we are on an even or odd iteration.

A little benchmark proves that the optimized 'pairmap' solution really is faster than the others...


## Task 1: Double Exist

> You are given an array of integers, @ints.<br/>
> Write a script to find if there exist two indices \$i and \$j such that:<br/>
>
> 1) $i != $j<br/>
> 2) 0 <= ($i, $j) < scalar @ints<br/>
> 3) $ints[$i] == 2 * $ints[$j]<br/>
> <br/>
> Example 1<br/>
> Input: @ints = (6, 2, 3, 3)<br/>
> Output: true<br/>
> For $i = 0, $j = 2<br/>
> $ints[$i] = 6 => 2 * 3 =>  2 * $ints[$j]<br/>
> <br/>
> Example 2<br/>
> Input: @ints = (3, 1, 4, 13)<br/>
> Output: false<br/>
> <br/>
> Example 3<br/>
> Input: @ints = (2, 1, 4, 2)<br/>
> Output: true<br/>
> For $i = 2, $j = 3<br/>
> $ints[$i] = 4 => 2 * 2 =>  2 * $ints[$j]<br/>

This task is a variation of the *'Create a hash, then check existence'* theme.<br/>
Here, we use a simple hash for existence lookup (not a frequency table, as we often need),
where we can put the hash's declaration and populating its values in one line.

We check whether there is any number for which its doubled value exists in the lookup.
Instead of programming a loop, I use the `any` function from `List::Util` here.<br/>
Simple as this:

```perl
use v5.36;

use List::Util qw( any );

sub double_exist( @ints ) {
    my %existence = map { $_ => 1 } @ints;
    return any { $existence{ $_ * 2 } } @ints;
}
```


## Task 2: Luhn’s Algorithm

> You are given a string \$str containing digits (and possibly other characters which can be ignored). The last digit is the payload; consider it separately. Counting from the right, double the value of the first, third, etc. of the remaining digits.<br/>
> For each value now greater than 9, sum its digits.<br/>
> The correct check digit is that which, added to the sum of all values, would bring the total mod 10 to zero.<br/>
> Return true if and only if the payload is equal to the correct check digit.<br/>
> It was originally posted on reddit.<br/>
> <br/>
> Example 1<br/>
> Input: "17893729974"<br/>
> Output: true<br/>
> Payload is 4.<br/>
> Digits from the right:<br/>
> 7 * 2 = 14, sum = 5<br/>
> 9 = 9<br/>
> 9 * 2 = 18, sum = 9<br/>
> 2 = 2<br/>
> 7 * 2 = 14, sum = 5<br/>
> 3 = 3<br/>
> 9 * 2 = 18, sum = 9<br/>
> 8 = 8<br/>
> 7 * 2 = 14, sum = 5<br/>
> 1 = 1<br/>
> Sum of all values = 56, so 4 must be added to bring the total mod 10 to zero. The payload is indeed 4.<br/>
> <br/>
> Example 2<br/>
> Input: "4137 8947 1175 5904"<br/>
> Output: true<br/>
> <br/>
> Example 3<br/>
> Input: "4137 8974 1175 5904"<br/>
> Output: false<br/>

#### First Version: Very Short!

For this task, I guess that this here is among the shortest possible solutions: 

```perl
use Algorithm::LUHN qw( is_valid );

sub luhn_s_algorithm_by_module( $input ) {
    return is_valid( $input =~ s/\D//gr );
}
```

CPAN is your friend!

#### Second version: Very Classic.

For a first Do-It-Yourself solution, we closely follow the task description.<br/>
After extracting the digits from the input string into an array using a `/\d/g`regular expression,
we reverse the array.
That way, the digits are in the order we need to process them.<br/>
The first digit now is the check digit,
which we `shift` out from the array into a separate variable.

We check the special case of not finding any digits in the input string,
and return a false value (actually, implicitly an empty list) in that case.

Next, we loop over the digits, building the checksum.
Depending on being in an even or odd iteration, we simply add the digit, or we double it.
When we do that, the task description says:<br/>
    *'For each value now greater than 9, sum its digits.'*<br/>
I use the most Perlish approach: split the digits up using `split`, and then `sum` them up.

For the return value we have to compute the check digit from the checksum,
which is  'the difference to the next number divisible by ten'.
The [Wikipedia article](https://en.wikipedia.org/wiki/Luhn_algorithm) about Luhn's Algorithm gives this formula:
$(10-(s \mod 10 )) \mod 10$.<br/>
Then we compare the computed check_digit with the one from the input string.

Nothing really special in there.<br/>
But there is potential for improvement! 

```perl
#
#   luhn_s_algorithm_classic
#
#   Extracting the digits, separating the check digit,
#   then walking through the digits in a loop.
#   Taking a 'perlish' approach for doing the digit sum of doubled digits.
#
#   Hold your breath, this is not the final version!
#
sub luhn_s_algorithm_classic( $input ) {

    # Extract the digits into an array.
    my @digits = $input =~ /\d/g;

    # Return if there are no digits.
    @digits or return;

    # Extract the check-digit.
    my $check_digit = pop @digits;

    # Reverse the digit array to process the digits in the suggested order.
    @digits = reverse @digits;

    # Determine the checksum in a loop.
    my $checksum = 0;
    for my $index ( 0..$#digits ) {
        $checksum +=
            ( $index % 2 == 0 )
            ? sum( split "", 2 * $digits[$index] )
            : $digits[$index];
    }

    # Return true if the difference between the checksum and the next
    # number divisible by 10 is equal to the check-digit.
    return ( 10 - $checksum % 10 ) % 10 == $check_digit;
}
```

#### Some Algorithm Simplifications

There are some simplifications that we can apply to the algorithm to make things easier:

* When we do the doubling of every other digit, we have some knowledge:<br/>
  We know that the number cannot be larger than 18 (two times the digit 9).<br/>
  So let's see if this helps to avoid the overhead of two subroutine calls just for
  splitting and adding up at most two digits.
  
  * For digits up to 4, their highest double value is 8.<br/>
    That's a one digit number.<br/>
    Now this is a very simple digit sum!
  * For digits from 5 to 9, the double is between 10 and 18.<br/>
    So we need to add the '1' and the lower digit of the double.<br/>
    That lower digit happens to be the double minus 10
    (we're using our knowledge here! ).<br/>
    So we got 'one plus the double minus 10',
    which is the same as 'the double minus 9' for the digits 5 to 9.<br/>
    That's not too bad, either!<br/>
  
  That means instead of calling `split`  and `sum` we can use this simple numeric expression in Perl for the digit sum of the doubled digit:
  
  ```perl
     $digit < 5 ? ( 2 * $digit ) : ( 2 * $digit ) - 9
  ```
  
* When we compute the check digit for a checksum,
  it is chosen to *complement* the checksum up to the next number divisible by ten.<br/>
  But that means that if we add the check_digit to the checksum,
  the result will be divisible by 10.
  
  So we can simplify
  
  ```perl
      ( 10 - $checksum % 10 ) % 10 == $check_digit
  ```
  
  to
  
  ```perl
      ( $checksum + $check_digit ) % 10 == 0
  ```
  
  This saves us one modulo operation. But that's not all!
  
  If we include the check digit already when we sum up all the digits,
  we can get rid of the separate `$check_digit` variable completely.
  
  We only need to make sure that it is counted simple, not double.<br/>
  But we get this automatically, if we just don't
  'double the value of the *first*, *third*, etc. of the remaining digits',
  but we 'double the value of the *second*, *fourth*, etc.'.

Let's see how these simplifications look in real code:

#### Third Version: Explicit and 'Modern'.

So our next, simplified, DIY version, extracts *all* the digits, including the check digit.
We can do all of extraction, reversing the list and the check for an empty list in one statement.

```perl
    my @digits = reverse $input =~ /\d/g
        or return;
```

For the loop, in this version I use a combination of two 'modern' Perl features,
`use builtin 'indexed'` and `feature 'for_list'`, available from Perl 5.36 onwards:

-  `indexed @digits` gives us a list with every digit's index followed by the digit itself,
  like:<br/>
  `indexed( 7, 9, 9, 2)  => ( 0, 7, 1, 9, 2, 9, 3, 2 )`

- A multi-variable `for` loop then gives us access on the index and the digit easily,
  so that we can sum up correctly:

  ```perl
  my $checksum = 0;
  for my ( $index, $digit ) ( indexed @digits ) {
      $checksum +=
          $index % 2 == 0
          ? ...       # expression for even positions
          : ...;      # expression for odd positions
  }
  ```
  One nice thing about this 'indexed'/multi-variable `for` loop combination is
  that the index variable is an integral part of the loop, scoped within the loop only.
  
  But more importantly, in comparison to the typical index auto-increment,
  we also *avoid needing to think* about these typical questions:

  - 'Do we need a pre- or post-increment here?' (depends on how it's initialized!),
  - 'Shall I put it on the first use, or on the last use? (the same!),
  - 'Oops, I have an off-by-one problem now' (oh, I chose the wrong place in the last question),
  - 'Why the hell do I have an endless loop? &ndash;
    Ah, I forgot to put the auto-increment on a separate statement
    when the expression got too complicated.' ...

  Actually all my own experience, of course!.<br/>
  That's why I like the clearness of the `indexed` 'for' loop.

All this, and the optimizations described before, put  together:

```perl
use v5.36;
use builtin qw 'indexed';
no warnings 'experimental';

#
#   luhn_s_algorithm_modern
#   Algorithmic simplifications:
#   - summing up *including* the check-digit, the total sum modulo 10
#     must then be zero,
#   - using a simplified, numeric formula for the digit sum of
#     doubled digits (less function calls, less type conversions).
#   Using 'modern' Perl features:
#   - using the 'indexed' builtin to add indices to the digits,
#   - together with a multi-variable 'for' loop,
#   - using the 'false' builtin to return false when the input string
#     contains no digits.
sub luhn_s_algorithm_modern( $input ) {
    my @digits = reverse( $input ) =~ /\d/g
        or return;
    my $checksum = 0;
    for my ( $index, $digit ) ( indexed @digits ) {
        $checksum +=
            $index % 2 == 0
            ? $digit
            : $digit <= 4 ? ( 2 * $digit ) : ( 2 * $digit ) - 9;
    }
    return $checksum % 10 == 0;
}
```

#### Third Version: Pairmap.

As nice as the `indexed` for loop is, there's one thing that I still find inefficient:
we need to compute whether we are at an even or odd index for each iteration,
so again and again.<br/>
Could that not be avoided?<br/>
It can:

`List::Util` contains the `pairs` function, that returns pairs of elements of an array at a time.<br/>
Its sibling function, `pairmap` even assigns the two element to `$a` and `$b`,
and offers a code block to do the iteration work.<br/>
So let's do that, summing up the results of all iterations using `sum`.

We only need to make sure that we have an even number of elements in the array for `pairmap`.
We append a zero if not.

```perl
#
#   luhn_s_algorithm_using_pairmap
#
#   Using 'sum' and 'pairmap' to compute the checksum,
#   making even/odd computations unneccessary.
#   We need to make sure that we have an even number of digits,
#   so we add a '0' if necessary.
#   The digits will be $a and $b inside the pairmap code block.
#

use List::Util qw( sum pairmap );
 
sub luhn_s_algorithm_using_pairmap( $input ) {
    my @digits = reverse $input =~ /\d/g
        or return;
    @digits % 2 == 0 or push @digits, 0;
    my $checksum =
        sum( pairmap {
                $a + ( $b <= 4 ? ( 2 * $b ) : ( 2 * $b ) - 9 )
            } @digits );
    return $checksum % 10 == 0;
}
```

Now I am happy with this solution .<br/>
Especially as I have run a little benchmark with the `Benchmark` core module
to compare the run times of the four functions:

```text
            Rate classic  module  modern pairmap
classic 141953/s      --    -18%    -27%    -41%
module  172504/s     22%      --    -11%    -29%
modern  194323/s     37%     13%      --    -20%
pairmap 241917/s     70%     40%     24%      --
```

Obviously, the 'classic' version is slower than all the others.
That's probably due to the digit count `split` and `sum`.<br/>
And it shows that the 'pairmap' version really is quite a bit faster than the 'modern' version.

The reason for the CPAN version ('module') being slower
than the other homemade solutions probably lies in its added functionality
of being able to use additional values for any digits or symbols (like 10..35 for 'A' to 'Z').
It therefore has to do a lookup of the value attached to any processed digit.<br/>
For production code, I probably still would prefer using `Algorithm::LUHN`.
It's well documented, well tested, 
and it avoids maintenance  cost for any code of our own.

Stlll, it was nice developing and optimizing these solutions!

**Thank you for the challenge!**

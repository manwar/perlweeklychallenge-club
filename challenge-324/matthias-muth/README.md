# Decrement Your Tax Amount.

**Challenge 323 solutions in Perl by Matthias Muth**

## Task 1: Increment Decrement

> You are given a list of operations.<br/>
> Write a script to return the final value after performing the given operations in order. The initial value is always 0.<br/>
> ```text
> Possible Operations:
> ++x or x++: increment by 1
> --x or x--: decrement by 1
>```
> 
> **Example 1**
>
> ```text
> Input: @operations = ("--x", "x++", "x++")
> Output: 1
>
> Operation "--x" =>  0 - 1 => -1
> Operation "x++" => -1 + 1 =>  0
> Operation "x++" =>  0 + 1 =>  1
>```
> 
>**Example 2**
> 
>```text
> Input: @operations = ("x++", "++x", "x++")
> Output: 3
> ```
>
> **Example 3**
>
> ```text
>Input: @operations = ("x++", "++x", "--x", "x--")
> Output: 0
> 
> Operation "x++" => 0 + 1 => 1
>Operation "++x" => 1 + 1 => 2
> Operation "--x" => 2 - 1 => 1
> Operation "x--" => 1 - 1 => 0
> ```


I simplify the task specification by saying that
'anything containing `++`' increments the result value,
and 'anything containing `--`' decrements the result value.
Using regular expressions, of course,
and a combination of `sum0` and `map`,
this makes my solution even shorter:  

```perl
use v5.36;

use List::Util qw( sum0 );

sub increment_decrement( @operations ) {
    return sum0( map /\Q++/ ? +1 : /--/ ? -1 : 0, @operations );
}
```
`sum0` returns a value of `0` when there are no values to sum up at all,
which should be the correct behaviour for our little solution
when the list of operations is empty.

The `\Q` in the `/\Q++/` pattern serves to quote everything
from that point onward,
which removes the special meaning of the `+` signs
within the regular expression, and makes it nicer to read.

And that's it! 

## Task 2: Tax Amount

> You are given an income amount and tax brackets.<br/>
> Write a script to calculate the total tax amount.
>
> **Example 1**
>
> ```text
> Input: $income = 10, @tax = ([3, 50], [7, 10], [12,25])
> Output: 2.65
>
> 1st tax bracket upto  3, tax is 50%.
> 2nd tax bracket upto  7, tax is 10%.
> 3rd tax bracket upto 12, tax is 25%.
>
> Total Tax => (3 * 50/100) + (4 * 10/100) + (3 * 25/100)
>           => 1.50 + 0.40 + 0.75
>           => 2.65
>```
> 
>**Example 2**
> 
>```text
> Input: $income = 2, @tax = ([1, 0], [4, 25], [5,50])
> Output: 0.25
> 
>Total Tax => (1 * 0/100) + (1 * 25/100)
>        => 0 + 0.25
>           => 0.25
>    ```
>
> **Example 3**
>
> ```text
>Input: $income = 0, @tax = ([2, 50])
> Output: 0
> ```

I think my solution this week is less 'elegant' than I would wish for.<br/>
What I hope, though, is that it is still readable and comprehensible
even without a lot of comments.<br/>
I put in some effort to choose good variable names,
and to avoid overloaded or too long statements.

So let's calculate taxes!

We loop over the tax brackets in order,
and cumulate the partial amounts from each bracket in a variable `$tax_amount`.

In each iteration, we need to decide what part of the income
falls into the current bracket.
We always need the lower limit of the bracket for this,
which happens to be the upper limit of the previous bracket.
So we use a variable `$prev_bracket`
to transport that limit from iteration to iteration.<br/>
Both variables are initialized to zero:

```perl
    my ( $tax_amount, $prev_bracket ) = ( 0, 0 );
```

Within the loop, if the bracket's lower limit
(which we have in `$prev_bracket`) is higher than the income,
we are done, and we can exit the loop right away.<br/>
If not, we assign the two values of the current tax bracket to variables,
to be clear about what they mean:

```perl
    for ( $tax->@* ) {
        last if $income <= $prev_bracket;
        my ( $bracket, $percentage ) = $_->@*;
```

Now we can determine the amount that will be taxed
using the current bracket and percentage.<br/>
If the income is higher than the bracket's upper limit,
the complete bracket interval is taxed,
from the lower limit all the way up to the upper limit.<br/>
If the income is lower than the upper limit,
we only tax the amount up to there.<br/>
To make it easy,
we first determine the amount up to which we apply the tax:

```perl
        my $bracketed_amount = $income < $bracket ? $income : $bracket;
```

Based on that, we can add the partial tax amount to the cumulated sum:

```perl
        $tax_amount += ( $bracketed_amount - $prev_bracket ) * $percentage;
```

In fact, we should divide by 100 to get the correct amount.
But we will postpone that division
until all the partial amounts have been summed up.

At the end of the loop definition,
we store the bracket limit for the next round:

```perl
        $prev_bracket = $bracket;
    }
```

Once the loop is done, we return the cumulated tax amount,
not forgetting the division by 100:

```perl
    return $tax_amount / 100;
```

This concludes the solution:

```perl
use v5.36;

sub tax_amount( $income, $tax ) {
    my ( $tax_amount, $prev_bracket ) = ( 0, 0 );
    for ( $tax->@* ) {
        last if $income <= $prev_bracket;
        my ( $bracket, $percentage ) = $_->@*;
        my $bracketed_amount = $income < $bracket ? $income : $bracket;
        $tax_amount += ( $bracketed_amount - $prev_bracket ) * $percentage;
        $prev_bracket = $bracket;
    }
    return $tax_amount / 100;
}
```

In the real world, I would probably consider
doing correct rounding of the result.<br/>
But correct rounding in financial applications? That is a Pandora's Box ...

I would probably also wonder what happens
when the income is higher than the last bracket.<br/>
Can we specify an upper limit of 'infinity'?

I think that 'in the real world',
the tax brackets would not be defined like
'*up to this amount*, this percentage is applied',
but like like
'*from this amount onward*, this percentage is applied'.
The first bracket would always start from zero,
and the last bracket would be valid for any income
that is larger than that bracket's limit,
no matter how high the income is.

But hey! Nice challenge! 

#### **Thank you for the challenge!**

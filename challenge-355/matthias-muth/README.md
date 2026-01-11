# Thousand Mountains

**Challenge 355 solutions in Perl by Matthias Muth**

## Task 1: Thousand Separator

> You are given a positive integer, $int.<br/>
> Write a script to add thousand separator, and return as string.
>
> **Example 1**
>
> ```text
> Input: $int = 123
> Output: "123"
> ```
>
> **Example 2**
>
> ```text
> Input: $int = 1234
> Output: "1,234"
> ```
>
> **Example 3**
>
> ```text
> Input: $int = 1000000
> Output: "1,000,000"
> ```
>
> **Example 4**
>
> ```text
> Input: $int = 1
> Output: "1"
> ```
>
> **Example 5**
>
> ```text
> Input: $int = 12345
> Output: "12,345"
> ```

It would be so easy to do this with a regular expression if we only could work from left to right.

But why not just turn the string around and do that, and then turn the result around again?

Looks like this:  

```perl
sub thousand_separator_reverse( $int ) {
    return scalar reverse( reverse( $int ) =~ s/(\d{3})(?=\d)/$1,/gr );
}
```

The regex adds a comma after each group of three digits *if there is at least one digit following*, checked with a lookahead.<br/>
With the `/g` (*global*) flag, the loop is implicit, and with the `/r` (*return*) flag, the result is returned instead of doing the substitution on the input variable (which we don't even have in this case).

But as simple as it looks, it is not really efficient.

I tried another solution, using `substr` instead of a regex to extract the digit groups.<br/>The result variable (`$result`) is initialized with a first group of 1, 2 or 3 digits, so that then, only full 3-digit groups remain.<br/>
An index variable `$i` points to the next group.<br/>
As long as we haven't reached the end of the string, the next group of three is appended to the result, separated by a comma.

```perl
sub thousand_separator_substr( $int ) {
    my $i = ( length( $int ) - 1 ) % 3 + 1;
    my $result = substr( $int, 0, $i );
    $result .= "," . substr( $int, ( $i += 3 ) - 3, 3 )
        while $i < length( $int );
    return $result;
}
```

Of course this is *a lot* faster. These are the benchmark results:

```text
             Rate reverse  substr
reverse  472615/s      --    -64%
substr  1305126/s    176%      --
```

In a production environment, I would probably prefer this solution.

## Task 2: Mountain Array

> You are given an array of integers, @ints.<br/>
> Write a script to return true if the given array is a valid mountain array.<br/>
> An array is mountain if and only if:<br/>
>
> 1) arr.length >= 3<br/>
> and<br/>
> 2) There exists some i with 0 < i < arr.length - 1 such that:<br/>
> arr[0] < arr[1]     < ... < arr[i - 1] < arr[i]<br/>
> arr[i] > arr[i + 1] > ... > arr[arr.length - 1]
>
> **Example 1**
>
> ```text
> Input: @ints = (1, 2, 3, 4, 5)
> Output: false
> ```
>
> **Example 2**
>
> ```text
> Input: @ints = (0, 2, 4, 6, 4, 2, 0)
> Output: true
> ```
>
> **Example 3**
>
> ```text
> Input: @ints = (5, 4, 3, 2, 1)
> Output: false
> ```
>
> **Example 4**
>
> ```text
> Input: @ints = (1, 3, 5, 5, 4, 2)
> Output: false
> ```
>
> **Example 5**
>
> ```text
> Input: @ints = (1, 3, 2)
> Output: true
> ```

We need to have at least three elements in the array:
a rising edge, a 'peak', and a falling edge.
So I started with checking that first.
I don't want any surprises even when the subroutine is called
with an empty array.

Then, I tried to optimize the conditional statements and loop controls
so that no condition is checked more than once,
trying to get the best runtime performance possible.

I use an index variable `$i` to walk through the array.
For reducing the number of index calculations
and indexed accesses into the array,
I decided to use what I call a 'towing' variable,
which I named `$prev`
because it keeps the *previous* array element for comparisons.
It is updated to the current element
just before moving to the next one.

I use two loops,
one for the mountain's rising edge, and one for its falling edge.
It seems that exiting a loop the normal way also has a runtime cost,
so instead of putting the two loops one after the other,
using a `while` or `until` condition,
I put the condition into an `if` statement right within the first loop's body.
If we are not climbing anymore,
the second loop will be started right where this is detected.
Neither of the two loops is exited in the normal way,
because the moment the result is known,
a `return` statement will directly jump out of both loops
and out of the whole subroutine.

This is the fastest I can get:  

```perl
use v5.36;
use builtin qw( true false );

sub mountain_array_loop( @ints ) {
    return false if @ints < 3;
    my ( $i, $prev ) = ( 1, $ints[0] );
    return false unless $ints[$i] > $prev;
    while () {
        $prev = $ints[$i++];
        return false if $i == $#ints;
        if ( $ints[$i] <= $prev ) {
            while () {
                return false if $ints[$i] == $prev;
                $prev = $ints[$i++];
                return true if $i == $#ints;
            }
        }
    }
}
```

But there also is a more 'elegant' solution that I have tried.

Instead of using a 'trailing' variable,
this solution uses `slide` from `List::MoreUtils`,
which makes the previous and the current array value
available in special variables `$a` and `$b`.
It uses a boolean status variable `$climbing`
to know whether we are on the rising or the falling edge.

The code is much shorter,
because it does not have to deal with keeping an index
or maintaining a 'towing' variable.
It can therefore concentrate on the decisions to get to the next state:

```perl
use List::MoreUtils qw( slide );

sub mountain_array_slide( @ints ) {
    return false if @ints < 3;
    my $climbing = true;
    slide {
        $climbing
        ? $a <= $b && ( ( $a == $b && return false ) , $climbing = false )
        : $a >= $b && return false
    } @ints;
    return ! $climbing;
}
```

And actually it is only marginally slower than the other solution:

```text
                    Rate          slide mountain_array
slide          5365520/s             --            -4%
mountain_array 5560630/s             4%             --
```

So as nice as it was to do the optimization exercise for my first solution,
I actually prefer the `slide` version,
because it concentrates on the task, not the mechanics.

#### **Thank you for the challenge!**

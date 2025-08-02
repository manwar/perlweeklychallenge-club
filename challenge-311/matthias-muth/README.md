# Up and Down and Round and Round

**Challenge 311 solutions in Perl by Matthias Muth**

## Task 1: Upper Lower

> You are given a string consists of english letters only.<br/>
> Write a script to convert lower case to upper and upper case to lower in the given string.
>
> **Example 1**
>
> ```text
> Input: $str = "pERl"
> Output: "PerL"
> ```
>
> **Example 2**
>
> ```text
> Input: $str = "rakU"
> Output: "RAKu"
> ```
>
> **Example 3**
>
> ```text
> Input: $str = "PyThOn"
> Output: "pYtHoN"
> ```

Was this challenge task written to highlight Perl's regular expressions power?<br/>
I would think so, because using regular expressions, the solution is a one-liner:

```perl
use v5.36;

sub upper_lower( $str ) {
    return $str =~ s< ([a-z]) | [A-Z] >{ $1 ? uc( $& ) : lc( $& ) }xegr;
}
```

As every regex substitution operation, this one, too, consists of two parts. The first one is a pattern, but in this case the second one is an expression to be evaluated and its *result* used as the substitution.

The pattern looks for either a lower case letter `[a-z]` or an upper case letter [A-Z].<br/>
If it's a lower case letter, it is captured: `([a-z])`.

In the second part, the evaluated expression decides what the substitution for the match that was found will be.<br/>
If the capture `$1` is non-empty,
we have found a lower case letter. We transform it into uppercase.<br/>
If `$1` is empty, it was an uppercase letter that we found,
and we transform it into lowercase:
```perl
        $1 ? uc( $& ) : lc( $& )
```
I have made it a habit to use curly braces as delimiters when I use an evaluated expression as the replacement part. That means that the first part (the pattern), too, needs to be enclosed in a pair of bracketing quotes. I'm using `<`and `>`  as brackets there.


The substitution uses these modifiers:<br/>

* `/x` allows for using whitespace within the pattern, to make it more readable,
* `/e` says to *evaluate* the second part as an *expression*, using the result as the substitution,
* `/g` asks for a *global* substitution, doing the substitution as often as possible,
* `/r` *returns* the end result of the substitution as a string, instead of applying it to the original variable.

Good to have that power in the Perl toolbox!



## Task 2: Group Digit Sum

> You are given a string, `$str`, made up of digits, and an integer, `$int`, which is less than the length of the given string.<br/>
> Write a script to divide the given string into consecutive groups of size `$int` (plus one for leftovers if any). Then sum the digits of each group, and concatenate all group sums to create a new string. If the length of the new string is less than or equal to the given integer then return the new string, otherwise continue the process.
>
> **Example 1**
>
> ```text
> Input: $str = "111122333", $int = 3
> Output: "359"
>
> Step 1: "111", "122", "333" => "359"
> ```
>
> **Example 2**
>
> ```text
> Input: $str = "1222312", $int = 2
> Output: "76"
>
> Step 1: "12", "22", "31", "2" => "3442"
> Step 2: "34", "42" => "76"
> ```
>
> **Example 3**
>
> ```text
> Input: $str = "100012121001", $int = 4
> Output: "162"
>
> Step 1: "1000", "1212", "1001" => "162"
> ```

This challenge requires a loop. In each iteration, the string is split into pieces of `$int` length, then the pieces are summed up as described, and the string is replaced by the concatenation of those sums.

Regular expressions are the tool of choice, again.

We use a regex pattern that splits up the string into pieces., using a `/g` *global* match.<br/>
The pattern matches sequences of digits of length 1 to `$int`, repeatedly.<br/>The global match returns everything that was captured, as a list, which we can assign to an array:

```perl
        my @groups = $str =~ /(\d{1,$int})/g;
```
As the pattern matches 'greedily', only the last group may be shorter than `$int`.

When we have the groups , we need to `map` each group into the sum of its digits.<br/>
Each group is `split` up into single characters, which we then `sum` up:
```perl
        map sum( split "", $_ ), @groups
```
Now we have the list of sums of the groups.<br/>
We `join` them together and assign the result to `$str` for the next round:
```perl
        $str = join "", map sum( split "", $_ ), @groups;
```

We loop as long as the length of the remaining string is bigger than `$int`. Then we return that last group left.<br/>
So everything together:
```perl
use v5.36;
use List::Util qw( sum );
sub group_digit_sum( $str, $int ) {
    while ( length( $str ) > $int ) {
        my @groups = $str =~ /(\d{1,$int})/g;
        $str = join "", map sum( split "", $_ ), @groups;
    }
    return $str;
}
```



#### **Thank you for the challenge!**

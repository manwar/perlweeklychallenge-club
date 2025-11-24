# Get Those Strings and Times Covered

**Challenge 348 solutions in Perl by Matthias Muth**

## Task 1: String Alike

> You are given a string of even length.<br/>
> Write a script to find if the given string split into two halves of equal lengths and they both have same number of vowels.
>
> **Example 1**
>
> ```text
> Input: $str = "textbook"
> Output: false
>
> 1st half: "text" (1 vowel)
> 2nd half: "book" (2 vowels)
> ```
>
> **Example 2**
>
> ```text
> Input: $str = "book"
> Output: true
>
> 1st half: "bo" (1 vowel)
> 2nd half: "ok" (1 vowel)
> ```
>
> **Example 3**
>
> ```text
> Input: $str = "AbCdEfGh"
> Output: true
>
> 1st half: "AbCd" (1 vowel)
> 2nd half: "EfGh" (1 vowel)
> ```
>
> **Example 4**
>
> ```text
> Input: $str = "rhythmmyth"
> Output: false
>
> 1st half: "rhyth" (0 vowel)
> 2nd half: "mmyth" (0 vowel)
> ```
>
> **Example 5**
>
> ```text
> Input: $str = "UmpireeAudio"
> Output: false
>
> 1st half: "Umpire" (3 vowels)
> 2nd half: "eAudio" (5 vowels)
> ```

The fastest way to count the occurrences of a fixed set of characters in a string in Perl probably is this:

```perl
    tr/<characters to count>//
```

This is mentioned explicitly in [perldoc](https://perldoc.perl.org/perlop#tr/SEARCHLIST/REPLACEMENTLIST/cdsr):

> ```
> tr/*SEARCHLIST*/*REPLACEMENTLIST*/cdsr
> ```
>
> [...]<br/>
> An empty *REPLACEMENTLIST* is useful for counting characters in a class [...]

For this solution, I apply `tr` to the left and right parts, with upper case and lower case vowels as the *SEARCHLIST*. I use `map` to map the two parts to their respective number of vowels.

For the returned result, the two counts have to be equal. And at least one of them (it doesn't matter which one, as they are equal) has to be greater than zero.

This is my solution:

```perl
use v5.36;

sub string_alike( $str ) {
    my $half_length = length( $str ) / 2;
    my ( $n_1, $n_2 ) = map tr/aeiouAEIOU//,
        substr( $str, 0, $half_length ),
        substr( $str, $half_length );
    return $n_1 > 0 && $n_2 == $n_1;
}
```

## Task 2: Co[n]vert Time

> You are given two strings, \$source and \$target, containing time in 24-hour time form.<br/>
> Write a script to convert the source into target by performing one of the following operations:
> 
> ```text
> 1. Add  1 minute
> 2. Add  5 minutes
> 3. Add 15 minutes
> 4. Add 60 minutes
>```
> 
>Find the total operations needed to get to the target.
> 
> **Example 1**
> 
> ```text
>Input: $source = "02:30"
>        $target = "02:45"
> Output: 1
>Just one operation i.e. "Add 15 minutes".
> ```
>
> **Example 2**
> 
> ```text
> Input: $source = "11:55"
>       $target = "12:15"
> Output: 2
> Two operations i.e. "Add 15 minutes" followed by "Add 5 minutes".
>```
> 
>**Example 3**
> 
> ```text
> Input: $source = "09:00"
>        $target = "13:00"
>Output: 4
> Four operations of "Add 60 minutes".
> ```
>
> **Example 4**
>
> ```text
> Input: $source = "23:45"
>        $target = "00:30"
> Output: 3
>Three operations of "Add 15 minutes".
> ```
> 
>**Example 5**
> 
>```text
> Input: $source = "14:20"
>        $target = "15:25"
> Output: 2
> Two operations, one "Add 60 minutes" and one "Add 5 minutes"
>```

First we need to find the time difference between `$source` and `$target`, in minutes. For converting the time strings into a number of minutes, I use a regular expression of `/^(\d+):(\d+)/`, after which `$1` and `$2` contain the hour and the minute, respectively. The time in minutes then obviously is `( $1 * 60 ) + $2`. I use a `map` call to convert both `$source` and `$target` into `$source_min` and `$target_min`.

The time difference in minutes `$diff` then is  `$target_min - $source_min`. If getting to the target time means crossing midnight, the difference will be negative. The easy way to deal with that is to just use the modulo operator with one whole day's number of minutes, like so: `  % ( 24 * 60 )`. This will turn a negative difference into the correct positive value.

For determining the number `$n` of operations needed, I use a `for` loop.<br/>With `$_` containing the operation values of `60`, `15` and `5` (in this descending order), the number of possible operations is `int( $diff / $_ )`. This number is added to the total number of operations in `$n`.

Next, `$diff` needs to be diminished by the total value that these operations represent. Applying all operations with the value of `$_` at once means we reduce `$diff` to what is left, which we can do by just applying `$diff %= $_`.

I excluded the operation with the value of `1` from the loop, because obviously the number of operations with value `1` to cover what is left in `$diff` is the value of `$diff` itself, no divisions or modulo computations needed. The value of  the remaining `$diff` can just be added to `$n` for the final result.

Putting it together:

```perl
use v5.36;

sub convert_time( $source, $target ) {
    my ( $source_min, $target_min ) =
        map { /(\d+):(\d+)/; ( $1 * 60 + $2 )  } $source, $target;
    my $diff = ( $target_min - $source_min ) % ( 24 * 60 );
    my $n = 0;
    for ( 60, 15, 5 ) {
        $n += int( $diff / $_ );
        $diff %= $_;
    };
    return $n + $diff;
}
```

#### **Thank you for the challenge!**

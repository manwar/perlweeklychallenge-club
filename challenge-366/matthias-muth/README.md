# Counting Times Without Questions

**Challenge 366 solutions in Perl by Matthias Muth**

## Task 1: Count Prefixes

> You are given an array of words and a string (contains only lowercase English letters).<br/>
> Write a script to return the number of words in the given array that are a prefix of the given string.
>
> **Example 1**
>
> ```text
> Input: @array = ("a", "ap", "app", "apple", "banana"), $str = "apple"
> Output: 4
> ```
>
> **Example 2**
>
> ```text
> Input: @array = ("cat", "dog", "fish"), $str = "bird"
> Output: 0
> ```
>
> **Example 3**
>
> ```text
> Input: @array = ("hello", "he", "hell", "heaven", "he"), $str = "hello"
> Output: 4
> ```
>
> **Example 4**
>
> ```text
> Input: @array = ("", "code", "coding", "cod"), $str = "coding"
> Output: 3
> ```
>
> **Example 5**
>
> ```text
> Input: @array = ("p", "pr", "pro", "prog", "progr", "progra", "program"), $str = "program"
> Output: 7
> ```



#### A regular expression to match prefixes

I first thought about how to solve this task with regular expressions. A pattern that accepts  only prefixes of the word `"apple"` could look like this:

```perl
     /^  a? (?:p (?:p (?:l (?:e)? )? )? )? $/x
```

This pattern would need to be constructed from the input string. With the nested parentheses that all have to be closed at the end we could 'go recursive' , but that seems a bit of an overkill to me for this simple task. Or we could go through the letters of the input string *twice*, once for the opening parentheses and the letters, and once for the closing parentheses with the question marks. It then is easier not to make an exception for the first letter, and do the same for all letters:

```perl
    my $re = join " ",
        map( "(?:$_", split( "", $str ) ),
        map( ")?",    split( "", $str ) );
```

resulting in `"/^ (?:a (?:p (?:p (?:l (?:e )? )? )? )? )? $/"`.

Applying that regex to the words in the input array and counting the matches for the result is easy, then:

```perl
    return scalar grep /^ ${re} $/x, $array->@*;
```

The whole regex-based solution could look like this, then:

```perl
use v5.36;

sub count_prefixes( $array, $str ) {
    my $re = join " ",
        map( "(?:$_", split( "", $str ) ),run 
        map( ")?",    split( "", $str ) );
    return scalar grep /^ ${re} $/x, $array->@*;
}
```

#### The `substr` solution

It is evident that firing up the regular expression engine for checking each single word has a runtime cost.

Also, generating a regular expression and then applying it is a two step process,  with the intermediate result (the regular expression) not really visible in the program after the first step. For anyone reading the code this probably requires more of abstract thinking about what really is going on than necessary.

That is why I wrote a second, simpler solution, in terms of both programming complexity and runtime. It uses `substr` to check each word to be a prefix of the target word. It is so much simpler:

```perl
use v5.36;

sub count_prefixes( $array, $str ) {
    return scalar grep $_ eq substr( $str, 0, length( $_ ) ), $array->@*;
}
```

As much as I admire the power of regular expressions in Perl, I prefer this simpler solution.

## Task 2: Valid Times

> You are given a time in the form ‘HH:MM’. The earliest possible time is ‘00:00’ and the latest possible time is ‘23:59’. In the string time, the digits represented by the ‘?’ symbol are unknown, and must be replaced with a digit from 0 to 9.<br/>
> Write a script to return the count different ways we can make it a valid time.
>
> **Example 1**
>
> ```text
> Input: $time = "?2:34"
> Output: 3
>
> 0 -> "02:34" valid
> 1 -> "12:34" valid
> 2 -> "22:34" valid
> ```
>
> **Example 2**
>
> ```text
> Input: $time = "?4:?0"
> Output: 12
>
> Hours: tens digit ?, ones digit 4 -> can be 04, and 14 (2 possibilities)
> Minutes: tens digit ?, ones digit 0 -> tens can be 0-5 (6 possibilities)
>
> Total: 2 × 6 = 12
> ```
>
> **Example 3**
>
> ```text
> Input: $time = "??:??"
> Output: 1440
>
> Hours: from 00 to 23 -> 24 possibilities
> Minutes: from 00 to 59 -> 60 possibilities
>
> Total: 24 × 60 = 1440
> ```
>
> **Example 4**
>
> ```text
> Input: $time = "?3:45"
> Output: 3
>
> If tens digit is 0 or 1 -> any ones digit works, so 03 and 13 are valid
> If tens digit is 2 -> ones digit must be 0-3, but here ones digit is 3, so 23 is valid
>
> Therefore: 0,1,2 are all valid -> 3 possibilities
> ```
>
> **Example 5**
>
> ```text
> Input: $time = "2?:15"
> Output: 4
>
> Tens digit is 2, so hours can be 20-23
> Ones digit can be 0,1,2,3 (4 possibilities)
>
> Therefore: 4 valid times
> ```

I decided to separate the validation, extraction and calculation steps.

To **validate** the input string and ensure that invalid times such as `26:??` are rejected, I use a regular expression. It allows only hours from `00` to `23`, and minutes from `00` to `59`, but also allows question marks instead of digits:

```perl     
    $time =~ /^ ( [?01][?0-9] | 2[?0-3] ) : [?0-5] [?0-9] $/x
        or return 0;
```

Next, I **separate** the input string into tens of hours, hours, tens of minutes and minutes. I found `unpack` to be very useful for this: The `A` format extracts one character from the string, and we can use the `x` format to skip over the `:`, like this:

```perl  
    my ( $h10, $h1, $m10, $m1 ) = unpack "AAxAA", $time;
```

Normally I would have extracted these already in the regular expression, but the `|` alternation for the hours makes it more complicated than it's worth. That's why I declared the separation of validation and extraction a feature ;-).

**Calculating** the number of possible (and valid!) substitutions for question marks can be done by a multiplication of factors. Digits themselves don't have a degree of freedom, so the factor is `1`. Question marks can be substituted by one digit out of a range of digits, so the factor is greater than `1`.  

For the tens of minutes and minutes, determining the factor is easy, because their range of digits is fixed. They simply are these:

```perl
    ( $m10 eq "?" ? 6 : 1 )     # 0 to 5
    ( $m1  eq "?" ? 10 : 1 )    # 0 to 9
```

For the hours , it's a bit more complicated:

| `$h10`      | `$h1` | Factor | Comment |
| --------- | --- | ------ | --------- |
|   ?       | ? | 24 | All possible hours 00-23 |
|  ?  | 0-3 | 3 | One each of 00-03, 10-13 and 20-23 |
| ? | 4-9 | 2 | One of 04-09 and one of 14-19 (but not 24-29!) |
| 0, 1 | ? | 10 | All hours 00-09 or 10-19 |
| 2 | ? | 4 | All hours 20-23 |
| 0-2 | 0-9 | 1 | A single valid hour already |

With a bit of rearrangement, I found this expression for the number of possible hours:

```perl
        $h10 eq "?"
            ? ( $h1 eq "?"
                ? 24
                : $h1 <= 3 ? 3 : 2 )
            : $h1 eq "?"
                ? ( $h10 == 2 ? 4 : 10 )
                : 1
```

Combining it all, this is my solution:

```perl
use v5.36;

sub valid_times( $time ) {
    $time =~ /^ ( [?01][?0-9] | 2[?0-3] ) : [?0-5] [?0-9] $/x
        or return 0;
    my ( $h10, $h1, $m10, $m1 ) = unpack "AAxAA", $time;
    return
        ( $h10 eq "?"
            ? ( $h1 eq "?"
                ? 24
                : $h1 <= 3 ? 3 : 2 )
            : $h1 eq "?"
                ? ( $h10 == 2 ? 4 : 10 )
                : 1 )
        * ( $m10 eq "?" ? 6 : 1 )
        * ( $m1  eq "?" ? 10 : 1 );
}
```

#### **Thank you for the challenge!**

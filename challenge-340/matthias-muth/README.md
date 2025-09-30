# Two Times Two Lines

**Challenge 340 solutions in Perl by Matthias Muth**

## Task 1: Duplicate Removals

> You are given a string, $str, consisting of lowercase English letters.<br/>
> Write a script to return the final string after all duplicate removals have been made. Repeat duplicate removals on the given string until we no longer can.<br/>
> A duplicate removal consists of choosing two adjacent and equal letters and removing them.
>
> **Example 1**
>
> ```text
> Input: $str = 'abbaca'
> Output: 'ca'
>
> Step 1: Remove 'bb' => 'aaca'
> Step 2: Remove 'aa' => 'ca'
> ```
>
> **Example 2**
>
> ```text
> Input: $str = 'azxxzy'
> Output: 'ay'
>
> Step 1: Remove 'xx' => 'azzy'
> Step 2: Remove 'zz' => 'ay'
> ```
>
> **Example 3**
>
> ```text
> Input: $str = 'aaaaaaaa'
> Output: ''
>
> Step 1: Remove 'aa' => 'aaaaaa'
> Step 2: Remove 'aa' => 'aaaa'
> Step 3: Remove 'aa' => 'aa'
> Step 4: Remove 'aa' => ''
> ```
>
> **Example 4**
>
> ```text
> Input: $str = 'aabccba'
> Output: 'a'
>
> Step 1: Remove 'aa' => 'bccba'
> Step 2: Remove 'cc' => 'bba'
> Step 3: Remove 'bb' => 'a'
> ```
>
> **Example 5**
>
> ```text
> Input: $str = 'abcddcba'
> Output: ''
>
> Step 1: Remove 'dd' => 'abccba'
> Step 2: Remove 'cc' => 'abba'
> Step 3: Remove 'bb' => 'aa'
> Step 4: Remove 'aa' => ''
> ```

Of course I will use regular expressions for this one, particularly because the 'repeated something' detection feels almost like a common idiom meanwhile (at least for me). It uses  a capture group `(...)`, and a _backreference_ to that capture buffer. I typically use a _relative_ reference, such a `\g{-1}` for the last capture group preceding the reference, in order to not getting confused by the capture buffers numbers when there could be changes to the regex later.

The substitution needs to be done repetitively, but a simple `/g` _global_ option is not enough, because some sequences to be removed only appear once other sequences have been removed. In this case, putting a `while` loop around the substitution does the trick.

The loop body itself can be empty because the substitution both does the work and determines the end criteria. I choose a `do {} while ...` loop, because I think it is the best way to make it obvious that the loop body is empty. (If I used a `while ( ... ) { ... }` loop instead, I would probably put a comment into the loop body to guide the reader. But this would need three lines of code instead of only one.)

I still use the `/g` option to catch as many occurrences as possible in one substitution, to minimize the number of times the loop iterates.

After all the substitutions are done, I just return what is left of the `$str` string.   

```perl
use v5.36;

sub duplicate_removals( $str ) {
    do {} while $str =~ s/(.)\g-1//g;
    return $str;
}
```

Nice and concise.

## Task 2: Ascending Numbers

> You are given a string, $str, is a list of tokens separated by a single space. Every token is either a positive number consisting of digits 0-9 with no leading zeros, or a word consisting of lowercase English letters.<br/>
> Write a script to check if all the numbers in the given string are strictly increasing from left to right.
>
> **Example 1**
>
> ```text
> Input: $str = "The cat has 3 kittens 7 toys 10 beds"
> Output: true
> 
> Numbers 3, 7, 10 - strictly increasing.
> ```
>
> **Example 2**
>
> ```text
> Input: $str = 'Alice bought 5 apples 2 oranges 9 bananas'
> Output: false
> ```
>
> **Example 3**
>
> ```text
> Input: $str = 'I ran 1 mile 2 days 3 weeks 4 months'
> Output: true
> ```
>
> **Example 4**
>
> ```text
> Input: $str = 'Bob has 10 cars 10 bikes'
> Output: false
> ```
>
> **Example 5**
>
> ```text
> Input: $str = 'Zero is 0 one is 1 two is 2'
> Output: true
> ```

Another use case for regular expressions.<br/>
This time, for extracting all numbers from the input string:

```perl
    my @numbers = $str =~ /(\d+)/g;
```

Then, I translate the sentence 'all numbers have to be strictly greater that their respective predecessor' into this Perl statement, using `all` from `List::Util`:

```perl
    all { $numbers[$_] > $numbers[ $_ - 1 ] } 1..$#numbers
```

The result is the return value, so I end up with a typical Perl two-liner:

```perl
use v5.36;
use List::Util qw( all );

sub ascending_numbers( $str ) {
    my @numbers = $str =~ /(\d+)/g;
    return all { $numbers[$_] > $numbers[ $_ - 1 ] } 1..$#numbers;
}

```

#### **Thank you for the challenge!**

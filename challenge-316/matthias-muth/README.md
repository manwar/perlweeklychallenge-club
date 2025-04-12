# Ring-a-ring-a-roses or a sack race?

**Challenge 316 solutions in Perl by Matthias Muth**

## Task 1: Circular

> You are given a list of words.<br/>
> Write a script to find out whether the last character of each word is the first character of the following word.
>
> **Example 1**
>
> ```text
> Input: @list = ("perl", "loves", "scala")
> Output: true
>```
> 
>**Example 2**
> 
>```text
> Input: @list = ("love", "the", "programming")
> Output: false
> ```
>
> **Example 3**
>
> ```text
>Input: @list = ("java", "awk", "kotlin", "node.js")
> Output: true
> ```

I chose a more or less classical solution, using `all` from `List::Util` for brevity
instead of writing a loop.<br/>
Within `all`'s comparison code block,
I compare the first character of the current string to the last one of the previous string,
with indices running from `1` to the end of the list of words.

So, nothing special here: 

```perl
use v5.36;

use List::Util qw( all );

sub circular( @list ) {
    return all { substr( $list[ $_ - 1 ], -1 ) eq substr( $list[$_], 0, 1 ) }
        1..$#list;
}
```

## Task 2: Subsequence

> You are given two string.<br/>
> Write a script to find out if one string is a subsequence of another.<br/>
> A subsequence of a string is a new string that is formed from the original string<br/>
> by deleting some (can be none)  of the characters without disturbing the relative<br/>
> positions of the remaining characters.
>
> **Example 1**
>
> ```text
> Input: $str1 = "uvw", $str2 = "bcudvew"
> Output: true
>```
> 
>**Example 2**
> 
>```text
> Input: $str1 = "aec", $str2 = "abcde"
> Output: false
> ```
>
> **Example 3**
>
> ```text
>Input: $str1 = "sip", $str2 = "javascript"
> Output: true
> ```

I think I have been a Perl programmer for too long.<br/>
There's no way I can avoid thinking
'How can I best use Regular Expressions for this?'
whenever I read a task description,
especially when it deals with strings, of course...

So what would be a regular expression that matches
if `$str1` is a 'subsequence' of `$str2`,
and doesn't match otherwise?

We know that there were characters deleted from `$str2`,
resulting in `$str1`.
We can therefore construct a regular expression
that accepts the characters from `$str1`,
and in between accepts any characters that are now deleted.

For Example 3, we could use something like this:

```perl
    "javascript" =~ qr/s.*i.*p/;
```

This will work nicely. But if we have longer strings, for example:

```perl
    "javascriptjavascriptjavascriptjavascriptjavascript" =~ qr/s.*i.*p/;
```
this will not only match the first `'scrip'`,
but it will 'greedily' try to grab as many characters as possible
for the `.*` patterns, and only stop after finding
`'scriptjavascriptjavascriptjavascriptjavascrip'`.
There will be a lot of trying and re-trying
to find the longest string possible.<br/>
(I recommend the fantastic regular expression debugger
on https://regex101.com/ if you want to see this yourself!)

Let's avoid that. Let's make it 'non-greedy':

```perl
      "javascriptjavascriptjavascriptjavascriptjavascript" =~ qr/s.*?i.*?p/;
```

Much better!<br/>
Not that it would be too important for our examples, but it 'scales' better.

To construct the regular expression from `$str1`,
we `split` that one up into single characters,
and `join` them back together with `.*?` in between them.

The whole solution then looks like this:

```perl
use v5.36;

sub subsequence( $str1, $str2 ) {
    my $re = join ".*?", split "", $str1;
    return $str2 =~ /$re/;
}
```
I guess I will always be a Perl programmer... 

#### **Thank you for the challenge!**

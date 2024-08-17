# Broken Keys and Test Driven Understanding (tm)

**Challenge 275 solutions in Perl by Matthias Muth**

## Task 1: Broken Keys

> You are given a sentence, $sentence and list of broken keys @keys.<br/>
> Write a script to find out how many words can be typed fully.<br/>
> <br/>
> Example 1<br/>
> Input: \$sentence = "Perl Weekly Challenge", @keys = ('l', 'a')<br/>
> Output: 0<br/>
> <br/>
> Example 2<br/>
> Input: \$sentence = "Perl and Raku", @keys = ('a')<br/>
> Output: 1<br/>
> Only Perl since the other word two words contain 'a' and can't be typed fully.<br/>
> <br/>
> Example 3<br/>
> Input: \$sentence = "Well done Team PWC", @keys = ('l', 'o')<br/>
> Output: 2<br/>
> <br/>
> Example 4<br/>
> Input: \$sentence = "The joys of polyglottism", @keys = ('T')<br/>
> Output: 2<br/>

Regular expressions make this is an easy one.

First thing, we have to separate the words in the sentence to deal with them one by one.<br/>
No problem, just a standard call of `split " ", $sentence`.

To find out whether a word contains a 'broken' key
we can put those keys into a 'bracketed character class',
and then check the word against that.
For the second example above, we would try a match like this:

```perl[]  
    ! /[lo]/i
```

The `//i` modifier makes sure that lower or upper case doesn't matter
(needed in the third example).  

So then let's combine the broken keys into a string that we can use in the regular expressions,
and then use it for counting the matches.
For the counting, `grep` in scalar context does the job.

```perl
sub broken_keys( $sentence, $keys ) {
    my $keys_as_string = join( "", $keys->@* );
    return scalar grep ! /[$keys_as_string]/i, split " ", $sentence;
}
```

Et voilà!

## Task 2: Replace Digits

> You are given an alphanumeric string, \$str, where each character is either a letter or a digit.<br/>
> Write a script to replace each digit in the given string with the value of the previous letter plus (digit) places.<br/>
> <br/>
> Example 1<br/>
> Input: \$str = 'a1c1e1'<br/>
> Ouput: 'abcdef'<br/>
> shift('a', 1) => 'b'<br/>
> shift('c', 1) => 'd'<br/>
> shift('e', 1) => 'f'<br/>
> <br/>
> Example 2<br/>
> Input: \$str = 'a1b2c3d4'<br/>
> Output: 'abbdcfdh'<br/>
> shift('a', 1) => 'b'<br/>
> shift('b', 2) => 'd'<br/>
> shift('c', 3) => 'f'<br/>
> shift('d', 4) => 'h'<br/>
> <br/>
> Example 3<br/>
> Input: \$str = 'b2b'<br/>
> Output: 'bdb'<br/>
> <br/>
> Example 4<br/>
> Input: \$str = 'a16z'<br/>
> Output: 'abgz'<br/>

This task is a bit more tricky. At least for me.<br/>
Not tricky for the programming,
but it took me an 'iterative approach' to understand the details of the specification.
As simple (and complete and correct!) as it seems, I misunderstood it as being *too* simple.

So this is my 'test driven understanding' approach.  

##### First try

Maybe my first try was too naive.
Repetitively match a letter and a digit,
and then replace the digit by the properly shifted letter directly in the substitution.<br/>
That means a `s///g` global substitution, and I added these additional 'tricks':

* using the `[:alpha:]` POSIX character class to capture an upper or lower case letter,
* using an `e` modifier to call a code block to determine the replacement string with the shifted letter,
* using an `r` modifier to return the modified result instead of changing the input string,
* using an `x` modifier for adding some spaces to improve readability: 

```perl
sub replace_digits_1( $str ) {
    return $str =~ s{ ([[:alpha:]]) (\d) }{ $1 . chr( ord( $1 ) + $2 ) }egr;
}
```

Great, that works well! ...
Except for the fourth example!<br/>
There we have two digits in a row (`'a16'`),
and we didn't get the second digit.
We need kind of an 'overlapping' operation.

##### Second try.

So next, the second approach,
where I use an explicit loop, always restarting at the beginning of the string,
and modifying the string itself:

```perl
sub replace_digits_2( $str ) {
    while ( $str =~
        s{ ([[:alpha:]]) (\d) }{ $1 . chr( ord( $1 ) + $2 ) }xe )
    {
        # Everything is in the loop condiiton.
    }
    return $str;
}
```

Great, that's better!
We catch the fourth example's second digit now, after replacing the first one.

But the resulting letter for the second digit is off by one!

My misunderstanding, again. Actually, we should not replace
```perl
    'a16' => ('a' shifted by 1 ) => 'ab6'
    'b6'  => ('b' shifted by 6 ) => 'bh'
```
but, in one operation:
```perl
    'a16' => ('a' shifted by 1 ) => 'ab6'
             ('a' shifted by 6 ) => 'abg'
```

##### So, third try:

Same loop, but replacing sequences of digits from *right to left* instead of left to right.
I capture the digits in between, and leave them for the next iterations,
replacing the rightmost digit first:

```perl
sub replace_digits_3( $str ) {
    while ( $str =~
        s{ ([[:alpha:]]) (\d*) (\d) }{ "$1$2" . chr( ord( $1 ) + $3 ) }xe )
    {
        # Everything is in the loop condiiton.
    }
    return $str;
}
```

Finally it works!

Interesting that the bigger difficulty for me this time was not the programming itself,
but to capture the task specification correctly.

How good it is to have and use tests!

##### 'Refacturing the understanding'

I now understood that the task actually is not about replacing 'a letter and a digit',
but more replacing 'a letter and a sequence of digits'.

This lead me to yet another approach:<br/>
Once the letter and *all following digits* are captured
(using a `(\d+)` pattern), we build the replacement from

- the letter itself,
- the same letter, shifted by every digit's value.

*Now* that sounds logical, of course! :-)

I can turn back to the `s///g` style global substitution and avoid the `while` loop.
Using `split` to split up the sequence of digits, and `map` to loop over the single digits.

```perl
sub replace_digits_4( $str ) {
    return $str =~ s{ ([[:alpha:]]) (\d+) }{
            join "", $1, map chr( ord( $1 ) + $_ ), split "", $2;
        }xegr;
}
```

Probably this is my solution that best reflects the task's specification.

What a funny experience this challenge was!

#### **Thank you for the challenge!**

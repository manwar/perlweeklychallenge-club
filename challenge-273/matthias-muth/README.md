# Percentages and the 'BnoA' Regex

**Challenge 273 solutions in Perl by Matthias Muth**

## Task 1: Percentage of Character

> You are given a string, \$str and a character \$char.<br/>
> Write a script to return the percentage, nearest whole, of given character in the given string.<br/>
> <br/>
> Example 1<br/>
> Input: \$str = "perl",  \$char = "e"<br/>
> Output: 25<br/>
> <br/>
> Example 2<br/>
> Input: \$str = "java",  \$char = "a"<br/>
> Output: 50<br/>
> <br/>
> Example 3<br/>
> Input: \$str = "python", \$char = "m"<br/>
> Output: 0<br/>
> <br/>
> Example 4<br/>
> Input: \$str = "ada", \$char = "a"<br/>
> Output: 67<br/>
> <br/>
> Example 5<br/>
> Input: \$str = "ballerina", \$char = "l"<br/>
> Output: 22<br/>
> <br/>
> Example 6<br/>
> Input: \$str = "analitik", \$char = "k"<br/>
> Output: 13<br/>

We need the number of times that the `$char` character appears in the `$str` string.
So let's count character frequencies. Just like we always do:

```perl
my %freq;
++$freq{$_}
    for split "", $str;
```

The percentage that we need is the number of `$char` characters
divided by the total number of characters in `$str`.
We need to be careful about the character not being present at all,
in which case `$freq{ $char }` is `undef`.
I guess every Perl programmer likes Perl's 'Logical Defined-Or' operator!  :-) 

 ```perl
 ( $freq{ $char } // 0 ) / length( $str )
 ```

For rounding towards the nearest integer, there are at least these three ways to go:

- `use POSIX qw( round );`

  Loading the `POSIX` module seems like a big overhead
  for just rounding a floating point number.<br/>
  So let's look for something else.

- `printf( "%.0f", <number> )`

  This is the solution that is suggested by the [Perl FAQ](https://perldoc.perl.org/perlfaq4#Does-Perl-have-a-round()-function%3F-What-about-ceil()-and-floor()%3F-Trig-functions%3F).<br/>
  Looks much better, but there's still a lot of work behind the scenes
  for a simple operation on a number.<br/>
  I would not use it if performance is an issue.

- `int( <number> + 0.5 )`

  Very simple, very basic. This is the rounding I got taught in school.<br/>
  It's my favorite solution *but only if* it is not for any financial or banking application.
  Check in the [Perl FAQ](https://perldoc.perl.org/perlfaq4#Does-Perl-have-a-round()-function%3F-What-about-ceil()-and-floor()%3F-Trig-functions%3F) again to see why.

Putting it all together:

```perl
use v5.36;

sub percentage_of_character( $str, $char ) {
    my %freq;
    ++$freq{$_}
        for split "", $str;
    return int( 100 * ( $freq{$char} // 0 ) / length( $str ) + 0.5 );
}
```

## Task 2: B After A

> You are given a string, \$str.<br/>
> Write a script to return true if there is at least one b, and no a appears after the first b.<br/>
> <br/>
> Example 1<br/>
> Input: \$str = "aabb"<br/>
> Output: true<br/>
> <br/>
> Example 2<br/>
> Input: \$str = "abab"<br/>
> Output: false<br/>
> <br/>
> Example 3<br/>
> Input: \$str = "aaa"<br/>
> Output: false<br/>
> <br/>
> Example 4<br/>
> Input: \$str = "bbb"<br/>
> Output: true<br/>

What a great task for demonstrating how simple things can be with regular expressions!

We need at least one `b`:

```perl
/b/
```

But we need to make sure it's the *first* `b`.
So there must be no other `b` before the one we are looking for.<br/>
Let's use the `x` flag to keep it more readable:

```perl
/^ [^b]* b /x
```

Next, we need to check that there is no `a` after that `b` until we reach the end of the string.

```perl
/^ [^b]* b [^a]* $/x
```

And putting it all together:

```perl
use v5.36;

sub b_after_a( $str ) {
    return $str =~ /^ [^b]* b [^a]* $/x;
}
```

That's all we need!

#### **Thank you for the challenge!**

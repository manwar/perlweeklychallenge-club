# Power Meets Points

**Challenge 349 solutions in Perl by Matthias Muth**

## Task 1: Power String

> You are given a string.<br/>
> Write a script to return the power of the given string.<br/>
> The power of the string is the maximum length of a non-empty substring that contains only one unique character.
>
> **Example 1**
>
> ```text
> Input: $str = "textbook"
> Output: 2
>Breakdown: "t", "e", "x", "b", "oo", "k"
> The longest substring with one unique character is "oo".
> ```
> 
>**Example 2**
> 
>```text
> Input: $str = "aaaaa"
> Output: 5
> ```
> 
>**Example 3**
> 
>```text
> Input: $str = "hoorayyy"
> Output: 3
> Breakdown: "h", "oo", "r", "a", "yyy"
>The longest substring with one unique character is "yyy".
> ```
> 
> **Example 4**
>
> ```text
>Input: $str = "x"
> Output: 1
> ```
> 
> **Example 5**
>
> ```text
>Input: $str = "aabcccddeeffffghijjk"
> Output: 4
> Breakdown: "aa", "b", "ccc", "dd", "ee", "ffff", "g", "h", "i", "jj", "k"
> The longest substring with one unique character is "ffff".
>```

With a little help from a regular expression and from `List::Util`, my solution is one line of code.

The regular expression captures a character, and then matches as many of the same character as possible, using a *backreference* to the captured one.

I use `\g-1` as the backreference. This is a relative backreference, which I prefer because if the whole regular expression changes or is embedded into another one, it is easy to forget to update references that have absolute numbers.

As the character may be repeated an unknown number of times (as often as possible), a `*` quantifier is added.   

```perl   
    /(.)\g-1*/
```

Adding the `/g` (*global*) option will return all matches as a list. But if there are captures (parenthesized expressions) within the regular expression, a list of all *captures* is returned instead. In the above regular expression, we do have a capture, but it contains only one single character, not the whole sequence at is needed. This can be solved by putting the whole sequence into another capture. Then it looks like that:

 ```perl
     /((.)\g-1*)/g
 ```

Note that now, for each match, *two* elements are returned: The whole sequence *and* the first character. That's because we have two parenthesized captures, and all of them are returned.

I can live with that, because in the next step, the matches are mapped to their lengths to find the largest one, and the single characters (with length 1) will in most of the cases be shorter than the longest sequence. If they are not, they represent the maximum length themselves, which is OK, too.

Returning the maximum of the mapped lengths concludes the solution:

```perl
use v5.36;
use List::Util qw( max );

sub power_string( $str ) {
    return max( map length, $str =~ /((.)\g-1*)/g );
}
```

## Task 2: Meeting Point

> You are given instruction string made up of U (up), D (down), L (left) and R (right).<br/>
> Write a script to return true if following the instruction, you meet the starting point (0,0).
>
> **Example 1**
>
> ```text
> Input: $path = "ULD"
> Output: false
>
> (-1,1) <- (0,1)
>    |        ^
>    v        |
> (-1,0)    (0,0)
> ```
>
> **Example 2**
>
> ```text
> Input: $path = "ULDR"
> Output: true
>
>  (-1,1) <- (0,1)
>     |        ^
>     v        |
>  (-1,0) -> (0,0)
> ```
>
> **Example 3**
>
> ```text
> Input: $path = "UUURRRDDD"
> Output: false
>
> (0,3) -> (1,3) -> (2,3) -> (3,3)
>   ^                          |
>   |                          v
> (0,2)                      (3,2)
>   ^                          |
>   |                          v
> (0,1)                      (3,1)
>   ^                          |
>   |                          v
> (0,0)                      (3,0)
> ```
>
> **Example 4**
>
> ```text
> Input: $path = "UURRRDDLLL"
> Output: true
>
> (0,2) -> (1,2) -> (2,2) -> (3,2)
>   ^                          |
>   |                          v
> (0,1)                      (3,1)
>   ^                          |
>   |                          v
> (0,0) <- (1,0) <- (1,1) <- (3,0)
> ```
>
> **Example 5**
>
> ```text
> Input: $path = "RRUULLDDRRUU"
> Output: true
>
> (0,2) <- (1,2) <- (2,2)
>   |                 ^
>   v                 |
> (0,1)             (2,1)
>   |                 ^
>   v                 |
> (0,0) -> (1,0) -> (2,1)
> ```

The interesting point in implementing a solution for this task is to find a way how to translate the direction letters (U, D, L and R) into a change of the current location's coordinates.

The outline is always the same:

```perl
use v5.36;
use builtin qw( true false );

sub meeting_point( $path ) {
    my ( $x, $y ) = ( 0, 0 );
    for ( split "", $path ) {
        <CHANGE $x AND $y ACCORDING TO THE DIRECTION IN $_>
        return true
            if $x == 0 && $y == 0;
    }
    return false;
}
```

The classical approach is an if-then-else chain. For brevity, I use the ternary conditional operator (`?:`):

```perl
        $_ eq "U" ? ++$y :
        $_ eq "D" ? --$y :
        $_ eq "L" ? --$x :
        $_ eq "R" ? ++$x : ();
```

In the case of an `"R"`, it is only detected after the other three directions have been excluded. There is always a doubt whether the runtime can be improved by reordering the conditional checks.

An alternative implementation uses a hash to look up some information depending on the direction letter. The hash can contain the x and y increments (or decrements) for the respective direction. Like this:

```perl
    my %incr_x = ( U => 0,  D => 0,  L => -1, R => +1 );
    my %incr_y = ( U => +1, D => -1, L => 0,  R => 0  );
    ...
        $x += $incr_x{$_};
        $y += $incr_y{$_};
```

or, very similar:

```perl
    my %incr = (
        U => [ 0, +1 ],
        D => [ 0, -1 ],
        L => [ -1, 0 ],
        R => [ +1, 0 ] );
    ...
        $x += $incr{$_}->[0];
        $y += $incr{$_}->[1];
```

Another approach is to look up a subroutine that changes the location:

```perl
    my %move_subs = (
        U => sub { ++$y },
        D => sub { --$y },
        L => sub { --$x },
        R => sub { ++$x },
    );
    ...
        $move_subs{$_}->();
```

This is appealing because every subroutine only does what is needed, while the incrementing solutions always also operate on the x or y coordinate that does *not* need to be changed for the respective direction.

Best is to let a benchmark decide! 

I ran benchmarks with 1,000, 10,000 and 100,000 random direction letters (setting the random seed manually to make sure that the path never passes through (0,0)). I also instrumented the code to accept an arrayref as the parameter instead of a string, to avoid that the call to `split` dominates the run time.

All of the solutions show results within a margin of a few percentage points, even though the 'if-then-else' solution seems to win slightly more often, followed by the 'increment' solution with separate hashes `%incr_x` and `%incr_y`.  

With these results, the 'increment' solution is my preferred one, because it is more balanced and symmetrical. Here it is in full:

```perl
use v5.36;
use builtin qw( true false );

sub meeting_point_using_subs( $path ) {
    my ( $x, $y ) = ( 0, 0 );
    my %incr_x = ( U => 0,  D => 0,  L => -1, R => +1 );
    my %incr_y = ( U => +1, D => -1, L => 0,  R => 0  );
    for ( ref $path ? $path->@* : split "", $path ) {
        $x += $incr_x{$_};
        $y += $incr_y{$_};
        return true
            if $x == 0 && $y == 0;
    }
    return false;
}
```

#### **Thank you for the challenge!**

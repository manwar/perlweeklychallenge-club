# There Is More Than One Way To Regex

**Challenge 280 solutions in Perl by Matthias Muth**

## Task 1: Twice Appearance

> You are given a string, \$str, containing lowercase English letters only.<br/>
> Write a script to print the first letter that appears twice.<br/>
> <br/>
> Example 1<br/>
> Input: \$str = "acbddbca"<br/>
> Output: "d"<br/>
> <br/>
> Example 2<br/>
> Input: \$str = "abccd"<br/>
> Output: "c"<br/>
> <br/>
> Example 3<br/>
> Input: \$str = "abcdabbb"<br/>
> Output: "a"<br/>

This is my no-frills-easy-reading solution:

```perl
sub twice_appearance( $str ) {
    my %seen;
    for ( split "", $str ) {
        return $_
            if $seen{$_};
        $seen{$_} = 1;
    }
    return ();
}
```



I tried to develop a regex-based solution, but I failed!<br/>
I started with this:

```perl	
sub twice_appearance_WRONG( $str ) {
    return $str =~ /(.).*?\g1/ ? $1 : ();
}
```

But this doesn't work, because it finds 'the first letter that is repeated later on', not 'the first letter that is a duplicate of a letter that occurred before'. In Example 1 ("acbddbca") it finds 'a', because it tries 'a' first, but it should find 'd', because that is the first 'duplicating' letter (the first 'second letter', if you will).

Then I tried a solution that captures any 'second' letter, and then checks with a lookbehind that that letter appears before:

```perlin the string 
sub twice_appearance_LOOK_BEHIND_NO_GO( $str ) {
    return $str =~ /(.)(?<!^.*\g1.*)/ ? $1 : ();
}
```

I know that if this worked, it would be incredibly slow.<br/>
But anyway, it aborts with an error
'Lookbehind longer than 255 not implemented ...'.

I gave up.<br/>
If anyone has a regex-based solution for this challenge task,
please post it in
[The Weekly Challenge - Perl & Raku group on Facebook](https://www.facebook.com/groups/theweeklychallengegroup/) or send me an [email](mailto:matthias.muth@gmx.de)!



## Task 2: Count Asterisks

> You are given a string, \$str, where every two consecutive vertical bars are grouped into a pair.<br/>
> Write a script to return the number of asterisks, \*, excluding any between each pair of vertical bars.<br/>
> <br/>
> Example 1<br/>
> Input: \$str = "p|\*e\*rl|w\*\*e|\*ekly|"<br/>
> Ouput: 2<br/>
> The characters we are looking here are "p" and "w\*\*e".<br/>
> <br/>
> Example 2<br/>
> Input: \$str = "perl"<br/>
> Ouput: 0<br/>
> <br/>
> Example 3<br/>
> Input: \$str = "th|ewe|e\*\*|k|l\*\*\*ych|alleng|e"<br/>
> Ouput: 5<br/>
> The characters we are looking here are "th", "e\*\*", "l\*\*\*ych" and "e".<br/>

##### Single regex version

I started with a single regex solution, which is, sorry for that, not very easy-to-read:

```perl
sub count_asterisks_single_regex( $str ) {
    return scalar( () = $str =~ /\G(?:\|[^|]*\||[^*])*+\*/g );
}
```

What???

Ok, here is what it does, and what it uses.<br/>Let's first add the `x` modifier to better see the pieces:

```perl
    return scalar( () = $str =~ / \G (?: \| [^|]* \| | [^*] )*+ \* /xg );
```

Aha. So we loop over the string with the `g` modifier to find all occurrences of `\*` (at the end of the regex). And we use `\G` to always continue where we left off.

We skip over everything that we don't want:

- pairs of vertical bars and anything that is not a vertical bar in between:<br/>`\| [^|]* \|`

- anything that is not an asterisk:<br/>`[^*]`

We want to skip as many of both of these as we can,
so we group them together as alternatives, and add a `*` quantifier.

Actually we use a `*+` ('possessive') quantifier
that keeps the regex engine from backtracking
once it finds a pair of vertical bars.
This inhibits retrying a vertical bar using the `[^*]` part
to find a `*` earlier (which then would also match *within* vertical bar pairs).

What else?

The regex delivers all matches, but we only want a count of the matches.<br/>We get the count using a not so well-known property of the list assignment operator: It returns the number of elements of the *right hand side* of the assignment in scalar context. And it does so no matter what the left hand side is. So this:

```perl
scalar( () = ( <list> ) )
```

has become a programming idiom in Perl to return the number of elements in a list *without assigning the list to an array variable first*.<br/>Good for a one-liner!<br/>
(See also [this useful stackoverflow article](https://stackoverflow.com/questions/2225460/how-do-i-find-the-number-of-values-in-a-perl-list).)

##### Two regex version: more easy-to-read

My second solution uses two regexes:

- one to remove all vertical bar pairs,
- and another one to find all asterisks.

I guess it's much easier to read, especially with some parentheses added to help with understanding the operator grouping:

```perl
sub count_asterisks_two_regexes( $str ) {
    return scalar( () = ( $str =~ s/ \| [^|]* \| //xgr ) =~ / \* /xg );
}
```

##### One regex and `tr`: my favorite (and shortest!) solution

What I described so far helped me to arrive at my favorite solution.<br/>
It is actually the shortest one, and I think it's the most readable.

It uses

- one regex to remove vertical bar pairs (as above),
- the `tr` operator to count the asterisks, by replacing them by - wait a minute - *asterisks*.

The `tr` operator returns the number of characters that it replaced, so what more could we want?

Here we go: 

```perl
sub count_asterisks( $str ) {
    return ( $str =~ s/ \| [^|]* \| //xgr ) =~ tr/*/*/;
}
```

This was an exercise in evolutionary programming... :-)



#### **Thank you for the challenge!**


# There Is Always a Regular Expression To Solve It

**Challenge 313 solutions in Perl by Matthias Muth**

This week, both my solutions use regular expressions to solve the task, resulting in concise solutions.

## Task 1: Broken Keys

> You have a broken keyboard which sometimes type a character more than once.<br/>
> You are given a string and actual typed string.<br/>
> Write a script to find out if the actual typed string is meant for the given string.
>
> **Example 1**
>
> ```text
> Input: $name = "perl", $typed = "perrrl"
> Output: true
>
> Here "r" is pressed 3 times instead of 1 time.
> ```
>
> **Example 2**
>
> ```text
> Input: $name = "raku", $typed = "rrakuuuu"
> Output: true
> ```
>
> **Example 3**
>
> ```text
> Input: $name = "python", $typed = "perl"
> Output: false
> ```
>
> **Example 4**
>
> ```text
> Input: $name = "coffeescript", $typed = "cofffeescccript"
> Output: true
> ```

For any typed string to correspond to the given string, every letter has to appear at least once, but possibly several times. We can express that with a regular expression.

As an example, if the word is `'perl'`,
then any word typed with the broken keys will be matched by this regular expression:

```perl
/^p+e+r+l+$/
```

So let's generate the regular expression from our given word:<br/>
We split the word into its characters, add a `+` sign to each of them, and then assemble everything to form the regular expression.

```perl
    my $pattern = join "", map "$_+", split "", $name;
```

We then can return the result of the pattern match:

```perl
    return $typed =~ /^$pattern$/;
```

And that's all:

```perl
use v5.36;

sub broken_keys( $name, $typed ) {
    my $pattern = join "", map "$_+", split "", $name;
    return $typed =~ /^$pattern$/;
}
```



## Task 2: Reverse Letters

> You are given a string.<br/>
> Write a script to reverse only the alphabetic characters in the string.
>
> **Example 1**
>
> ```text
> Input: $str = "p-er?l"
> Output: "l-re?p"
> ```
>
> **Example 2**
>
> ```text
> Input: $str = "wee-k!L-y"
> Output: "yLk-e!e-w"
> ```
>
> **Example 3**
>
> ```text
> Input: $str = "_c-!h_all-en!g_e"
> Output: "_e-!g_nel-la!h_c"
> ```

For this task, my strategy is to

- extract all letters,
- reverse them,
- replace each letter in the original string by the letter with the same index in the reversed string.

For extracting the letters, a regular expression with a `/g` *global* flag can be used. The reversed letters then are stored in an array:

```Perl
    my @reversed_letters = reverse $str =~ /[[:alpha:]]/g;
```

For the result, all letters in the original string are replaced by their reversed counterpart. Here, a regex substitution is used, with the `/g` *global* flag, and the `/r` flag, which *returns* the modified string. A variable `$index` is used to select the matching letter from the reversed letters, being incremented after each substitution.

```perl
    my $index = 0;
    return $str =~ s/[[:alpha:]]/$reversed_letters[$index++]/gr;
```

This is the whole solution then:

```perl
use v5.36;

sub reverse_letters( $str ) {
    my @reversed_letters = reverse $str =~ /[[:alpha:]]/g;
    my $index = 0;
    return $str =~ s/[[:alpha:]]/$reversed_letters[$index++]/gr;
}
```



#### **Thank you for the challenge!**

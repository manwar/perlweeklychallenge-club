# Short Acronyms, and a Short Solution

**Challenge 240 solutions in Perl by Matthias Muth**

## Task 1: Acronym

> You are given two arrays of strings and a check string.<br/>
> Write a script to find out if the check string is the acronym of the words in the given array.<br/>
> Example 1<br/>
> Input: @str = ("Perl", "Python", "Pascal")<br/>
>        \$chk = "ppp"<br/>
> Output: true<br/>
> <br/>
> Example 2<br/>
> Input: @str = ("Perl", "Raku")<br/>
>        \$chk = "rp"<br/>
> Output: false<br/>
> <br/>
> Example 3<br/>
> Input: @str = ("Oracle", "Awk", "C")<br/>
>        \$chk = "oac"<br/>
> Output: true<br/>

The first parameter to a perl `sub` can only be an `@array` variable *if it is the only parameter*. As we have two parameters in this task, the `@str` parameter from the description has to be passed in as an array reference, for which I chose `$str_aref` as a name. ( And no, I am not a fan of the so-called Hungarian Notation that codes the variable type into a variable's names. If I was, I probably wouldn't be a fan of Perl. Or vice versa. Or whatever.) 

The task itself is quite straightforward to implement in Perl.

We walk through the `@str` array (using the said `$str_aref` variable), and extract each first character into a list.
In the same flow, we concatenate that list of letters into a word (the acronym), and lower-case it. Then we can compare it to the other parameter, `$chk`, and return the comparison result. 

For extracting the first letter of each word, in a real application I would probably use
```perl
    substr( $_, 0, 1 )
```
, to avoid the overhead for building and starting a regular expression, but for here, I prefer this more concise and well understood simple rexexp:
```perl
   /^(.)/
```

So there we have our short solution to shorten words to acronyms:

```perl
sub acronym( $str_aref, $chk ) {
    return $chk eq lc join "", map /^(.)/, $str_aref->@*;
}
```

## Task 2: Build Array

> You are given an array of integers.<br/>
> Write a script to create an array such that $$new[i] = old[old[i]]$$ where $$0 <= i < new.length$$.<br/>
> Example 1<br/>
> Input: @int = (0, 2, 1, 5, 3, 4)<br/>
> Output: (0, 1, 2, 4, 5, 3)<br/>
> <br/>
> Example 2<br/>
> Input: @int = (5, 0, 1, 2, 3, 4)<br/>
> Output: (4, 5, 0, 1, 2, 3)<br/>

Using the name of the parameter `@int` instead of the specification's $$old$$, we can translate the specification $$new[i] = old[old[i]]$$ directly to
```perl
my @new = map $int[ $int[$_] ]
    for 0..$#old;
```
As we use all elements of the `int` array, one by one, in the inner bracket, we might as well insert the whole array in one step instead, using Perl's *array slice* syntax. We then even don't need the `map`  call any more, because an array slice already gives us a list:<br/>
```perl
my @new = @int[ @int ];
```
And actually we don't even need the `@new` variable, because we immediately return the list of values as the result.

Which makes this probably the shortest solution to a *PWC* task that I have ever written:

```perl
sub build_array( @int ) {
    return @int[ @int ];
}
```

#### **Thank you for the challenge!**

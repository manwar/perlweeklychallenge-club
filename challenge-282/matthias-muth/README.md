# Power to the Regex!

**Challenge 282 solutions in Perl by Matthias Muth**

For both of this week's tasks, my solutions are **one line of code, using regular expressions only**!

## Task 1: Good Integer

> You are given a positive integer, \$int, having 3 or more digits.<br/>
> Write a script to return the Good Integer in the given integer or -1 if none found.<br/>
> A good integer is exactly three consecutive matching digits.<br/>
> <br/>
> Example 1<br/>
> Input: \$int = 12344456<br/>
> Output: "444"<br/>
> <br/>
> Example 2<br/>
> Input: \$int = 1233334<br/>
> Output: -1<br/>
> <br/>
> Example 3<br/>
> Input: \$int = 10020003<br/>
> Output: "000"<br/>

This is my solution:

```perl
sub good_integer( $int ) {
    return $int =~ / (?: ^ | (.)(?!\g{-1}) ) ( (\d)\g{-1}\g{-1} ) (?!\g{-1}) /x ? $2 : -1;
}
```

Now let me explain what this does: 

There are three parts. Let's start with the center part, a regex to find a 'group of three', three same digits in a row. Not so difficult: capture a digit and use backreferences to that capture to match the second and third one:

```perl
    return $int =~ / (\d)\g{-1}\g{-1} /x ? $& : -1;
```

I am using relative references for capture groups here (like `\g{-1}`), because as we will see we will need to use more than one capture group, and knowing myself, renumbering often leads to errors.

This already works for Examples 1 and 3. But in Example 2, it finds a 'group of three of  `'333'` which isn't actually a 'Good Integer', because the `'3333'` does not contain 'exactly three' matching digits. 

So we also need to make sure that the digit *left* of our 'group of three' and any digit *right* of that group are both different.

For the digit *right* of our group this can easily be done by adding a *negative lookahead*, checking that that following digit is not the one captured as the first digit of the group:

```perl
    return $int =~ / (\d)\g{-1}\g{-1} (?!\g{-1}) /x ? $& : -1;
```

This will also work at the end of the string: since we won't find any digit there at all, the negative lookahead condition will pass in that case.

For anything *left* of our 'group of three', we are ok if the group is at the beginning of the string.
We can therefore match the beginning of the string in an alternative, like `(?: ^ | ... )`.

If we don't find a match using that `^` alternative, we have at least one character left of the 'group of three'. Because we need 'exactly three' same digits, we need to make sure that that character is not the same as the first digit in the group. We can use a capture and a negative lookahead again for checking that. So the whole 'left of the group of three' alternative is this:

```perl
    / (?: ^ | (.)(?!\g{-1}) ) /x
```

Note that now, for returning the 'group of three' as the result, we need to create an extra capture group for it, because the character left of the 'group' is matched and therefore part of `$&`. That's why we use `$2` in the solution, not `$&`.

## Task 2: Changing Keys

> You are given an alphabetic string, \$str, as typed by user.<br/>
> Write a script to find the number of times user had to change the key to type the given string. Changing key is defined as using a key different from the last used key. The shift and caps lock keys won’t be counted.<br/>
> <br/>
> Example 1<br/>
> Input: \$str = 'pPeERrLl'<br/>
> Ouput: 3<br/>
> p -> P : 0 key change<br/>
> P -> e : 1 key change<br/>
> e -> E : 0 key change<br/>
> E -> R : 1 key change<br/>
> R -> r : 0 key change<br/>
> r -> L : 1 key change<br/>
> L -> l : 0 key change<br/>
> <br/>
> Example 2<br/>
> Input: \$str = 'rRr'<br/>
> Ouput: 0<br/>
> <br/>
> Example 3<br/>
> Input: \$str = 'GoO'<br/>
> Ouput: 1<br/>

How can a key change be described in terms of a regular expression?

A key change happens if there is one character, followed by another one, and that other one is not the same as the first one.

Let's translate that:

* One character (that we capture):

    ```perl
    /(.)/
    ```

* ... followed by another one, that is not the same as the first one.<br/>
  For this, we us a combination of a positive and a negative lookahead. The positive one to make sure that there really *is* a character, and the negative one to make sure it is not the same as the first one: 
  
  ```perl
  /(.)(?=.)(?!\g{-1}/
  ```

Then we add an `i` flag to ignore case.<br/>
And we use a `g` flag to find all occurrences.<br/>And we use a list assignment in scalar context to get the number of matches returned (as described in [this useful stackoverflow article](https://stackoverflow.com/questions/2225460/how-do-i-find-the-number-of-values-in-a-perl-list)).<br/>And then we return the result.<br/>And there we are:

```perl
sub changing_keys( $str ) {
    return scalar( () = $str =~ /(.)(?=.)(?!\g1)/ig );
}
```

#### **Thank you for the challenge!**

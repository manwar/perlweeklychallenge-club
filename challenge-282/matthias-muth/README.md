# Power to the Regex!

**Challenge 282 solutions in Perl by Matthias Muth**

For this week's tasks, both of my solutions are one line of code, using **regular expressions only**!

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

Let's start with a regex that finds three same digits in a row. Not so difficult, capturing the first one and using a backreference to it to match the second and third one. I am using relative references for capture groups here (like `\g{-1}`), because as we will see we will need to use more than one capture group, and knowing myself, renumbering often leads to errors.

```perl
sub good_integer( $int ) {
    return $int =~ / (\d)\g{-1}\g{-1} /x // -1;
}
```

This works for Examples 1 and 3, but it considers Example 2 to contain a Good Integer `'333'`, while actually it isn't, because the `'3333'` does not contain 'exactly three' matching digits. 

So we need to make sure that the digit *before* our group of three is different, and also that the *next* digit *after* the three is different.

Checking that the digit *after* our group is different can easily be done with a *negative lookahead*: `(?!\g{-1})`. This will work at the end of the string, too, since we surely won't find our digit there, so the negative lookahead passes.

But can we do the same to check for a different digit *before* our group, using a *negative lookbehind*?<br/>Actually we cant.<br/>We would need to first capture the first digit. Then, as we are now standing *behind* the first digit, we would need to use a negative lookbehind for *two* digits, one that is *not* the one we just captured, and then the one that we  

* 





```perl
sub good_integer() {
    ...;
}
```

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

Lorem ipsum dolor sit amet...

```perl
sub changing_keys() {
    ...;
}
```

#### **Thank you for the challenge!**

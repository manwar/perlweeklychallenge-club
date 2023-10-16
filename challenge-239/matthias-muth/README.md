# Short Solutions for Short Strings

**Challenge 239 solutions in Perl by Matthias Muth**

## Task 1: Same String

> You are given two arrays of strings.<br/>
> Write a script to find out if the word created by concatenating the array elements is the same.<br/>
> <br/>
> Example 1<br/>
> Input: @arr1 = ("ab", "c")<br/>
>        @arr2 = ("a", "bc")<br/>
> Output: true<br/>
> Using @arr1, word1 => "ab" . "c" => "abc"<br/>
> Using @arr2, word2 => "a" . "bc" => "abc"<br/>
> <br/>
> Example 2<br/>
> Input: @arr1 = ("ab", "c")<br/>
>        @arr2 = ("ac", "b")<br/>
> Output: false<br/>
> Using @arr1, word1 => "ab" . "c" => "abc"<br/>
> Using @arr2, word2 => "ac" . "b" => "acb"<br/>
> <br/>
> Example 3<br/>
> Input: @arr1 = ("ab", "cd", "e")<br/>
>        @arr2 = ("abcde")<br/>
> Output: true<br/>
> Using @arr1, word1 => "ab" . "cd" . "e" => "abcde"<br/>
> Using @arr2, word2 => "abcde"<br/>

Now this is a really easy one.
All we have to do is to concatenate all elements of each array, and do a string comparison of the two resulting words:

```perl
sub same_string( $arr1, $arr2 ) {
    return join( "", $arr1->@* ) eq join( "", $arr2->@* );
}
```
Happy to use the '[Postfix Dereference Syntax](https://perldoc.perl.org/perlref#Postfix-Dereference-Syntax)'
```perl
    $array->@*
```
to get all elements of the array. In my opinion is easier to write and easier to read than the 'cast'-like `@{$array}` or its short form @$array, which can only be used in simple cases.
Same as I use

```perl
    $array->[1]
    $array->[2][3]
```
to access elements with references to arrays or multi-dimensional arrays, respectively.<br/>But I digress. I should rather keep it 'short'. :-)  

## Task 2: Consistent Strings

> You are given an array of strings and allowed string having distinct characters.<br/>
> A string is consistent if all characters in the string appear in the string allowed.<br/>
> Write a script to return the number of consistent strings in the given array.<br/>
> <br/>
> Example 1<br/>
> Input: @str = ("ad", "bd", "aaab", "baa", "badab")<br/>
>        \$allowed = "ab"<br/>
> Output: 2<br/>
> Strings "aaab" and "baa" are consistent since they only contain characters 'a' and 'b'.<br/>
> <br/>
> Example 2<br/>
> Input: @str = ("a", "b", "c", "ab", "ac", "bc", "abc")<br/>
>        \$allowed = "abc"<br/>
> Output: 7<br/>
> <br/>
> Example 3<br/>
> Input: @str = ("cc", "acd", "b", "ba", "bac", "bad", "ac", "d")<br/>
>        \$allowed = "cad"<br/>
> Output: 4<br/
> Strings "cc", "acd", "ac", and "d" are consistent.<br/>

This one, too, is a very short one if we use the right tool  for the right job.<br/>
In this case, a regular expressions accepting only allowed characters can filter out the 'consistent' strings.<br/>
We can use `grep` to iterate over the strings, and in scalar context it returns -- wait a second! -- the number of matches!<br/>
```perl
sub consistent_strings( $str, $allowed ) {
    return scalar grep /^[$allowed]*$/, $str->@*;
}
```
Done! :-)

#### **Thank you for the challenge!**

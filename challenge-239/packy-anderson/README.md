# Solutions by Packy Anderson

## Perl

* [Task 1](perl/ch-1.pl)

Sample output
```
$ perl/ch-1.pl
Example 1:
Input: @arr1 = ("ab", "c")
       @arr2 = ("a", "bc")
Output: true

Using @arr1, word1 => "ab" . "c" => "abc"
Using @arr2, word2 => "a" . "bc" => "abc"

Example 2:
Input: @arr1 = ("ab", "c")
       @arr2 = ("ac", "b")
Output: false

Using @arr1, word1 => "ab" . "c" => "abc"
Using @arr2, word2 => "ac" . "b" => "acb"

Example 3:
Input: @arr1 = ("ab", "cd", "e")
       @arr2 = ("abcde")
Output: true

Using @arr1, word1 => "ab" . "cd" . "e" => "abcde"
Using @arr2, word2 => "abcde" => "abcde"
```

* [Task 2](perl/ch-2.pl)

Sample output
```
$ perl/ch-2.pl
Example 1:
Input: @str = ("ad", "bd", "aaab", "baa", "badab")
       $allowed = "ab"
Output: 2

Example 2:
Input: @str = ("a", "b", "c", "ab", "ac", "bc", "abc")
       $allowed = "abc"
Output: 7

Example 3:
Input: @str = ("cc", "acd", "b", "ba", "bac", "bad", "ac", "d")
       $allowed = "cad"
Output: 4
```

## Raku

* [Task 1](raku/ch-1.raku)

Sample output
```
$ raku/ch-1.raku
Example 1:
Input: @arr1 = ("ab", "c")
       @arr2 = ("a", "bc")
Output: true

Using @arr1, word1 => "ab" . "c" => "abc"
Using @arr2, word2 => "a" . "bc" => "abc"

Example 2:
Input: @arr1 = ("ab", "c")
       @arr2 = ("ac", "b")
Output: false

Using @arr1, word1 => "ab" . "c" => "abc"
Using @arr2, word2 => "ac" . "b" => "acb"

Example 3:
Input: @arr1 = ("ab", "cd", "e")
       @arr2 = ("abcde")
Output: true

Using @arr1, word1 => "ab" . "cd" . "e" => "abcde"
Using @arr2, word2 => "abcde" => "abcde"
```

* [Task 2](raku/ch-2.raku)

Sample output
```
$ raku/ch-2.raku
Example 1:
Input: @str = ("ad", "bd", "aaab", "baa", "badab")
       $allowed = "ab"
Output: 2

Example 2:
Input: @str = ("a", "b", "c", "ab", "ac", "bc", "abc")
       $allowed = "abc"
Output: 7

Example 3:
Input: @str = ("cc", "acd", "b", "ba", "bac", "bad", "ac", "d")
       $allowed = "cad"
Output: 4
```

## Guest Language: Python
* [Task 1](python/ch-1.py)
* [Task 2](python/ch-2.py)

## Guest Language: Java

To be completed later...

## Guest Language: Elixir

To be completed later...

## Blog Post

[Perl Weekly Challenge: Now it’s the same old string, but with consistency since you’ve been gone…](https://packy.dardan.com/2023/10/16/perl-weekly-challenge-now-its-the-same-old-string-but-with-consistency-since-youve-been-gone/)

# A Half Liner and a Full One

**Challenge 272 solutions in Perl by Matthias Muth**

## Task 1: Defang IP Address

> You are given a valid IPv4 address.<br/>
> Write a script to return the defanged version of the given IP address.<br/>
> A defanged IP address replaces every period “.” with “[.]".<br/>
> <br/>
> Example 1<br/>
> Input: \$ip = "1.1.1.1"<br/>
> Output: "1[.]1[.]1[.]1"<br/>
> <br/>
> Example 2<br/>
> Input: \$ip = "255.101.1.0"<br/>
> Output: "255[.]101[.]1[.]0"<br/>

This task offers a good opportunity to demonstrate the `r` flag of the `s/<PATTERN>/<REPLACEMENT>/<FLAGS>`
regex substitution operator.

In fact it's the only thing we need to solve this task!

The `r` flag has been around since Perl version 5.14, so since 2011.<br/>
It causes the `s///` operator to *not* change the string that is operating on, as it normally does,
but ***r**eturn* the resulting string with the substitutions made.<br/>
It makes things easier a lot of times.

In this case, all we need to do is to replace every single dot
(we surely won't forget to use a backslash for escaping its special meaning!)
by the string `[.]`
(no escaping needed in the replacement pattern).<br/>
We also use the `g` flag to do a **g**lobal replacement of all the dots we find.

I would call this a 'half liner':

```perl
use v5.36;

sub defang_ip_address( $ip ) {
    return $ip =~ s/\./[.]/gr;
}
```

## Task 2: String Score

> You are given a string, \$str.<br/>
> Write a script to return the score of the given string.<br/>
> The score of a string is defined as the sum of the absolute difference between the ASCII values of adjacent characters.<br/>
> <br/>

> **Example 1**

> Input: \$str = "hello"<br/>
> Output: 13<br/>
> ASCII values of characters:<br/>
> h = 104<br/>
> e = 101<br/>
> l = 108<br/>
> l = 108<br/>
> o = 111<br/>
> Score => |104 - 101| + |101 - 108| + |108 - 108| + |108 - 111|<br/>
>    => 3 + 7 + 0 + 3<br/>
>    => 13<br/>
> <br/>

> **Example 2**

> Input: \$str = "perl"<br/>
> Output: 30<br/>
> ASCII values of characters:<br/>
> p = 112<br/>
> e = 101<br/>
> r = 114<br/>
> l = 108<br/>
> Score => |112 - 101| + |101 - 114| + |114 - 108|<br/>
>    => 11 + 13 + 6<br/>
>    => 30<br/>

> **Example 3**

> Input: \$str = "raku"<br/>
> Output: 37<br/>
> ASCII values of characters:<br/>
> r = 114<br/>
> a = 97<br/>
> k = 107<br/>
> u = 117<br/>
> Score => |114 - 97| + |97 - 107| + |107 - 117|<br/>
>    => 17 + 10 + 10<br/>
>    => 37<br/>

Let's split up this task into small parts of what we need to do:

* We need to split up the string into a list of characters:

  `my @characters = split "", $str;`

* We need to get the ASCII value of characters.

  That's easy, there is the `ord` function for this.

* We need to compute 'the absolute difference between the ASCII values of two characters'.

  This will look like `abs( ord( $a ) - ord( $b ) )` if we have the two characters in `$a` and `$b`.

* We need to get the differences between all *adjacent* characters.

  Now we could do this in a loop.<br/>
  We would use indexes from 0 to the second but last, or from 1 to the last,
  because we need to compare two elements in each iteration, with indexes `i` and `i + 1` (or `i` and `i - 1`).

  That could look like this:

  ```perl
  my $sum = 0;
  for ( 0 .. $#characters - 1 ) {
      $sum += abs( ord( $characters[$_] ) - ord( $characters[ $_ + 1 ] ) );    
  }
  ```
  
  Instead of the loop, we could also use `map` to get the values, and sum everything up using `sum`  from `List::Util`:
  ```perl
  my $sum = sum(
      map abs( ord( $characters[$_] ) - ord( $characters[ $_ + 1 ] ) ),
          0 .. $#characters - 1
  ); 
  ```
  
  But there is an even simpler solution!
  
  We can use the `slide` function from `List::MoreUtils`,
  which does exactly what we need:
  loop over adjacent elements of a list.
  
  This reduces our code drastically:
  
  ```perl
  my $sum = sum( slide { abs( ord( $a ) - ord( $b ) ) } @characters ); 
  ```

Now that we have all the parts, and we don't need a loop,
we can even put everything together into one single statement,
which results in this final version:

```perl
use v5.36;

use List::Util qw( sum );
use List::MoreUtils qw( slide );

sub string_score( $str ) {
    return sum( slide { abs( ord( $a ) - ord( $b ) ) } split "", $str );
}
```

#### **Thank you for the challenge!**

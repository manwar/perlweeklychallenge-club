# Binary + Odd = XOR

**Challenge 332 solutions in Perl by Matthias Muth**

## Task 1: Binary Date

> You are given a date in the format YYYY-MM-DD.<br/>
> Write a script to convert it into binary date.
>
> **Example 1**
>
> ```text
> Input: $date = "2025-07-26"
> Output: "11111101001-111-11010"
>```
> 
>**Example 2**
> 
>```text
> Input: $date = "2000-02-02"
> Output: "11111010000-10-10"
> ```
>
> **Example 3**
>
> ```text
>Input: $date = "2024-12-31"
> Output: "11111101000-1100-11111"
> ```

Let's take our Perl toolbox and find the right tools:

* Extracting numbers from a string:<br/>
  Regular expressions, of course. Don't forget to use the `/g` *global* flag...<br/>
  (Even though `split` would work nicely here, too, and maybe even a bit faster.)
* Convert a number to binary:<br/>`sprintf` is all we need, and simple to use.

Et voilà:

```perl
use v5.36;

sub binary_date( $date ) {
    return sprintf "%b-%b-%b", $date =~ /\d+/g;
}
```

## Task 2: Odd Letters

> You are given a string.<br/>
> Write a script to find out if each letter in the given string appeared odd number of times.
>
> **Example 1**
>
> ```text
> Input: $str = "weekly"
> Output: false
>
> w: 1 time
> e: 2 times
> k: 1 time
> l: 1 time
> y: 1 time
>
> The letter 'e' appeared 2 times i.e. even.
>```
> 
>**Example 2**
> 
>```text
> Input: $str = "perl"
> Output: true
> ```
>
> **Example 3**
>
> ```text
>Input: $source = "challenge"
> Output: false
> ```

The first thought is that we need to count how many times each letter appears.<br/>Using a hash is the standard and proven way to do this.

Maybe the `frequency` function from `List::MoreUtils` could be used to create that hash, because it's as simple as this:

```perl
use List::MoreUtils qw( frequency );
my $freq = frequency split //, $str;
```

Except experience shows that doing the counting ourselves in a loop usually is much faster, and not too complicated either.

But actually we don't really need to know the number of occurrences, we only to know whether the number is even or odd. The last bit of the count is all we need. So instead of counting, and then checking if the count is divisible by two, we can instead use just one bit that flips between 'even' and 'odd' .

The operation that does this 'flip-flop' for us is a binary XOR with a value of 1, in its assignment form, like this:

```perl
    $even_or_odd ^= 1;
```

Every `^= 1` operation flips the bit, perfectly indicating whether we've done an even or an odd number of operations so far.

```perl
    my %is_odd;
    $is_odd{$_} ^= 1
        for split //, $str;
```

It comes in very handy that in Perl we don't even need to initialize the variable, because an `undef` value is considered as a `0` when we use it in a numerical operation like this one. So when a character is encountered for the first time, the corresponding hash value is created implicitly.

Once we have run through all the characters, all existing hash entries are `1` if and only if all characters have appeared an odd number of times.

To get the final result, we can `grep` through the hash's values to find all non-`1` value, then check whether the count returned is zero.<br/>But we can already stop the search once we find a non-`1` value. The `any` and `all` functions from `List::Util` do exactly that, more 'elegant' than a loop:

```perl
use List::Util qw( all );
...
    return all { $_ } values %is_odd;
```

`any` and `all` have been available from `List::Util` since virtually forever (actually since 2002, Perl version 5.7.3), so not a problem with availability.

But in the latest version of Perl (Perl 5.42), `any` and `all` have been made available as core operators, just like `grep`. Now there's no need to load a module, and there's no overhead of any function calls or parameter handling.<br/>
For now, we need to add these two lines instead of the `use List::Util` statement (until this feature is declared non-experimental and added to a future Perl's 'feature bundle'):

```perl
use feature 'keyword_all';
no warnings 'experimental::keyword_all';
```

In my mind, this new feature makes creation of a loop completely unnecessary (same as it's probably very rare that a loop is programmed out where `grep` could be used). It combines performance and expressiveness of code.

So this is my preferred solution, making use of the most current evolutions of the Perl language and interpreter:

```perl
use v5.42;
use feature 'keyword_all';
no warnings 'experimental::keyword_all';

sub odd_letters( $str ) {
    my %is_odd;
    $is_odd{$_} ^= 1
        for split //, $str;
    return all { $_ } values %is_odd;
}
```

#### **Thank you for the challenge!**

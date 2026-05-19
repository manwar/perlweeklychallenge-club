# Very Stringish

**Challenge 372 solutions in Perl by Matthias Muth**

## Task 1: Rearrange Spaces

> You are given a string text of words that are placed among number of spaces.<br/>
> Write a script to rearrange the spaces so that there is an equal number of spaces between every pair of adjacent words and that number is maximised. If you can’t distribute, place the extra speaces at the end. Finally return the string.
>
> **Example 1**
>
> ```text
> Input: $str = "  challenge  "
> Output: "challenge    "
>
> We have 4 spaces and 1 word. So all spaces go to the end.
> ```
>
> **Example 2**
>
> ```text
> Input: $str = "coding  is  fun"
> Output: "coding  is  fun"
>
> We have 4 spaces and 3 words (2 gaps). So 2 spaces per gap.
> ```
>
> **Example 3**
>
> ```text
> Input: $str = "a b c  d"
> Output: "a b c d "
>
> We have 4 spaces and 4 words (3 gaps). So 1 space per gap and 1 remainder.
> ```
>
> **Example 4**
>
> ```text
> Input: $str = "  team      pwc  "
> Output: "team          pwc"
>
> We have 10 spaces and 2 words (1 gap). So 10 spaces per gap.
> ```
>
> **Example 5**
>
> ```text
> Input: $str = "   the  weekly  challenge  "
> Output: "the    weekly    challenge "
>
> We have 9 spaces and 3 words (2 gaps). So 4 spaces per gap and 1 remainder.
> ```

This is a quite straightforward task:

```perl
use v5.36;

sub rearrange_spaces( $str ) {
    my @words = split " ", $str;
    my $n_gaps = scalar @words - 1;
    my $n_spaces = $str =~ tr/ //;
    my $gap_length = $n_gaps > 0 ? int( $n_spaces / $n_gaps ) : 0;
    my $n_trailing = $n_spaces - $n_gaps * $gap_length;
    return join( " " x $gap_length, @words ) . " " x $n_trailing;
}
```

I chose to write this solution as self-documenting as possible, choosing speaking variable names, an limiting each statement to do just one single thing. At the same time, as each variable is referenced at least twice, repetitions are limited. The `$n_trailing` variable is an exception, it is only referenced once. But giving it a name documents what it is used for.  

## Task 2: Largest Substring

> You are given a string.<br/>
> Write a script to return the length of the largest substring between two equal characters excluding the two characters. Return -1 if there is no such substring.
>
> **Example 1**
>
> ```text
> Input: $str = "aaaaa"
> Output: 3
> 
> For character "a", we have substring "aaa".
> ```
>
> **Example 2**
>
> ```text
> Input: $str = "abcdeba"
> Output: 5
> 
> For character "a", we have substring "bcdeb".
> ```
>
> **Example 3**
>
> ```text
> Input: $str = "abbc
> Output: 0
> 
> For character "b", we have substring "".
> ```
>
> **Example 4**
>
> ```text
> Input: $str = "abcaacbc"
> Output: 4
> 
> For character "a", we have substring "bca".
> For character "b", we have substring "caac".
> For character "c", we have substring "aacb".
> ```
>
> **Example 5**
>
> ```text
> Input: $str = "laptop"
> Output: 2
> 
> For character "p", we have substring "to".
> ```

#### My strategy

For this task, my strategy is this:

* I have to walk through the string character by character.<br/>
  I need the character,
  but I also need its index in the string to compute the length
  of a possible delimited substring.<br/>
  I use a 'modern Perl' way for doing that in one line,
  using a multi-variable `for` loop
  together with the `builtin indexed` function:

  ```perl
      for my ( $index, $char ) ( indexed split "", $str ) {
          ...
      }
  ```

* Whenever a character is encountered for the first time,
  I create an entry in the `%seq_start` hash
  to remember the starting index of a possible substring
  delimited by this character.
  That substring will start *after* the current character,
  so `$index + 1` is stored in the hash entry.

  We then need to wait for the second (or later) same character,
  so for now we are done and can skip to the next iteration with `next`.

  ```perl
          if ( ! defined $seq_start{$char} ) {
              $seq_start{$char} = $index + 1;
              next;
          }
  ```

* If there already is a `%seq_start` entry for the current character,
  we can determine the length of the sequence,
  and set the maximum length found
  if the current sequence is longer than current maximum:

  ```perl
          my $length = $index - $seq_start{$char};
          $max_length = $length
              if $length > $max_length;
  ```

* In the end, we return the maximum sequence length `$max_length`.

  The `$max_length` variable is initialized to `-1`,
  which is the return value for 'no valid sequence found'.
  The good thing is that we then don't need any additional checks
  for building the maximum,
  because `-1` is less than the least possible sequence length
  (which is `0`),
  so if we find any valid sequence,
  the `-1` is replaced automatically.   

#### Enabling "Modern Perl" features

To enable the 'modern Perl' features used above,
putting this line at the top of the program is enough:

```perl
use v5.40;
```

If you don't have that Perl version, it also works from 5.36 with this boilerplate:

```perl
use v5.36;
use builtin 'indexed';
```

If in that case, you may want to suppress the warnings about the
'experimental' status that two of the features used still had then,
adding these two lines:

```perl
no warnings 'experimental::builtin';  # Not needed running Perl version >= 5.40.
no warnings 'experimental::for_list'; # Not needed running Perl version >= 5.40.
```



#### The 'full' solution

```perl
use v5.36;
use builtin 'indexed';                # Not needed with 'use v5.40' or higher.

no warnings 'experimental::builtin';  # Not needed running Perl version >= 5.40.
no warnings 'experimental::for_list'; # Not needed running Perl version >= 5.40.

sub largest_substring( $str ) {
    my ( $max_length, %seq_start ) = ( -1 );
    for my ( $index, $char ) ( indexed split "", $str ) {
        if ( ! exists $seq_start{$char} ) {
            $seq_start{$char} = $index + 1;
            next;
        }
        my $length = $index - $seq_start{$char};
        $max_length = $length
            if $length > $max_length;
    }
    return $max_length;
}
```

#### The 'short' solution

I have create a shortened version of my solution.

* I use the defined-or operator to set `$seq_start{$char}`
  if it doesn't exist yet, instead of checking it explicitly:

  ```perl
          $seq_start{$char} //= $index + 1;
  ```

  It's difficult to include the  `next` statement with this
  and still keep it short.
  I decided to just do without it,
  at the expense of running through the following length check
  even if it's the first time that the character is encountered.

  Actually, the length of the sequence in that case will be `-1`,
  because it starts at the following character
  and ends at the current position.
  This means that the check for the maximum
  will still work without any change,
  not overwriting any 'real' sequence length,
  and even maintaining the initial value of `-1` if it still there.

* I use the `or` operator instead of an `if` statement  modifier
  if the result fits on one line:

  ```perl
          $length < $max_length or $max_length = $length;
  ```

* I am using the latest Perl version
  (using `perlbrew`,
  which makes me independent of system package updates).

   I therefore can reduce the boilerplate to this:

  ```perl
  use v5.40;
  ```

This is the result:

```perl
use v5.40;

sub largest_substring( $str ) {
    my ( $max_length, %seq_start ) = ( -1 );
    for my ( $index, $char ) ( indexed split "", $str ) {
        $seq_start{$char} //= $index + 1;
        my $length = $index - $seq_start{$char};
        $length < $max_length or $max_length = $length;
    }
    return $max_length;
}
```

#### My 'shortest' solution

Then I thought,
"Can't it be reduced to a single statement that directly returns the result?".

This ends up in an approach that is a bit more 'functional'.
Using the `max` function from `List::Util`,
and a `map` call to produce a sequence length
for each character position in the string
(with a possible and acceptable sequence length of `-1`,
as discussed above):

```perl
use v5.36;

sub largest_substring( $str ) {
    my %seq_start;
    return max(
        map $_ - ( $seq_start{ substr( $str, $_, 1 ) } //= $_ + 1 ),
            0 .. length( $str ) - 1
    ) // -1;
}
```

I like this version, too.
But actually,
I find that putting everything in that `map` call makes it less readable.

That is why I declare the 'short' solution above to be my favorite. 

#### **Thank you for the challenge!**

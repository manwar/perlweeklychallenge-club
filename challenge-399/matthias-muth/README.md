# Sixes to Average and Strings to Buckets

**Challenge 398 solutions in Perl by Matthias Muth**

## Task 1: Divisible Average

> You are given an array of positive integers.<br/>
> Write a script to return the closest integer to the mean value of all even integers that are divisible by 3. If none is divisible, return 0.
>
> **Example 1**
>
> ```text
> Input: @arr = (18, 5, 7, 11)
> Output: 18
>
> 18 is the only even number and divisible by 3.
> Average: 18 / 1 = 18.
> ```
>
> **Example 2**
>
> ```text
> Input: @arr = (6, 12, 18, 24, 30, 40)
> Output: 18
>
> The qualifying numbers are 6, 12, 18, 24, and 30.
> Average: (6 + 12 + 18 + 24 + 30) / 5 = 90 / 5 = 18
> ```
>
> **Example 3**
>
> ```text
> Input: @arr = (3, 9, 15, 21, 27)
> Output: 0
>
> None of the elements are even.
> Since no elements qualify, return 0.
> ```
>
> **Example 4**
>
> ```text
> Input: @arr = (6, 12, 14, 20)
> Output: 9
>
> The qualifying numbers are 6 and 12.
> Average: (6 + 12) / 2 = 9.
> ```
>
> **Example 5**
>
> ```text
> Input: @arr = (6, 6, 6, 12, 12)
> Output: 8
>
> All five numbers are even and divisible by 3.
> Average: (6 + 6 + 6 + 12 + 12) / 5 = 8.4 => 8
> ```

Even though the task description is very short, let's have a closer look at a couple of things:

* >  all even integers that are divisible by 3

  If an integer is even and also divisible by 3, it is always divisible by 6. So, removing all non-qualifying numbers from the `@arr` array is as easy as this:

  ```perl
      @arr = grep { $_ % 6 == 0 } @arr;
  ```

* > the closest integer to the mean value of [...]

  This means *rounding* to the nearest integer. We can use the common rounding idiom `int( $value + 0.5 )`, which rounds up values with a fractional part of 0.5 to the next higher integer, at least for positive values. And as the task description assures us that all input values are positive, the average will be positive, too. With `@arr` containing only numbers divisible by 6, we can return the result like this:

  ```
      return @arr ? int( sum( @arr ) / @arr + 0.5 ) : 0;
  ```

  This also makes sure that we don't get a division-by-zero runtime error when there are no numbers that qualify.

So, everything together: 

```perl
use v5.36;
use List::Util qw( sum );

sub divisible_average( @arr ) {
    @arr = grep { $_ % 6 == 0 } @arr;
    return @arr ? int( sum( @arr ) / @arr + 0.5 ) : 0;
}
```

## Task 2: String Difference

> You are given an array of equal length strings.<br/>
> Write a script to find the difference integer array of each word in the given array. There will be one word with a different array; return that word.<br/>
> Each words[i] can be converted into a difference integer array difference[i] of length n - 1 where difference[i][j] = words[i][j+1] - words[i][j]
>
> **Example 1**
>
> ```text
> Input: @words = ("ab", "bc", "cd", "zy")
> Output: "zy"
>
> "ab" => [1 - 0] = [1]
> "bc" => [2 - 1] = [1]
> "cd" => [3 - 2] = [1]
> "zy" => [24 - 25] = [-1]
> ```
>
> **Example 2**
>
> ```text
> Input: @words = ("cba", "fed", "azy")
> Output: "azy"
>
> "cba" => [1 - 2, 0 - 1] = [-1, -1]
> "fed" => [4 - 5, 3 - 4] = [-1, -1]
> "azy" => [25 - 0, 24 - 25] = [25, -1]
> ```
>
> **Example 3**
>
> ```text
> Input: @words = ("pop", "ada", "beb", "cfc")
> Output: "pop"
>
> "pop" => [14 - 15, 15 - 14] = [-1, 1]
> "ada" => [3 - 0, 0 - 3] = [3, -3]
> "beb" => [4 - 1, 1 - 4] = [3, -3]
> "cfc" => [5 - 2, 2 - 5] = [3, -3]
> ```
>
> **Example 4**
>
> ```text
> Input: @words = ("aaaa", "zzzz", "mmmm", "aaba")
> Output: "aaba"
>
> "aaaa" => [0 - 0, 0 - 0, 0 - 0] = [0, 0, 0]
> "zzzz" => [25 - 25, 25 - 25, 25 - 25] = [0, 0, 0]
> "mmmm" => [12 - 12, 12 - 12, 12 - 12] = [0, 0, 0]
> "aaba" => [0 - 0, 1 - 0, 0 - 1] = [0, 1, -1]
> ```
>
> **Example 5**
>
> ```text
> Input: @words = ("aceg", "bdfh", "cegi", "azbz")
> Output: "azbz"
>
> "aceg" => [2 - 0, 4 - 2, 6 - 4] = [2, 2, 2]
> "bdfh" => [3 - 1, 5 - 3, 7 - 5] = [2, 2, 2]
> "cegi" => [4 - 2, 6 - 4, 8 - 6] = [2, 2, 2]
> "azbz" => [25 - 0, 1 - 25, 25 - 1] = [25, -24, 24]
> ```

So we are looking for an outlier in a set of input words,
and it is an array of letter differences that is the distinguishing criterion.

Comparing arrays,
or counting how often the same array occurs
in a set of arrays involves a lot of repeated comparisons.
I will make this part of the task easier
by defining a *signature* for every array,
which can be used in comparisons more easily.   

So I split the task into steps:

* Determine the array of letter differences for each input token.

  I will use the `slide` function from `List::MoreUtils`
  to walk through the letters of a word in pairs. The `slide` function applies the block to successive pairs of elements, which can be accessed by the `$a` and `$b` variables.. Here, `$a` and `$b` represent two consecutive letters, and `ord` converts each letter into its numeric character value.:

  ```perl
      slide { ord( $b ) - ord( $a ) } split "", $word
  ```

* Now I have a 'difference  array' for each input word.<br/>
  For finding the outlier in these arrays,
  I need to count how often each array occurs.<br/>
  To make this easier,
  I create a *signature* for each array which then can be used for counting. 

* The *signature*  could be an md5 or sha-1 checksum,
  but the easiest is to just concatenate all array elements into a string,
  using separators between the elements to make the result unambiguous:

  ```perl
      my $signature = join ",", slide { ord( $b ) - ord( $a ) } split "", $word;
  ```

  For example:

  ```text
  "aceg" => [2 - 0, 4 - 2, 6 - 4] = [2, 2, 2]        => "2,2,2"
  "azbz" => [25 - 0, 1 - 25, 25 - 1] = [25, -24, 24] => "25,-24,24"
  ```

* Now I can count the signatures like this:

  ```perl
      my %counts;
      for my $word ( @words ) {
          my $signature =
              join ",", slide { ord( $b ) - ord( $a ) } split "", $word;
          ++$counts{$signature};
      }
  ```

  There will be one entry in `%counts` that contains `1` as a value,
  representing the outlier.

But actually that doesn't help me, because I need to return the outlier itself,
not just the signature of its difference array.<br/>
So actually the previous step will not be used, but this one:

* Instead of keeping the count in `$counts{$signature}` (as a scalar value),
  I will keep the list of the words that lead to this signature,
  using an anonymous array.<br/>
  This is like sorting the words into **buckets**,
  where the buckets are labeled with the difference array signatures.

  For Example 2 from the task description, these are the signatures: 

  ```text
  "cba" => [1 - 2, 0 - 1] = [-1, -1]    => "-1,-1"
  "fed" => [4 - 5, 3 - 4] = [-1, -1]    => "-1,-1"
  "azy" => [25 - 0, 24 - 25] = [25, -1] => "25,-1"
  ```

  The `%counts`hash would have been this:

  ```perl
      (
          "-1,-1" => 2,
          "25,-1" => 1,
      )
  ```

  Now the `%buckets` hash will contain this:

  ```perl
      (
          "-1,-1" => [ "cba", "fed" ],
          "25,-1" => [ "azy" ],
      )
  ```

* Now we can find the bucket that has only one entry, and return its single entry:

  ```perl
      return ( grep $_->@* == 1, values %buckets )[0][0];
  ```

  `grep` returns the list of all buckets it finds that only contain one element. Even if we expect only one, it still is a list, of which we use the first element (using the first `[0]`) for the first bucket found, of which we then again take the first element (using the other `[0]`), which gives us the outlier word.

  This also works well if there are two or more outliers (each with a distinct, singular signature). In this case, one of them is returned, and as the order of hash entries in Perl is randomized (for security reasons), we cannot predict which one will come first. No good test 

  But it doesn't work when there is *no* outlier.
  In that case, the list returned by `grep` is empty. The first `[0]` will not result in a bucket (a valid arrayref), but in `undef`. Then, the second `[0]` will try using `undef` as an anonymous array, which will abort the script with an error message ('`Can't use an undefined value as an ARRAY reference`').

  So I revise this step:

* REVISED: Return the first word from the first bucket that has only one entry:

  ```perl
      return ( map $_->[0], grep $_->@* == 1, values %buckets )[0];
  ```

  Now,  `map` directly extracts the first (and only) element from any bucket
  that `grep` finds to contain exactly one element.

  The result will be a list of words, and normally it will contain only one word, because we expect exactly one outlier.

  As before, if there is more than one outlier, the first one will be returned ( by the outer `[0]`).   

  But now, if there is no outlier, it is the list of words that will be empty, not a list of buckets, as before. Taking the zeroth element simply results in an `undef` return value, not in a runtime error or program abort.

Now I think it it is robust enough to put it into a complete solution:

```perl
use v5.36;
use List::MoreUtils qw( slide );

sub string_difference( @words ) {
    my %buckets;
    for my $word ( @words ) {
        my $signature =
            join ",", slide { ord( $b ) - ord( $a ) } split "", $word;
        push $buckets{$signature}->@*, $word;
    }
    return ( map $_->[0], grep $_->@* == 1, values %buckets )[0];
}
```

#### **Thank you for the challenge!**

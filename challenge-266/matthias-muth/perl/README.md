# The Greatest, the Greatest

**Challenge 264 solutions in Perl by Matthias Muth**

## Task 1: Greatest English Letter

> You are given a string, \$str, made up of only alphabetic characters [a..zA..Z].<br/>
> Write a script to return the greatest english letter in the given string.<br/>
> A letter is greatest if it occurs as lower and upper case. Also letter ‘b’ is greater than ‘a’ if ‘b’ appears after ‘a’ in the English alphabet.<br/>
> <br/>
> Example 1<br/>Input: \$str = 'PeRlwEeKLy'<br/>
> Output: L<br/>
> There are two letters E and L that appears as lower and upper.<br/>
> The letter L appears after E, so the L is the greatest english letter.<br/>
> <br/>
> Example 2<br/>
> Input: \$str = 'ChaLlenge'<br/>
> Output: L<br/>
> <br/>
> Example 3<br/>
> Input: \$str = 'The'<br/>
> Output: ''<br/>

The idea is to first create a hash lookup that contains an entry for each letter that we encounter in the input string.

Then we find pairs of characters where both the uppercase and lowercase version of the character exist.
For this, we select only uppercase letters from the hash keys, and only those of them for which their lowercase entry exists, too.

To get the 'greatest' of the pairs, we sort the resulting letters, using the default alphanumeric sort. Of the resulting list, we take the last, 'greatest' entry by indexing from the the end with `[-1]`. <br/>
If there is no matching pair at all, this will result in an `undef` value, and we use Perl's 'defined-or' operator (`//`) to return an empty string in that case.

Of course, for larger volumes of characters there could be several possible optimizations, for example:
- use separate hashes for uppercase and lowercase letters, reducing the number of entries to check to around half,
- find the 'greatest' entry not by sorting all entries, but by doing a one-pass maximum search.<br/>

But I guess the result is nice enough: 

```perl
use v5.36;

sub greatest_english_letter( $str ) {
    my %have = map { ( $_ => 1 ) } split "", $str;
    return ( sort grep /^[A-Z]/ && $have{ lc $_ }, keys %have )[-1] // "";
}
```

## Task 2: Target Array

> You are given two arrays of integers, @source and @indices. The @indices can only contains integers 0 <= i < size of @source.<br/>
> Write a script to create target array by insert at index $indices[i] the value $source[i].<br/>
> <br/>
> Example 1<br/>
> Input: @source  = (0, 1, 2, 3, 4)<br/>
>        @indices = (0, 1, 2, 2, 1)<br/>
> Output: (0, 4, 1, 3, 2)<br/>
> @source  @indices  @target<br/>
> 0        0         (0)<br/>
> 1        1         (0, 1)<br/>
> 2        2         (0, 1, 2)<br/>
> 3        2         (0, 1, 3, 2)<br/>
> 4        1         (0, 4, 1, 3, 2)<br/>
> <br/>
> Example 2<br/>
> Input: @source  = (1, 2, 3, 4, 0)<br/>
>        @indices = (0, 1, 2, 3, 0)<br/>
> Output: (0, 1, 2, 3, 4)<br/>
> @source  @indices  @target<br/>
> 1        0         (1)<br/>
> 2        1         (1, 2)<br/>
> 3        2         (1, 2, 3)<br/>
> 4        3         (1, 2, 3, 4)<br/>
> 0        0         (0, 1, 2, 3, 4)<br/>
> <br/>
> Example 3<br/>
> Input: @source  = (1)<br/>
>        @indices = (0)<br/>
> Output: (1)<br/>

It seems that the task can *not* be solved by just assigning each
```perl
    $results[ $indexes[$_] ] = $source[$_];
```
Instead, we need to interpret the `@indexes`array as a working list to *insert* the respective `$source[$_]` values into the resulting array, one after the other.<br/>
Which is not too big a problem, we can directly use the `splice` function to do that.

And that's quite straightforward:

```perl
use v5.36;

sub target_array( $source, $indices ) {
    my @results;
    splice @results, $indices->[$_], 0, $source->[$_]
        for 0..$indices->$#*;
    return @results;
}
```

#### **Thank you for the challenge!**

# The Missing Equilibrium

**Challenge 371 solutions in Perl by Matthias Muth**

## Task 1: Missing Letter

> You are given a sequence of 5 lowercase letters, with one letter replaced by ‘?’. Each letter maps to its position in the alphabet (‘a = 1’, ‘b = 2’, …, ‘z = 26’). The sequence follows a repeating pattern of step sizes between consecutive letters. The pattern is either a constant step (e.g., ‘+2, +2, +2, +2’) or a simple alternating pattern of two distinct steps (e.g., ‘+2, +3, +2, +3’).
>
> **Example 1**
>
> ```text
> Input: $seq = qw(a c ? g i)
> Output: e
>
> The pattern of the sequence is +2,+2,+2,+2.
> 1: a
> 3: c
> 5: e
> 7: g
> 9: i
> ```
>
> **Example 2**
>
> ```text
> Input: $seq = qw(a d ? j m)
> Output: g
>
> The pattern of the sequence is +3,+3,+3,+3.
> 1: a
> 4: d
> 7: g
> 10: j
> 13: m
> ```
>
> **Example 3**
>
> ```text
> Input: $seq = qw(a e ? m q)
> Output: i
>
> The pattern of the sequence is +4,+4,+4,+4.
> 1: a
> 5: e
> 9: i
> 13: m
> 17: q
> ```
>
> **Example 4**
>
> ```text
> Input: $seq = qw(a c f ? k)
> Output: h
>
> The pattern of the sequence is +2,+3,+2,+3.
> 1: a
> 3: c
> 6: f
> 8: h
> 11: k
> ```
>
> **Example 5**
>
> ```text
> Input: $seq = qw(b e g ? l)
> Output: j
>
> The pattern of the sequence is +3,+2,+3,+2.
> 2: b
> 5: e
> 7: g
> 10: j
> 12: l
> ```

My approach does not try to find both parts of the pattern. Instead, I try to determine the missing letter from one of the neighbors to the left or right of the question mark, and from an existing pair at a position that is *relative* to that of the question mark.

These are the five possible question mark positions:

```text
( ? b c d e )
( a ? c d e )
( a b ? d e )
( a b c ? e )
( a b c d ? )
```

I found three rules that can be applied to determine the missing letter.
Assuming that the question mark is at position `$i`, and we have created an array `@nums` that contains the ASCII values of the characters in the input sequence `@seq`,
the three rules are:

1. If the question mark is the first element of `@seq` (i.e., `$i == 0`),
   the missing letter's ASCII value is<br/>
   `$nums[1] - ( $nums[3] - $nums[2] )`<br/>
   which is the same as<br/>
   `$nums[1] + $nums[2] - $nums[3]`<br/>
   (hardcoded edge case).

2. If not, and we have at least two elements *to the right* of the question mark, we add their difference to its *left* neighbor:<br/>
   `$nums[ $i - 1 ] + ( $nums[ $i + 2 ] - $nums[ $i + 1 ] )`<br/>
   or, without the parentheses:<br/>
   `$nums[ $i - 1 ] + $nums[ $i + 2 ] - $nums[ $i + 1 ]`

3. If not, we use the three neighbors *left* of the question mark:<br/>
   take everything from the With a minimum number of five elements in `@seq`,
   if none of the above is the case,
   `$nums[ $i - 1 ] + ( $nums[ $i - 2 ] - $nums[ $i -3 ] )`<br/>
   or, without the parentheses:<br/>
   `$nums[ $i - 1 ] + $nums[ $i - 2 ] - $nums[ $i - 3 ]`
   

For the implementation, I use `$qm_index` instead of `$i` for clarity.
I create three variables `( $base, $add, $subtract )`
for the three parts of the formula,
because the computation is always the same.

For rules 2 and 3, I extract only the relative positions, and let `map` add them to `$qm_index`.

I also use `map` to map all those indices to the ASCII values in `@nums`.

The result is a simple 'plus-minus' formula then:

```perl
use v5.36;

sub missing_letter( @seq ) {
    my @nums = map ord, @seq;
    my $qm_index = ( grep $seq[$_] eq "?", keys @seq )[0];
    my ( $base, $add, $subtract ) =
        map { $nums[$_] }
            $qm_index == 0
            ? ( 1, 3, 2 )
            : map { $qm_index + $_ }
                $qm_index + 2 <= $#nums
                ? ( -1, +2, +1 )
                : ( -1, -2, -3 );
    return chr( $base + $add - $subtract );
}
```
This works even for sequences that are longer than five characters or as short as only four characters.

## Task 2: Subset Equilibrium

*(to be continued)*

#### **Thank you for the challenge!**

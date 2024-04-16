# Weekly Challenge #260

### Task 2: Dictionary Rank
**Submitted by: Mark Anderson**

You are given a word, ```$word```.

Write a script to compute the dictionary rank of the given word.

#### Example 1
```
Input: $word = 'CAT'
Output: 3

All possible combinations of the letters:
CAT, CTA, ATC, TCA, ACT, TAC

Arrange them in alphabetical order:
ACT, ATC, CAT, CTA, TAC, TCA

CAT is the 3rd in the list.
Therefore the dictionary rank of CAT is 3.
```

#### Example 2
```
Input: $word = 'GOOGLE'
Output: 88
```

#### Example 3
```
Input: $word = 'SECRET'
Output: 255
```

---

### Solution

One approach is to create all permutations, sort them, and find the index of ```$word```.

This is fine for short words but there's a better solution for long words.

There are numerous videos on youtube explaining the algorithm - I think this a good one [https://www.youtube.com/watch?v=-MpL0X3AHAs](https://www.youtube.com/watch?v=-MpL0X3AHAs)

Here's the gist of the algorithm:

1. Find the rank of each letter.

   ```
   G O O G L E
   1 3 3 1 2 0
   ```

2. For each letter, find the number of letters to its right that have a lower rank.

   ```
   G O O G L E
   1 3 3 1 1 0
   ```

3. For each letter, take the number of repeating letters from that letter to the end of the string.
   Take the factorial of each result and multiply them together.

   ```
     G    O   O  G  L  E
   2!*2!  2!  1! 1! 1! 1!
   ```

   Starting with the first letter, there are 2 Gs and 2 Os so we end up with 2!*2!.
   The next letter is O. From that letter to the end of the string there is just the repeating O so we end up with 2!
   and so on.

4. Take the terms from step 2 and divide them by the terms from step 3.

   ```
    G    O    O   G   L    E
   1/4  3/2  3/1 1/1 1/1  0/1
   ```

5. Create the sequence ```$word```.end...0 and take the factorial of each term.

   ```
   G  O  O  G  L  E
   5! 4! 3! 2! 1! 0!
   ```

6. Multipy the terms from step 4 with the terms from step 5.

   ```
     G       O       O     G    L    E
   120/4  (3*24)/2  3*6   1*2  1*1  0*1
   ```

7. Sum the terms from step 6 and add 1 for a result of 88.
   ```
   G    O    O    G   L   E
   30 + 36 + 18 + 2 + 1 + 0 + 1 = 88
   ```
### My translation to Raku:

```
#!/usr/bin/env raku
use experimental :cached;

say rank('google');

sub postfix:<!>($n) is cached { [*] 1..$n }

sub rank($word)
{
    my @w = $word.comb;
    my @ranks = @w.sort.squish.antipairs.Map{@w};
    my $bag = @ranks.BagHash;

    my @n = gather for @ranks -> $r
    {
        my @less-than = $bag.keys.grep(* < $r);
        take ([+] $bag{@less-than}) / ([*] $bag.values>>!).FatRat;
        $bag{$r}--
    }

    1 + [+] @n Z* (@ranks.end...0)>>!
}
```

[The full program.](https://github.com/manwar/perlweeklychallenge-club/blob/master/challenge-260/mark-anderson/raku/ch-2.raku)

Thank you for reading my solution to the [Weekly Challenge #260 Task #2.](https://theweeklychallenge.org/blog/perl-weekly-challenge-260/)

*-Mark Anderson*

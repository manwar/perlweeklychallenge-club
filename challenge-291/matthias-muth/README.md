# Challenge 291 tasks: No Bluffing

**Challenge 291 solutions in Perl by Matthias Muth**

## Task 1: Middle Index

> You are given an array of integers, @ints.<br/>
> Write a script to find the leftmost middle index (MI) i.e. the smallest amongst all the possible ones.<br/>
> A middle index is an index where ints[0] + ints[1] + … + ints[MI-1] == ints[MI+1] + ints[MI+2] + … + ints[ints.length-1].<br/>
> If MI == 0, the left side sum is considered to be 0. Similarly,<br/>
> if MI == ints.length - 1, the right side sum is considered to be 0.<br/>
> Return the leftmost MI that satisfies the condition, or -1 if there is no such index.<br/>
> <br/>
> Example 1<br/>
> Input: @ints = (2, 3, -1, 8, 4)<br/>
> Output: 3<br/>
> The sum of the numbers before index 3 is: 2 + 3 + -1 = 4<br/>
> The sum of the numbers after index 3 is: 4 = 4<br/>
> <br/>
> Example 2<br/>
> Input: @ints = (1, -1, 4)<br/>
> Output: 2<br/>
> The sum of the numbers before index 2 is: 1 + -1 = 0<br/>
> The sum of the numbers after index 2 is: 0<br/>
> <br/>
> Example 3<br/>
> Input: @ints = (2, 5)<br/>
> Output: -1<br/>
> There is no valid MI.<br/>

Seems that we need to try every position for being the middle index or not. But instead of computing the left and right sums again and again for every position, we can *adjust* the two sums as we move from one index to the next one. Similar to this:

![Diagram 1](https://github.com/MatthiasMuth/perlweeklychallenge-club/blob/muthm-291/challenge-291/matthias-muth/Screenshot_2024-10-20_100335.png)

If we initialize the left sum to be zero, and the right sum to be the sum of *all* values (including `$ints[0]`), then the steps in each iteration are these:

*  subtract the value at the current index from the right sum,
* return the current index if the left and right sums now are equal,
* add the value at the current index to the left sum, in preparation for the next iteration.

If we didn't find a good 'middle index' in the loop, we return `-1` as requested.

This is my solution (comments removed):

```perl
use v5.36;

use List::Util qw( sum );

sub middle_index( @ints ) {
    my ( $right_sum, $left_sum ) = ( sum( @ints ), 0 );
    for ( 0..$#ints ) {
        $right_sum -= $ints[$_];
        return $_
            if $left_sum == $right_sum;
        $left_sum += $ints[$_];
    }
    return -1;
}
```



## Task 2: Poker Hand Rankings

> A draw poker hand consists of 5 cards, drawn from a pack of 52: no jokers, no wild cards. An ace can rank either high or low.<br/>
> Write a script to determine the following three things:<br/>
>
> 1. How many different 5-card hands can be dealt?<br/>
> 2. How many different hands of each of the 10 ranks can be dealt?<br/>
>    See here for descriptions of the 10 ranks of Poker hands:<br/>
>    https://en.wikipedia.org/wiki/List_of_poker_hands#Hand-ranking_categories<br/>
> 3. Check the ten numbers you get in step 2 by adding them together<br/>
>    and showing that they're equal to the number you get in step 1.<br/>

#### No cheating!

Wikipedia contains another *very* helpful entry about poker hands: [Poker probability](https://en.wikipedia.org/wiki/Poker_probability).<br/>
Actually it contains all the solutions to this task.<br/>But no cheating!!
I try to find the numbers myself!<br/>
Yet it's good to have a reference to build good test cases!

#### Helper functions

I have built two helper functions, one to compute factorials ${n!}$, and another one to compute 'n choose k' , for the number of different ways to choose $k$  objects out of a set of $n$ elements, without putting back the objects, and with permutations of the drawn objects to be all equivalent.  That's $\binom{n}{k} = \frac{n!}{k!(n-k)!}$.

I could have used a CPAN module for that (like `Math::Combinations`), but I wanted to do it myself, to see whether it was possible to avoid using `Math::BigInt` for large factorials (considering that $52!$ is a number with 68 digits!).<br/>As our $k$ is 5 at maximum (5 cards to draw), in fact we have a maximum of 5 numbers above and below the fraction bar. 

So here we go:

```perl
use v5.36;

use List::Util qw( reduce sum pairkeys );

sub factorial( $n ) { return reduce { $a * $b } 1..$n; }

sub n_choose_k( $n, $k ) {
    return
        ( reduce { $a *= $b } ( $n - $k + 1 ) .. $n )
        / ( reduce { $a *= $b } 1..$k );
}
```

#### The combinations

* **Five of a kind**<br/>
  This one is easy.<br/>
  As we don't use wild cards in our card deck,
  it is not possible to get a 'Five of a kind' hand at all.<br/>
  So this is it:<br/>
  
  ```perl
      "Five of a kind" => 0,
  ```
  
* **Straight flush**<br/>
  We choose one of the 4 suits.<br/>
  Next we choose the starting face value for the straight,
  from **A** (for **A-K-Q-J-10**) down to **6** (for **6-5-4-3-2**),<br/>
  adding one for the 'low ace' (**5-4-3-2-A**) straight.<br/>
  In total:
  
  ```perl
      "Straight flush" => 4 * ( 13 - 4 + 1 ),
  ```
  
* **Four of a kind**<br/>
  We have 13 choices for the face value that the 'Four of a kind' shall have.<br/>
  Then we still have to choose the 5th card from the $(52 - 4)$ remaining cards:
  
  ```perl
      "Four of a kind" => 13 * ( 52 - 4 ),
  ```
  
* **Full house**<br/>
  For the triplet, we choose the first card from all 52 cards of the deck,<br/>
  then the second card from of the three other cards of the same face value,<br/>
  and then the third card from the remaining two of that face value.<br/>
  Then we divide by $3!$ to eliminate the permutations of these three cards.
  
  Next, for the pair,
  we similarly choose one card from 48 cards of the rest of the deck
  (with the triplet removed,
  but also the fourth card of that face value removed).<br/>
  Then we choose the second card for the pair from the remaining three cards
  of the same face value.<br/>
  We divide by $2!$ to ignore the permutations of the two cards
  (knowing that there are only two ways of 'permuting' them,
  and $2!$ happens to be just $2$).
  
  ```perl
      "Full house" =>
          ( 52 * 3 * 2 ) / factorial( 3 )
          * ( ( 52 - 4 ) * 3 ) / factorial( 2 ),
  ```
  
  Actually, for the triplet, we could also first choose a face value (out of 13),
  and then three out of the four cards of that face value.<br/>
  The formula then is $13 \cdot \binom{4}{3}$.<br/>
  Which is equal to
  $ 13 \frac{ 4 \cdot 3 \cdot 2  \cdot 1 }{ 3 \cdot 2  \cdot 1 }
  = 13 \cdot \frac{4}{1} = 52$
  
  *What??*<br/>
  I have exactly 52 choices of choosing a *triplet* from a deck of 52 cards?
  Just as many as there are cards?
  
  Well, actually that's right:<br/>
  I can choose just any one of the 52 cards,
  and then take the three others of the same face value as my triplet.<br/>
  Any triplet is uniquely identified
  by the single card that is *not* in the triplet.
  Funny!
  
* **Flush**<br/>
  For a flush, we choose the suit for the flush, out of 4 possible suits.<br/>
  Then we choose 5 cards out of the 13 cards of that suit
  ($\binom{13}{5}
    = \frac{ 13 \cdot 12 \cdot 11 \cdot 10 \cdot 9 }
           { 5 \cdot 4 \cdot 3 \cdot 2 \cdot 1 }$).<br/>
  Some of the hands are 'Straight flush',
  so we have to subtract those to not count them twice.
  
  ```perl  
      "Flush" => 4 * n_choose_k( 13, 5 ) - ( 13 - 4 + 1 ) * 4,
  ```
  
* **Straight**<br/>
  
  Other than for the 'Straight flush',
  we *first* choose the starting face value for the straight,<br/>
  from **A** (for **A-K-Q-J-10**) down to **6** (for **6-5-4-3-2**),<br/>
  again adding one for the 'low ace' (**5-4-3-2-A**) straight.<br/>
  But now we have to choose the suit for each of the five cards,
  separately for each one of them,
  because each of them can be from any of the 4 suits.<br/>
  We have to subtract the number of combinations for
  'Straight Flush' here, too, because we counted them already.
  
  ```perl
      "Straight" =>
          ( 13 - 4 + 1 )
          * 4 * 4 * 4 * 4 * 4
              - ( 13 - 4 + 1 ) * 4,
  ```
  
* **Three of a kind**<br/>
  We start out the same as for a 'Full house', choosing the triplet.<br/>
  Then we choose the two single cards from the rest of the deck,
  but the two remaining cards must have different face values.
  The first one we can choose from the deck
  without the four cards having the triplet's face value, so $(52 - 4)$.<br/>
  For the second one, we also ignore all four cards having the face value
  of the first one, too, to make sure the second card is different.
  So here, we choose from $(52 - 8)$ cards.<br/>
  As we may have drawn the two singles in any of two orders,
  we must once more divide by $2!$, or just $2$,
  'the number of permutations of 2 cards'.
  
  ```perl
      "Three of a kind" =>
          52 * 3 * 2 / factorial( 3 )
              * ( 52 - 4 ) * ( 52 -8 ) / factorial( 2 ),
  ```
  
* **Two pair**<br/>
  We need to choose the two pairs:
  For the first pair, it's one card from 52,
  then, as we did it before, the second card from the three others of the same face value,
  divided by $2!$ for the 'permutations' of the two cards.<br/>
  The same for the second pair, but choosing from $( 52 - 4 )$ cards.<br/>
  Now the two pairs could be in one or the other order, too,
  so we divide by $2!$ once again.<br/>
  Eventually, we choose the fifth card from a face value not used
  in the pairs, of which there are $(52 - 8)$ cards.
  ```perl
      "Two pair" =>
          52 * 3 / factorial( 2 )
              * ( 52 - 4 ) * 3 / factorial( 2 )
              / factorial( 2 )
              * ( 52 - 8 ),
  ```

* **One pair**<br/>
  We now already know how to choose a pair from 52 cards.<br/>
  After doing so, we choose three cards with a different face values,
  the first from $(52 - 4) = 48$ cards, the second from $(52 - 8) = 44$,
  and the third from $(52 - 12) = 40$ cards.<br/>
  The three single cards can be in any order,
  so as usual we get rid of the permutaions by dividing by $3!$.
  
  ```perl
      "One pair" =>
          52 * 3 / factorial( 2 )
              * ( 52 - 4 ) * ( 52 - 8 ) * ( 52 - 12 )
              / factorial( 3 ),
  ```

* **High card**<br/>
  Choosing five cards from the deck,
  but they all need to have different face values.<br/>
  We choose the first one from the full deck ($52$ cards),
  the second one from $(52 -4)$ cards,
  without those having the first card's face value,
  and so on for all five cards.<br/>Then we ignore the permutations by dividing by $5!$.<br/>
  We still have to subtract all combinations that we already counted
  that have all different face values:<br/>
  'Straight flush', 'Flush', and 'Straight'.<br/>
  In the program, we do this correction later,
  when the hash entries for those have been set up.
  
  ```perl
      "High card" =>
          ( 52 * (52 - 4 ) * (52 - 8 ) * (52 - 12 ) * (52 - 16 ) )
              / factorial( 5 ),
  ...
      $combinations{"High card"} -=
          ( $combinations{"Straight flush"}
              + $combinations{"Flush"}
              + $combinations{"Straight"} );
  ```

#### The program

This is the Perl program for this task's solution, after the helper function definition as shown before.

I have put the combination calculations into an array, not a hash,
because I want to keep the entries in the same order as in the Wikipedia article.

I want to be able to do lookups for the numbers, with the hand names as keys,
and still keep an array for the order of names.
So after the definition, I transfer the data into a hash of the same name (`%combinations`) *and* create another array (`@hand_types`) to contain only the names.

```perl
my @combinations = (
    "Five of a kind" => 0,
    "Straight flush" => 4 * ( 13 - 4 + 1 ),
    "Four of a kind" => 13 * ( 52 - 4 ),
    "Full house" =>
        ( 52 * 3 * 2 ) / factorial( 3 ) * ( ( 52 - 4 ) * 3 ) / factorial( 2 ),
    "Flush" =>
        4 * n_choose_k( 13, 5 ) - ( 13 - 4 + 1 ) * 4,
    "Straight" =>
        ( 13 - 4 + 1 )
        * 4 * 4 * 4 * 4 * 4
            - ( 13 - 4 + 1 ) * 4,
    "Three of a kind" =>
        52 * 3 * 2 / factorial( 3 )
            * ( 52 - 4 ) * ( 52 -8 ) / factorial( 2 ),
    "Two pair" =>
        52 * 3 / factorial( 2 )
            * ( 52 - 4 ) * 3 / factorial( 2 )
            / factorial( 2 )
            * ( 52 - 8 ),
    "One pair" =>
        52 * 3 / factorial( 2 )
            * ( 52 - 4 ) * ( 52 - 8 ) * ( 52 - 12 )
            / factorial( 3 ),
    "High card" =>
        52 * (52 - 4 ) * (52 - 8 ) * (52 - 12 ) * (52 - 16 )
            / factorial( 5 ),
);

my %combinations = ( @combinations );
my @hand_types = pairkeys @combinations;

$combinations{"High card"} -=
    ( $combinations{"Straight flush"}
        + $combinations{"Flush"}
        + $combinations{"Straight"} );

$combinations{"Total"} = sum values %combinations;

sub poker_hand_rankings( $hand ) {
    return $combinations{$hand};
}
```

My `poker_hands_ranking` function returns the number of combinations
for the hand given as the parameter.<br/>
At least my guess of the number of combinations...

#### The tests

As I wrote before, there's a cool other [Wikipedia article](https://en.wikipedia.org/wiki/Poker_probability)
that presents the *correct* number of combinations.<br/>
I used the data from that article to write my tests:

```perl
use Test2::V0 qw( -no_srand );
use Data::Dump qw( pp );

my %expected = (
    "Five of a kind"  => 0,
    "Straight flush"  => 40,
    "Four of a kind"  => 624,
    "Full house"      => 3744,
    "Flush"           => 5108,
    "Straight"        => 10200,
    "Three of a kind" => 54912,
    "Two pair"        => 123552,
    "One pair"        => 1098240,
    "High card"       => 1302540,
    "Total"           => 2598960,
);

is $combinations{$_}, $expected{$_},
    "$expected{$_} combinations for '$_'";
    for @hand_types, "Total";

done_testing;
```

And I'm glad that I get this output:

```text
ok 1 - 0 combinations for 'Five of a kind'
ok 2 - 40 combinations for 'Straight flush'
ok 3 - 624 combinations for 'Four of a kind'
ok 4 - 3744 combinations for 'Full house'
ok 5 - 5108 combinations for 'Flush'
ok 6 - 10200 combinations for 'Straight'
ok 7 - 54912 combinations for 'Three of a kind'
ok 8 - 123552 combinations for 'Two pair'
ok 9 - 1098240 combinations for 'One pair'
ok 10 - 1302540 combinations for 'High card'
ok 11 - 2598960 combinations for 'Total'
1..11
```

It was nice to freshen up my knowledge in combinatorics!

#### **Thank you for the challenge!**

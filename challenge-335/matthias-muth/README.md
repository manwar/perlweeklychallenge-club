# Uncommon Bags and Winning Lines

**Challenge 335 solutions in Perl by Matthias Muth**

## Task 1: Common Characters

> You are given an array of words.<br/>
> Write a script to return all characters that is in every word in the given array including duplicates.
>
> **Example 1**
>
> ```text
> Input: @words = ("bella", "label", "roller")
> Output: ("e", "l", "l")
>```
> 
>**Example 2**
> 
>```text
> Input: @words = ("cool", "lock", "cook")
> Output: ("c", "o")
> ```
>
> **Example 3**
>
> ```text
>Input: @words = ("hello", "world", "pole")
> Output: ("l", "o")
> ```
> 
>**Example 4**
> 
>```text
> Input: @words = ("abc", "def", "ghi")
>Output: ()
> ```
> 
> **Example 5**
>
> ```text
>Input: @words = ("aab", "aac", "aaa")
> Output: ("a", "a")
>```

Maybe the concept of a 'Bag' data structure is a bit underrated in Perl. That's bad, because the `Set::Bag` module from CPAN does a great job, making many things a lot easier.

Essentially, a 'bag' is like a 'set', except if you add an element several times, all of the elements are kept in the bag, not just one as in a set.

The same is true for removing elements. If I put five identical elements into a bag, then remove three of them from that bag, there will be two elements left in the bag. Very intuitive.

This concept can be applied perfectly for this task here:

We split up the first word into characters, and put those into a bag. Just like in a game of Scrabble.

The `Set::Bag` constructor expects pairs of each an element name and its respective number of occurrences. It's good that if the same element occurs multiple times in the parameter list, everything is added to the bag (other than when we create a hash!). So we can give a `1` as the number of occurrences for every letter, even if it reappears again later. So to create the initial 'common' bag:  

```perl
    my $common_bag = Set::Bag->new( map { ( $_ => 1 ) } split //, $words[0] );
```

Then, we loop over all other words (all except the first one).

For each word, we do the same splitting up into letters and putting them into a bag.<br/>
Then, we use the *intersection* operation to get rid of all characters that are not in both bags. It is defined like this:

>The **intersection** leaves in the result bag only the elements that have instances in all bags and of those the minimal number of instances.

This is exactly what we need: the minimum number of each element (letter) that is contained in both bags (words).

The *intersection* operation can even be called using an overloaded `&` operator, also as an assignment, like `&=`:

```perl
    $common_bag &= Set::Bag->new( map { ( $_ => 1 ) } split //, $_ )
        for @words[1..$#words];
```

That's all the magic!

After all words are processed, we need to get all elements that still remain in the bag. The `grab` function does this. It can either return list of *all* elements with their respective numbers of occurrences, as a paired list that can be assigned to a hash (similar to `frequency` from `List::MoreUtils`) , or used in a multi-variable `for` loop, but it can also return the number of occurrences of a *single* element that we give as a parameter. As we need a *sorted* return list, it is easier to get the names of elements using the `elements` function, sort them, then `grab` each elements number of occurrences and create a that number of entries for a list. For this multiplication of entries for the return list, we can use Perl's `x` list repetition operator.

The one-statement code for that is less complicated than this long description would let expect:

```perl
    return map +( $_ ) x $common_bag->grab( $_ ),
        sort $common_bag->elements;
```

So this is my possibly 'uncommon' solution to the 'Common characters' task:

```perl
use v5.36;

use Set::Bag;

sub common_characters( @words ) {
    my $common_bag = Set::Bag->new( map { ( $_ => 1 ) } split //, $words[0] );
    $common_bag &= Set::Bag->new( map { ( $_ => 1 ) } split //, $_ )
        for @words[1..$#words];
    return map +( $_ ) x $common_bag->grab( $_ ),
        sort $common_bag->elements;
}
```

## Task 2: Find Winner

> You are given an array of all moves by the two players.<br/>
> Write a script to find the winner of the TicTacToe game if found based on the moves provided in the given array.<br/>
> UPDATE: Order move is in the order - A, B, A, B, A, ….
>
> **Example 1**
>
> ```text
> Input: @moves = ([0,0],[2,0],[1,1],[2,1],[2,2])
> Output: A
>
> Game Board:
> [ A _ _ ]
> [ B A B ]
> [ _ _ A ]
>```
> 
>**Example 2**
> 
>```text
> Input: @moves = ([0,0],[1,1],[0,1],[0,2],[1,0],[2,0])
> Output: B
> 
>Game Board:
> [ A A B ]
> [ A B _ ]
> [ B _ _ ]
> ```
>
> **Example 3**
>
> ```text
>Input: @moves = ([0,0],[1,1],[2,0],[1,0],[1,2],[2,1],[0,1],[0,2],[2,2])
> Output: Draw
> 
> Game Board:
>[ A A B ]
> [ B B A ]
> [ A B A ]
> ```
> 
>**Example 4**
> 
>```text
> Input: @moves = ([0,0],[1,1])
>Output: Pending
> 
> Game Board:
> [ A _ _ ]
>[ _ B _ ]
> [ _ _ _ ]
> ```
> 
> **Example 5**
>
> ```text
>Input: @moves = ([1,1],[0,0],[2,2],[0,1],[1,0],[0,2])
> Output: B
>
> Game Board:
> [ B B B ]
> [ A A _ ]
>[ _ _ A ]
> ```

Instead of maintaining the 3 x 3 board, and analyzing it in the end, I chose a different approach.

My idea is this:

* For each move, I don't mark the point in a 2-D grid, but instead, for every line that the point is on, I increment that line's counter for the current player.
* Whenever a mark counter is incremented to 3, this is the winning line, and that player is the winner.
* If we arrive at the end of the moves, and there has been no winner yet, the game is a 'draw' if nine moves were played, and if there were less than nine moves, it is 'pending'.

To implement this, I first define the line numbers:

* 0..2: horizontal lines (top to bottom),
* 3..5: vertical lines (left to right),
* 6: top-left to bottom right diagonal,
* 7: top-right to bottom-left diagonal.

Then, I produce a 'precomputed' list of line numbers for each point:

```perl
my @lines_by_points = (
    [ [ 0, 3, 6 ], [ 0, 4 ],       [ 0, 5, 7 ] ],
    [ [ 1, 3    ], [ 1, 4, 6, 7 ], [ 1, 5 ]    ],
    [ [ 2, 3, 7 ], [ 2, 4 ],       [ 2, 5, 6 ] ],
);
```

Then, the rest of the implementation is more or less straightforward.<br/>Just note the little shortcut for incrementing and comparing to `3` in the same statement.<br/>
We also mustn't forget to switch players after every move. 

```perl
use v5.36;

# winning lines:
#    0 - . . .
#    1 - . . .
#    2 - . . .
#       /| | |\
#     7  3 4 5  6

my @lines_by_points = (
    [ [ 0, 3, 6 ], [ 0, 4 ],       [ 0, 5, 7 ] ],
    [ [ 1, 3    ], [ 1, 4, 6, 7 ], [ 1, 5 ]    ],
    [ [ 2, 3, 7 ], [ 2, 4 ],       [ 2, 5, 6 ] ],
);

sub find_winner( $moves ) {
    my @lines;
    my $player = "A";
    for ( $moves->@* ) {
        my ( $r, $c ) = $_->@[0,1];
        for my $line ( $lines_by_points[$r][$c]->@* ) {
            return $player
                if ++$lines[$line]{$player} == 3;
        }
        $player = $player eq "A" ? "B" : "A";
    }
    return $moves->@* == 9 ? "Draw" : "Pending";
}
```

My hope is that this uses less resources than any type of analyzing the 2-D grid after putting in all marks.  

#### **Thank you for the challenge!**

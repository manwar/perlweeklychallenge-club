# Twice the Largest - Once the Zuma

**Challenge 292 solutions in Perl by Matthias Muth**

## Task 1: Twice Largest

> You are given an array of integers, @ints, where the largest integer is unique.<br/>
> Write a script to find whether the largest element in the array is at least twice as big as every element in the given array. If it is return the index of the largest element or return -1 otherwise.<br/>
> <br/>
> Example 1<br/>
> Input: @ints = (2, 4, 1, 0)<br/>
> Output: 1<br/>
> The largest integer is 4.<br/>
> For every other elements in the given array is at least twice as big.<br/>
> The index value of 4 is 1.<br/>
> <br/>
> Example 2<br/>
> Input: @ints = (1, 2, 3, 4)<br/>
> Output: -1<br/>
> The largest integer is 4.<br/>
> 4 is less than twice the value of 3, so we return -1.<br/>

I have two solutions for this task:<br/>First, the short 'Perlish' solution,
easy to understand and fast to implement:

I don't really need to compare the largest element to all the others, as the task text suggests. It's enough to check whether the largest one is at least twice as large as the *second* largest. If so, it will also be more than twice as large as all other elements.

So I sort the array numerically, largest first.<br/>
Then I only need to compare the first and the second elements
(the largest and twice the second largest).<br/>
I return the result of that comparison if it is true, and a `-1` if not,
using a `||` 'logical or' shortcut.

```perl
use v5.36;

sub twice_largest( @ints ) {
    my @sorted = sort { $b <=> $a } @ints;
    return $sorted[0] >= 2 * $sorted[1] || -1;
}
```

I typed this on my mobile phone (I agree that sigils are a bit of a pain there! :-D).<br/>
It worked immediately, and I love this solution.

My only worries were that as `sort` does not have a linear runtime,
it might take longer than simply going through the array once
for finding the largest and second largest numbers.
So I implemented that as well, to do some benchmarks.

I tried to make it as fast as possible,
so I had to do a good initialization of the two variables
to avoid 'defined' checks within the loop.
As a result, it looks way more complicated than the first solution:

```perl
sub twice_largest_2( @ints ) {
    return -1
        unless @ints >= 2;
    my ( $largest, $second ) =
        $ints[0] > $ints[1]
        ? @ints[0,1]
        : @ints[1,0];
    for ( 2..$#ints ) {
        if ( $ints[$_] > $second ) {
            if ( $ints[$_] > $largest ) {
                ( $largest, $second ) = ( $ints[$_], $largest );
            }
            else {
                $second = $ints[$_];
            }
        }
    }
    return $largest >= 2 * $second || -1;
}
```

But what about the runtime?<br/>
These are the comparison results for 10, 100, 1000 and 10000 entries in the `@ints` array:

```text
             Rate loop_10 sort_10
loop_10  756560/s      --    -28%
sort_10 1050584/s     39%      --

             Rate loop_100 sort_100
loop_100 121069/s       --     -14%
sort_100 141127/s      17%       --

             Rate sort_1000 loop_1000
sort_1000  9399/s        --      -33%
loop_1000 14065/s       50%        --

             Rate sort_10000 loop_10000
sort_10000  616/s         --       -57%
loop_10000 1423/s       131%         --
```

It turns out that up to 100 entries, the simple and nice first solution (that uses `sort`) is faster than the manual linear search in a loop. This doesn't astonish me too much, since the underlying `sort` function probably is implemented in `C`, while my own loop is 'Pure Perl'.

Only for larger arrays, the linear search gains advantage.
For 10000 entries, it is more than twice as fast.

Moral:
Most of the times a simple and nice 'Perlish' solution is
not only easier to write and to maintain, but also fast enough.<br/>
Only once speed really becomes a problem
it is time to think about putting effort into optimizations.


## Task 2: Zuma Game

> You are given a single row of colored balls, \$row and a random number of colored balls in \$hand.<br/>
> Here is the variation of Zuma game as your goal is to clear all of the balls from the board. Pick any ball from your hand and insert it in between two balls in the row or on either end of the row. If there is a group of three or more consecutive balls of the same color then remove the group of balls from the board. If there are no more balls on the board then you win the game. Repeat this process until you either win or do not have any more balls in your hand.<br/>
> Write a script to minimum number of balls you have to insert to clear all the balls from the board. If you cannot clear all the balls from the board using the balls in your hand, return -1.<br/>
> <br/>
> Example 1<br/>
> Input: \$board = "WRRBBW", \$hand = "RB"<br/>
> Output: -1<br/>
> It is impossible to clear all the balls. The best you can do is:<br/>
>
> - Insert 'R' so the board becomes WRRRBBW. WRRRBBW -> WBBW.<br/>
> - Insert 'B' so the board becomes WBBBW. WBBBW -> WW.<br/>
> There are still balls remaining on the board, and you are out of balls to insert.<br/>
> <br/>
> Example 2<br/>
> Input: \$board = "WWRRBBWW", \$hand = "WRBRW"<br/>
> Output: 2<br/>
> To make the board empty:<br/>
> - Insert 'R' so the board becomes WWRRRBBWW. WWRRRBBWW -> WWBBWW.<br/>
> - Insert 'B' so the board becomes WWBBBWW. WWBBBWW -> WWWW -> empty.<br/>
> 2 balls from your hand were needed to clear the board.<br/>
> <br/>
> Example 3<br/>
> Input: \$board = "G", \$hand = "GGGGG"<br/>
> Output: 2<br/>
> To make the board empty:<br/>
> - Insert 'G' so the board becomes GG.<br/>
> - Insert 'G' so the board becomes GGG. GGG -> empty.<br/>
> 2 balls from your hand were needed to clear the board.<br/>

I couldn't find a solution that does *not* traverse the tree of all possible moves and all their possible continuations. So I had to implement a 'broadth-first search' (BFS) to find the smallest number of moves.

I find that actually, a BFS is not too complicated to implement, once the following things are decided on:

* What are the data needed to *describe* a node in the graph and the possible ways to continue from there?
  
  For us, these are:
  
  * the current board,
  * the current hand,
  * the number of moves made so far, so that we can return the number of moves done once the end condition is fulfilled.
  
* What are the data to *identify* a node in the graph, in order to avoid running into circles?
  
  For us, this is not a problem.<br/>
  In every move, we remove one ball from the 'hand',
  so that any further moves will always have a different 'hand'
  (because it contains less balls),
  and will never be identical.<br/>
  This means that we don't have to take care about not 'revisiting' nodes at all.
  So we don't need a `%visited` structure or anything similar here.
  
* What are the next possible nodes to move to from one node?

  Here, we need to think a little.

  We need to consider all balls that we have in our 'hand'.<br/>
  But actually, all balls of the same color will lead to the same situation that follows.
We therefore consider only one ball for every color that we have in our 'hand'
to generate moves.

  Each ball that we try, we need to try at all places in the 'board',
including in front of the first existing ball and also behind the last one.

  This leads to a double loop to create all possible follow-up situations,
for trying each available ball color at each possible position.  

* What is the end condition?
  
  After putting a ball at a position
  and then trying to remove all possible sequences of at least three same-colored balls,
  we check whether the result  is an empty board.
  If yes, we directly return the current  number of moves.
  
* When to further proceed into the graph?

  If the end condition is not met with the new board, we put the board, the new hand (reduced by a ball of the color we just have put into the board) and the new number of moves on the queue for further traversal from there. 

Having decided all this, we can construct our `zuma_game` subroutine:

```perl
use v5.36;
use List::Util qw( uniq );

sub zuma_game( $board, $hand ) {
    # Initialize the queue with the initial situation.
    my @queue = ( [ $board, $hand, 0 ] );

    # Traverse the graph.
    while ( @queue ) {
        my ( $board, $hand, $n_moves ) = @{ shift @queue };

        # Go through the colors of the existing balls
        # (do not repeat the same color).
        for my $insertion ( uniq split "", $hand ) {

            # Remove *one* ball of the insertion color from the hand.
            my $reduced_hand = $hand =~ s/$insertion//r;

            # Try all positions for that ball.
            for ( 0..length( $board ) ) {
                # Insert the ball at that position.
                substr( my $new_board = $board, $_, 0 ) = $insertion;

                # Do as many removals as possible.
                while ( $new_board =~ s/(.)\g{-1}{2,}// ) {
                    # Everything is in the loop condition.
                }

                # Check end criteria.
                return $n_moves + 1
                    if $new_board eq "";

                # Descend further (if needed and possible).
                push @queue, [ $new_board, $reduced_hand, $n_moves + 1 ]
                    if $reduced_hand ne "";
            }
        }
    }

    # No solution found.
    return -1;
}
```

Good exercise!



#### **Thank you for the challenge!**

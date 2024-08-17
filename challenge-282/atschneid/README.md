# Chess Moves

**Challenge 281 solutions by Andrew Schneider**

[PWC 281](https://theweeklychallenge.org/blog/perl-weekly-challenge-281/)

Two related challenges this week, both involving the chess board. The first one has a trick regarding odds and evens. The second one I solve via Breadth First Search

## TASK 1: Check Color

> Task 1: Check Color</br>
> Submitted by: Mohammad Sajid Anwar</br>
> You are given coordinates, a string that represents the coordinates of a square of the chessboard as shown below:</br>
> </br>
> Write a script to return true if the square is light, and false if the square is dark.</br>
> </br>
> Example 1</br>
> Input: $coordinates = "d3"</br>
> Output: true</br>
> </br>
> Example 2</br>
> Input: $coordinates = "g5"</br>
> Output: false</br>
> </br>
> Example 3</br>
> Input: $coordinates = "e6"</br>
> Output: true

The trick to this one is to realize that if you convert the letters to numbers, in a sensible way such as 'a' -> 1, 'b' -> 2, etc., you can figure out the color of the space by summing the index, and checking if it is odd or even. Which one you want for the black or white square depends on your conversion.

```perl
sub check_square( $key ) {
    return sum( map { ord($_) } split '', $key ) % 2;
}
```

Conveniently the character '1' and the character 'a' both are represented by an odd number, so we don't need to do any conversion besides converting the characters into their ascii using `ord`.

We pass this function a space index, like 'a1', as a string. We split the string into its characters, convert each to its ascii, sum up the values, and modulo it by 2. 

This function works on the example input. It would also output a value for any two character string, or any string at all for that matter! Is this a feature or a bug? Not sure! but we could always add in some length and value checks to error on bad input.

## Task 2: Knight's Move

> Task 2: Knight’s Move</br>
> Submitted by: Peter Campbell Smith</br>
> A Knight in chess can move from its current position to any square two rows or columns plus one column or row away. So in the diagram below, if it starts a S, it can move to any of the squares marked E.</br>
> </br>
> Write a script which takes a starting position and an ending position and calculates the least number of moves required.</br>
> </br>
> Example 1</br>
> Input: $start = 'g2', $end = 'a8'</br>
> Ouput: 4</br>
> </br>
> g2 -> e3 -> d5 -> c7 -> a8</br>
> </br>
> Example 2</br>
> Input: $start = 'g2', $end = 'h2'</br>
> Ouput: 3</br>
> </br>
> g2 -> e3 -> f1 -> h2

The high level idea here is: to get to the start space takes zero moves. To get to any space takes 1 additional move, and any space from there is 1+1 moves, and so on.

So we mark the start space with value 0, then find all spaces we can reach from this one, mark them with value 1, then repeat the same for each space, and repeat, and repeat. If the space has been visited already, we skip it, since we have already found the shortest number of moves to get there. And if we land on the end space we return its value.

To store the list of spaces to inspect I use a FIFO queue to ensure the search is breadth-first, which makes the algorithm more efficient -- we don't have to check if the value is the minimum and we can reliably inspect each space only once. The BFS solution for this problem is $\mathcal O (8 \times 8)$, that is, it's linear in the board size.

```perl
sub knight_path( $start_key, $end_key ){
    my @queue = ($start_key);
    my %board;
    $board{ $start_key } = 0;

    while ( $#queue >= 0 ) {
	my $current = shift @queue;
	if ($current eq $end_key) {
	    return $board{ $current };
	}
	for ( get_moves( $current ) ) {
	    if ( !exists $board{ $_ } ) {
		push @queue, $_;
		$board{ $_ } = $board{ $current } + 1;
	    }
	}
    }
}
```

For the queue I use a normal list and access elements using `shift` and add elements using `push`. For the board I use a hashmap with the string index key as the key, if the key is in the map then we know we have inspected the space already.

The trickiest part here was generating the list of possible next moves from each space

```perl
sub get_moves( $key ) {
    my @moves = (
	[2, 1], [1, 2], [-2, 1], [1, -2],
	[2, -1], [-1, 2], [-2, -1], [-1, -2]
	);

    my @idx = split '', $key;
    my @next_moves = ();
    for (@moves) {
	my @candidate = (
	    ord($idx[0]) + $_->[0],
	    ord($idx[1]) + $_->[1]
	    );
	if (
	    $candidate[0] >= ord('a') and
	    $candidate[0] <= ord('h') and
	    $candidate[1] >= ord('1') and
	    $candidate[1] <= ord('8')
	    ) {
	    push @next_moves, join '', map { chr( $_ ) } @candidate;
	}
    }
    return @next_moves;
}
```

The knight can move in a 1,2 L shape from its current location. For each of the 8 possibilities, we return a list of only the legal moves that land within the board dimensions.

That's about that. The Perl solution is pretty speedy.

## Others

I also wrote solutions in Julia and Racket this week. Task 1 was easy in each. For task 2, in Julia I used a 8 by 8 matrix for the board, becuaes it felt intuitive, but addressing each square seemed more complicated than it should have been. In Julia you can do something like `*(1, 2)` to return the values `1` and `2`, but you can't seem to do this with a variable. Like `v = (1, 2); *v` throws an error. Also the Julia version takes longer (anecdotally) to run than the Perl version. I'm sure there are some easy changes that would speed things up.

As for Racket, well, ... it's done and it gives the correct answer. I used a library to get a queue data structure. For stacks, oh you want stacks? Racket can do stacks! But queues are a problem. I probably should have implemented my own using structs. Or, as i did in Julia, just use an array with a start index to simulate a queue. 

## Conclusion

That's it for this week. I did these challenges while on vacation. They helped to keep my brain from otherwise atrophying.

Oh, also, thanks to Mohammad and the Perl Weekly Challenge committee for acknowledging me! Why do I do this? Surely not for the fame and notoriety, but those things help! Ha!

See you next week!

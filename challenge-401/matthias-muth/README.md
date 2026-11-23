# Don't Jump Mutations

**Challenge 400 solutions in Perl by Matthias Muth**

## Task 1: Largest Interval

> You are given a positive integer.<br/>
> Write a script that generates a sequence of integers from 1 to given positive integer, filtering out any numbers that contain repeating digits (e.g., 11, 99, 100, and 101 are excluded) and return the biggest jump.
>
> **Example 1**
>
> ```text
> Input: $int = 20
> Output: 2
>
> Biggest jump between 10 and 12.
> ```
>
> **Example 2**
>
> ```text
> Input: $int = 110
> Output: 4
>
> Biggest jump between 98 and 102.
> ```
>
> **Example 3**
>
> ```text
> Input: $int = 500
> Output: 11
>
> Biggest jump between:
> a) 109 and 120 => 11
> b) 219 and 230 => 11
> c) 329 and 340 => 11
> d) 439 and 450 => 11
> ```
>
> **Example 4**
>
> ```text
> Input: $int = 2026
> Output: 105
>
> Biggest jump between 1098 and 1203.
> ```
>
> **Example 5**
>
> ```text
> Input: $int = 10000
> Output: 105
>
> The largest gap is 105, between 1098 and 1203. And again between 8796 and 8901.
> ```

The center part of my solution is a loop over the integers from `1` to `$int`. For each integer, I check whether it has repeating digits using a regular expression with a back reference:

```perl
    /(\d).*\1/
```

The match succeeds if a digit captured with `(\d)` is found again later in the string, possibly after any number of other characters (the back reference `\1` denotes the digit that was captured). The regex engine tries each digit in turn as the captured digit until it finds the same digit again later in the string or until all digits have been tried.

If a match is found, the current number is part of a gap. I keep a counter for the overall length of the gap, which is incremented in that case.

If no match is found, we have a number without repeating characters, and any possible gap ends. The largest gap encountered is registered in another variable, and the length of the current gap is reset to zero.

Example 5 demonstrates that we must only consider a gap for the largest result when we still find a higher number that has no repeating digits. In that example, the last non-repetitive number is 9876, with 124 repetitive numbers after that, including the final number 10000. This would be the largest gap, but it seems that it doesn't count as a 'gap' because it is only one-sided. The variable containing the largest gap should therefore only be updated once we encounter the next non-repetitive number. 

We are supposed to return the 'biggest jump', which is the size of the largest gap plus 1. This is true even if there was no gap found at all, because we still have 'jumps' of length 1 from number to number.

This is the complete solution: 

```perl
use v5.36;

sub largest_interval( $int ) {
    my ( $current_gap, $largest_gap ) = ( 0, 0 );
    for ( 1..$int) {
        if ( /(\d).*\1/ ) {
            ++$current_gap;
        }
        else {
            $largest_gap = $current_gap
                if $current_gap > $largest_gap;
            $current_gap = 0;
        }
    }
    # The 'biggest jump' is one larger than the largest gap.
    return $largest_gap + 1;
}
```

## Task 2: Minimum Genetic Mutation

> You are given start and end gene string along with gene bank.<br/>
> Write a script to return the minimum number of mutations required to mutate from start to end gene. Return -1 if there is no such mutation. A gene must be in a bank to make it a valid gene string.<br/>
> A gene string can be represented by an 8-character long string, with choices from ‘A’, ‘C’, ‘G’, and ‘T’.
>
> **Example 1**
>
> ```text
> Input: $start_gene = "AACCGGTT"
>        $end_gene   = "AACCGGTA"
>        @gene_bank  = ("AACCGCTA", "AAACGGTA")
> Output: -1
>
> To reach end gene, every intermediate gene and the end gene itself must exist in bank.
> Since "AACCGGTA" is missing from bank, it is impossible to complete the mutation sequence.
> ```
>
> **Example 2**
>
> ```text
> Input: $start_gene = "AACCGGTT"
>        $end_gene   = "AACCGGAA"
>        @gene_bank  = ("AACCGGTA", "AACCGGAA", "AACCGCTA", "AACCCTAA", "AACCGTAA")
> Output: 2
>
> Path 1 (2 steps): "AACCGGTT" => "AACCGGTA" => "AACCGGAA"
> Path 2 (3 steps): "AACCGGTT" => "AACCGGTA" => "AACCGTAA" => "AACCGGAA"
> ```
>
> **Example 3**
>
> ```text
> Input: $start_gene = "AAAAAAAA"
>        $end_gene   = "AAAAACCC"
>        @gene_bank  = ("CAAAAAAA", "CCAAAAAA", "AAAAAAAC")
> Output: -1
> ```
>
> **Example 4**
>
> ```text
> Input: $start_gene = "GAAAAAAA"
>        $end_gene   = "GCCCCCCC"
>        @gene_bank  = ("GCAAAAAA", "GCCAAAAA", "GCCCAAAA", "GCCCCAAA", "GCCCCCAA", "GCCCCCCA", "GCCCCCCC")
> Output: 7
>
> "GAAAAAAA" => "GCAAAAAA"
> "GCAAAAAA" => "GCCAAAAA"
> "GCCAAAAA" => "GCCCAAAA"
> "GCCCAAAA" => "GCCCCAAA"
> "GCCCCAAA" => "GCCCCCAA"
> "GCCCCCAA" => "GCCCCCCA"
> "GCCCCCCA" => "GCCCCCCC"
> ```
>
> **Example 5**
>
> ```text
> Input: $start_gene = "AACCGGTT"
>        $end_gene   = "AACCGGTT"
>        @gene_bank = ("AACCGGTA")
> Output: 0
>
> The current genetic sequence already matches the desired end gene.
> No mutations are necessary, so the result is 0.
> ```

My solution is based on a breadth-first search (BFS) algorithm
that finds the shortest path from the start gene to the end gene.

A BFS algorithm is based on initializing a queue with an entry containing the start node, and then repeatedly adding queue entries for all the direct neighbors of the nodes in the queue as they are processed, until the target node is reached.

As we are interested in the 'distance' between start gene and end gene, each queue entry carries its gene's distance from the start gene as an additional piece of information.

Finding the 'neighbors' of a gene in the gene pool is the most interesting part of the Perl implementation.

Perl's bitstring XOR operator `^.` compares two strings byte by byte and produces a string containing the bitwise XOR of corresponding bytes.
For identical characters, the result is a zero byte (`"\x00"`).
For different characters, the byte is non-zero.

The 'neighbors'
are genes from the gene pool that differ from the current gene in exactly one position. The number of non-zero bytes in the XOR result must therefore be 1.

To count the number of non-zero bytes, `split ""` can be used to divide the xor result into single characters, and `grep` in scalar context can do the counting. All of this can be done in a single Perl expression that fits on one line:

```perl
    ( scalar grep { $_ ne "\x00" } split "", $gene_1 ^. $gene_2 ) == 1
```

This is the complete solution:

```perl
use v5.36;

sub minimum_genetic_mutation( $start_gene, $end_gene, $gene_bank ) {
    my @q = ( [ $start_gene, 0 ] );
    my %visited = ( $start_gene => 1 );
    while ( @q ) {
        my ( $gene, $distance ) = ( shift @q )->@*;

        # End condition:
        return $distance
            if $gene eq $end_gene;

        # Mark all unvisited 'neighbors' as visited and add them to the queue.
        do {
            $visited{$_} = 1;
            push @q, [ $_, $distance + 1 ];
        } for grep {
            ! $visited{$_}
            && ( scalar grep { $_ ne "\x00" } split "", $gene ^. $_ ) == 1
        } $gene_bank->@*;
    }
    # No solution found.  
    return -1;
}
```

#### **Thank you for the challenge!**

#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 400 Task 2: Minimum Genetic Mutation
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub minimum_genetic_mutation( $start_gene, $end_gene, $gene_bank ) {

    # Using a breadth-first search algorithm to find the shortest path.
    # Queue entries contain the gene string and its distance from the
    # start gene.
    my @q = ( [ $start_gene, 0 ] );
    my %visited = ( $start_gene => 1 );
    while ( @q ) {
        my ( $gene, $distance ) = ( shift @q )->@*;

        # End condition:
        return $distance
            if $gene eq $end_gene;

        # Mark all unvisited 'neighbors' (genes from the gene pool that
        # differ from the current gene in exactly one position) as
        # visited and add them to the queue.
        # Using the 'bitstring' xor operator (^.) to get a string
        # containing the difference between two gene strings, then
        # split the result into characters and count how many of them
        # are non-null.
        # For single mutations ('neighbors'), that count must be 1.
        do {
            $visited{$_} = 1;
            push @q, [ $_, $distance + 1 ];
        } for grep {
            ! $visited{$_}
            && ( scalar grep { $_ ne "\x00" } split "", $gene ^. $_ ) == 1
        } $gene_bank->@*;
    }
    return -1;
}

use Test2::V0 qw( -no_srand );

my @tests = (
    [ "Example 1", ["AACCGGTT", "AACCGGTA", ["AACCGCTA", "AAACGGTA"]], -1 ],
    [ "Example 2",
        [
          "AACCGGTT",
          "AACCGGAA",
          ["AACCGGTA", "AACCGGAA", "AACCGCTA", "AACCCTAA", "AACCGTAA"],
        ],
        2 ],
    [ "Example 3",
        ["AAAAAAAA", "AAAAACCC", ["CAAAAAAA", "CCAAAAAA", "AAAAAAAC"]],
        -1 ],
    [ "Example 4",
        [
          "GAAAAAAA",
          "GCCCCCCC",
          [
            "GCAAAAAA",
            "GCCAAAAA",
            "GCCCAAAA",
            "GCCCCAAA",
            "GCCCCCAA",
            "GCCCCCCA",
            "GCCCCCCC",
          ],
        ],
        7 ],
    [ "Example 5", ["AACCGGTT", "AACCGGTT", ["AACCGGTA"]], 0 ],
);

is minimum_genetic_mutation( $_->[1]->@* ), $_->[2], $_->[0]
    for @tests;

done_testing;

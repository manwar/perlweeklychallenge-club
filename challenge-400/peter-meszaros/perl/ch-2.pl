#!/usr/bin/env perl
#
=head1 Task 2: Minimum Genetic Mutation

Submitted by: Mohammad Sajid Anwar

You are given start and end gene string along with gene bank.  Write a script
to return the minimum number of mutations required to mutate from start to end
gene. Return -1 if there is no such mutation. A gene must be in a bank to make
it a valid gene string.  A gene string can be represented by an 8-character
long string, with choices from 'A', 'C', 'G', and 'T'.

=head2 Example 1

    Input: $start_gene = "AACCGGTT"
           $end_gene   = "AACCGGTA"
           @gene_bank  = ("AACCGCTA", "AAACGGTA")
    Output: -1

    To reach end gene, every intermediate gene and the end gene itself must exist in bank.
    Since "AACCGGTA" is missing from bank, it is impossible to complete the mutation sequence.

=head2 Example 2

    Input: $start_gene = "AACCGGTT"
           $end_gene   = "AACCGGAA"
           @gene_bank  = ("AACCGGTA", "AACCGGAA", "AACCGCTA", "AACCCTAA", "AACCGTAA")
    Output: 2

    Path 1 (2 steps): "AACCGGTT" => "AACCGGTA" => "AACCGGAA"
    Path 2 (3 steps): "AACCGGTT" => "AACCGGTA" => "AACCGTAA" => "AACCGGAA"

=head2 Example 3

    Input: $start_gene = "AAAAAAAA"
           $end_gene   = "AAAAACCC"
           @gene_bank  = ("CAAAAAAA", "CCAAAAAA", "AAAAAAAC")
    Output: -1

=head2 Example 4

    Input: $start_gene = "GAAAAAAA"
           $end_gene   = "GCCCCCCC"
           @gene_bank  = ("GCAAAAAA", "GCCAAAAA", "GCCCAAAA", "GCCCCAAA", "GCCCCCAA", "GCCCCCCA", "GCCCCCCC")
    Output: 7

    "GAAAAAAA" => "GCAAAAAA"
    "GCAAAAAA" => "GCCAAAAA"
    "GCCAAAAA" => "GCCCAAAA"
    "GCCCAAAA" => "GCCCCAAA"
    "GCCCCAAA" => "GCCCCCAA"
    "GCCCCCAA" => "GCCCCCCA"
    "GCCCCCCA" => "GCCCCCCC"

=head2 Example 5

    Input: $start_gene = "AACCGGTT"
           $end_gene   = "AACCGGTT"
           @gene_bank = ("AACCGGTA")
    Output: 0

    The current genetic sequence already matches the desired end gene.
    No mutations are necessary, so the result is 0.

=cut

use strict;
use warnings;
use v5.44.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my @cases = (
    {start_gene => "AACCGGTT",
     end_gene   => "AACCGGTA",
     gene_bank  => ["AACCGCTA", "AAACGGTA"],
     out        => -1,
     name => 'Example 1'},
    {start_gene => "AACCGGTT",
     end_gene   => "AACCGGAA",
     gene_bank  => ["AACCGGTA", "AACCGGAA", "AACCGCTA", "AACCCTAA", "AACCGTAA"],
     out        => 2,
     name => 'Example 2'},
    {start_gene => "AAAAAAAA",
     end_gene   => "AAAAACCC",
     gene_bank  => ["CAAAAAAA", "CCAAAAAA", "AAAAAAAC"],
     out        => -1,
     name => 'Example 3'},
    {start_gene => "GAAAAAAA",
     end_gene   => "GCCCCCCC",
     gene_bank  => ["GCAAAAAA", "GCCAAAAA", "GCCCAAAA", "GCCCCAAA", "GCCCCCAA", "GCCCCCCA", "GCCCCCCC"],
     out        => 7,
     name => 'Example 4'},
    {start_gene => "AACCGGTT",
     end_gene   => "AACCGGTT",
     gene_bank  => ["AACCGGTA"],
     out        => 0,
     name => 'Example 5'},
);

sub minimum_genetic_mutation
{
    my $start_gene = shift;
    my $end_gene   = shift;
    my $gene_bank  = shift;

    return 0 if $start_gene eq $end_gene;

    my $exists = 0;
    for my $gene (@$gene_bank) {
        if ($gene eq $end_gene) {
            $exists = 1;
            last;
        }
    }
    return -1 unless $exists;

    my $mutations = 0;
    for my $i (0 .. length($start_gene)) {
        ++$mutations if substr($start_gene, $i, 1) ne substr($end_gene, $i, 1);
    }
    return $mutations;
}

for my $case (@cases) {
    my $got = minimum_genetic_mutation($case->{start_gene}, $case->{end_gene}, $case->{gene_bank});
    is($got, $case->{out}, $case->{name});
}
done_testing();

exit 0;

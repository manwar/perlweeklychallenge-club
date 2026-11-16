#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given start and end gene string along with gene bank.

Write a script to return the minimum number of mutations required to mutate from start to end gene. Return -1 if there is no such mutation. A gene must be in a bank to make it a valid gene string.

    A gene string can be represented by an 8-character long string, with choices from 'A', 'C', 'G', and 'T'.

Example 1

Input: $start_gene = "AACCGGTT"
       $end_gene   = "AACCGGTA"
       @gene_bank  = ("AACCGCTA", "AAACGGTA")
Output: -1

To reach end gene, every intermediate gene and the end gene itself must exist in bank.
Since "AACCGGTA" is missing from bank, it is impossible to complete the mutation sequence.

Example 2

Input: $start_gene = "AACCGGTT"
       $end_gene   = "AACCGGAA"
       @gene_bank  = ("AACCGGTA", "AACCGGAA", "AACCGCTA", "AACCCTAA", "AACCGTAA")
Output: 2

Path 1 (2 steps): "AACCGGTT" => "AACCGGTA" => "AACCGGAA"
Path 2 (3 steps): "AACCGGTT" => "AACCGGTA" => "AACCGTAA" => "AACCGGAA"

Example 3

Input: $start_gene = "AAAAAAAA"
       $end_gene   = "AAAAACCC"
       @gene_bank  = ("CAAAAAAA", "CCAAAAAA", "AAAAAAAC")
Output: -1

Example 4

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

Example 5

Input: $start_gene = "AACCGGTT"
       $end_gene   = "AACCGGTT"
       @gene_bank = ("AACCGGTA")
Output: 0

The current genetic sequence already matches the desired end gene.
No mutations are necessary, so the result is 0.

=cut



use Test2::V0 -no_srand => 1;

is(minimal_mutation("AACCGGTT", "AACCGGTA", ["AACCGCTA", "AAACGGTA"]), -1, 'Example 1');
is(minimal_mutation("AACCGGTT", "AACCGGAA", ["AACCGGTA", "AACCGGAA", "AACCGCTA", "AACCCTAA", "AACCGTAA"]), 2, 'Example 2');
is(minimal_mutation("AAAAAAAA", "AAAAACCC", ["CAAAAAAA", "CCAAAAAA", "AAAAAAAC"]), -1, 'Example 3');
is(minimal_mutation("GAAAAAAA", "GCCCCCCC", ["GCAAAAAA", "GCCAAAAA", "GCCCAAAA", "GCCCCAAA", "GCCCCCAA", "GCCCCCCA", "GCCCCCCC"]), 7, 'Example 4');
is(minimal_mutation("AACCGGTT", "AACCGGTT", ["AACCGGTT"]), 0, 'Example 5');
done_testing();

sub minimal_mutation
{
     my ($start, $end, $bank_aref) = @_;
     return 0 if $start eq $end;
     my %genes = map { $_ => undef } @$bank_aref;
     return -1 if not exists $genes{$end};
     my @stack = [$start, 0];
     while ( @stack )
     {
          my $this_aref = shift @stack;
          my $this_gene = $this_aref->[0];
          my $step_sofar = $this_aref->[1];
          for my $idx ( 0 .. length($this_gene) - 1)
          {
               for my $locus ( 'A', 'C', 'G', 'T' )
               {
                    next if substr($this_gene, $idx, 1) eq $locus;

                    my $next_gene = $this_gene;
                    substr($next_gene, $idx, 1) = $locus;
                    next if not exists $genes{$next_gene};
                    if ( $next_gene eq $end )
                    {
                         return $step_sofar + 1;
                    }
                    else
                    {
                         push @stack, [$next_gene, $step_sofar + 1];
                    }
               }
          }
     }
     return -1;
}

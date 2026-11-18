#! /usr/bin/env raku

=begin pod
=TITLE PWC
=head2 Challenge 400 Task 2

Submitted by: Mohammad Sajid Anwar
=head2 Minimum Genetic Mutation

You are given start and end gene string along with gene bank.

Write a script to return the minimum number of mutations required to mutate from start to
end gene. Return -1 if there is no such mutation. A gene must be in a bank to make it a
valid gene string.

A gene string can be represented by an 8-character long string, with choices from ‘A’,
‘C’, ‘G’, and ‘T’.

=head3 Example 1:

Input: $start_gene = "AACCGGTT"
       $end_gene   = "AACCGGTA"
       @gene_bank  = ("AACCGCTA", "AAACGGTA")
Output: -1

To reach end gene, every intermediate gene and the end gene itself must exist in bank.
Since "AACCGGTA" is missing from bank, it is impossible to complete the mutation sequence.

=head3 Example 2:

Input: $start_gene = "AACCGGTT"
       $end_gene   = "AACCGGAA"
       @gene_bank  = ("AACCGGTA", "AACCGGAA", "AACCGCTA", "AACCCTAA", "AACCGTAA")
Output: 2

Path 1 (2 steps): "AACCGGTT" => "AACCGGTA" => "AACCGGAA"
Path 2 (3 steps): "AACCGGTT" => "AACCGGTA" => "AACCGTAA" => "AACCGGAA"

=head3 Example 3:

Input: $start_gene = "AAAAAAAA"
       $end_gene   = "AAAAACCC"
       @gene_bank  = ("CAAAAAAA", "CCAAAAAA", "AAAAAAAC")
Output: -1

=head3 Example 4:

Input: $start_gene = "GAAAAAAA"
       $end_gene   = "GCCCCCCC"
       @gene_bank  = ("GCAAAAAA", "GCCAAAAA", "GCCCAAAA", "GCCCCAAA", "GCCCCCAA",
                      "GCCCCCCA", "GCCCCCCC")
Output: 7

"GAAAAAAA" => "GCAAAAAA"
"GCAAAAAA" => "GCCAAAAA"
"GCCAAAAA" => "GCCCAAAA"
"GCCCAAAA" => "GCCCCAAA"
"GCCCCAAA" => "GCCCCCAA"
"GCCCCCAA" => "GCCCCCCA"
"GCCCCCCA" => "GCCCCCCC"

=head3 Example 5:

Input: $start_gene = "AACCGGTT"
       $end_gene   = "AACCGGTT"
       @gene_bank = ("AACCGGTA")
Output: 0

The current genetic sequence already matches the desired end gene.
No mutations are necessary, so the result is 0.

=end pod

my constant GENE_LENGTH = 8;

subset Gene of Str where / ^ <[ACGT]> ** {GENE_LENGTH} $ /;
subset GeneBank of Positional where .all ~~ Gene;

multi minimum-genetic-mutation(Gene $start, Gene $end, @bank where GeneBank --> Int) {
    return 0 if $start eq $end;
    return -1 if $end !(elem) @bank;
    my %g = build-graph(flat(@bank, [$start]).unique);
    my $fewest-mutations = Inf;
    my @path;
    my %color = @bank Z=> "WHITE" xx @bank.elems; # mark all as unexplored

    sub dfs-visit(Gene $u) {
        @path.push($u);
        %color{$u} = "GRAY"; # explored on this path
        if $u eq $end {
            # We've found a path to the end!  The number of mutations is the length
            # of the path minus one:  a -> b -> c (two mutations).
            $fewest-mutations = min(@path.elems - 1, $fewest-mutations);
        } else {
            for @(%g{$u}) -> $v {
                dfs-visit($v) if %color{$v} eq "WHITE";
            }
        }
        %color{$u} = "WHITE"; # reset and backtrack
        @path.pop();
    }
    dfs-visit($start);
    $fewest-mutations == Inf ?? -1 !! $fewest-mutations;
}

multi minimum-genetic-mutation($start, $end, @bank) {
    die "Unexpected input {$start}, {$end}, {@bank}";
}

sub is-one-mutation-different(Gene $left, Gene $right) {
    ($left.comb Z!eq $right.comb).grep({ .so }).elems == 1;
}

sub build-graph(@bank where GeneBank --> Map) {
    my %g = @bank Z=> [] xx @bank.elems;
    for @bank -> $i {
        for @bank -> $j {
            next if $i eq $j; # avoid edges to self
            if is-one-mutation-different($i, $j) {
                %g{$i}.push($j) unless $j (elem) %g{$i};
                %g{$j}.push($i) unless $i (elem) %g{$j};
            }
        }
    }
    %g;
}

#| Find the minimum mutations required to get from START to END using genes in BANK
multi MAIN(Str:D $start, Str:D $end, *@bank) {
    say minimum-genetic-mutation($start, $end, @bank);
}

#| run tests
multi MAIN(Bool:D :$test) {
    use Test;

    my @tests;
    @tests.push(%( input => ("AACCGGTT",
                             "AACCGGTA",
                             ("AACCGCTA", "AAACGGTA")),
                   output => -1));
    @tests.push(%( input => ("AACCGGTT",
                             "AACCGGAA",
                             ("AACCGGTA", "AACCGGAA", "AACCGCTA", "AACCCTAA", "AACCGTAA")),
                   output => 2));
    @tests.push(%( input => ("AAAAAAAA",
                             "AAAAACCC",
                             ("CAAAAAAA", "CCAAAAAA", "AAAAAAAC")),
                   output => -1));
    @tests.push(%( input => ("GAAAAAAA",
                             "GCCCCCCC",
                             ("GCAAAAAA", "GCCAAAAA", "GCCCAAAA", "GCCCCAAA", "GCCCCCAA",
                              "GCCCCCCA", "GCCCCCCC")),
                   output => 7));
    @tests.push(%( input => ("AACCGGTT",
                             "AACCGGTT",
                             ("AACCGGTA",)),
                   output => 0));
    @tests.push(%( input => ("AACCGGTT",
                             "TTCCGGTT",
                             ("AACCGGTT", "TTCCGGTT")),
                   output => -1));
    @tests.push(%( input => ("AACCGGTT",
                             "TTCCGGTT",
                             List.new),
                   output => -1));
    @tests.push(%( input => ("AACCGGTT",
                             "TTCCGGTT",
                             ("TTCCGGTT", "AATTTTTT")),
                   output => -1));
    @tests.push(%( input => ("AACCGGTT",
                             "AACCGGAA",
                             ("AACCGGTA", "AACCGGAA", "AACCGGTT", "AACCGGAA")),
                   output => 2));
    @tests.push(%( input => ("AACCGGTT",
                             "AACCGGTA",
                             ("AACCGGTA", "AACCGGAA", "AACCGGTT", "AACCGGAA")),
                   output => 1));
    @tests.push(%( input => ("AACCGGTT",
                             "AACCGGTA",
                             List.new),
                   output => -1));

    my @should-throw;
    @should-throw.push(%( input => ("", "", []) ));
    @should-throw.push(%( input => ("A" x 8, "A" x 7, ["A" x 8]) ));
    @should-throw.push(%( input => ("A" x 7, "A" x 8, ["A" x 8]) ));
    @should-throw.push(%( input => ("A" x 8, "A" x 8, ["A" x 7]) ));
    @should-throw.push(%( input => ("AAAAAAAQ", "A" x 8, ["A" x 8]) ));

    plan @tests + @should-throw + 3;
    for @tests {
        is minimum-genetic-mutation(|.<input>), .<output>, "{ .<input>.raku }";
    }
    for @should-throw {
        throws-like { minimum-genetic-mutation(|.<input>) },
                      Exception,
                      "dies on { .<input>.raku }", message => /Unexpected/;
    }
    my $proc = run($*EXECUTABLE, $?FILE, 'AACCGGTT', 'AACCGGTT', 'AACCGGTT', :out, :err);
    is $proc.out.slurp(:close).trim, '0', "cli produces result on stdout";
    is $proc.err.slurp(:close), '', "cli produces nothing on stderr";
    is $proc.exitcode, 0, "cli exits cleanly";
}

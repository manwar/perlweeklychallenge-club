#!/usr/bin/perl
use warnings;
use strict;
use feature 'bitwise';
use experimental qw( signatures );

sub minimum_genetic_mutation($start_gene, $end_gene, $gene_bank) {
    return -1 if $start_gene ne $end_gene
              && ! grep $end_gene eq $_, @$gene_bank;

    my %agenda = ($start_gene => -1);
    my %visited;
    while (keys %agenda) {
        for my $k (keys %agenda) {
            my $steps = delete $agenda{$k};
            $visited{$k} = $steps + 1;
            for my $g (@$gene_bank) {
                next if exists $visited{$g};

                my $xor = $g ^. $k;
                $agenda{$g} = $steps + 1
                    if (length($g) - 1) == $xor =~ tr/\x00//;
            }
        }
    }
    return $visited{$end_gene} // -1
}

use Test::More tests => 5 + 1;

is minimum_genetic_mutation('AACCGGTT', 'AACCGGTA', ['AACCGCTA', 'AAACGGTA']),
    -1,
    'Example 1';

is minimum_genetic_mutation('AACCGGTT', 'AACCGGAA',
                            ['AACCGGTA', 'AACCGGAA', 'AACCGCTA', 'AACCCTAA',
                             'AACCGTAA']),
    2,
    'Example 2';

is minimum_genetic_mutation('AAAAAAAA', 'AAAAACCC',
                            ['CAAAAAAA', 'CCAAAAAA', 'AAAAAAAC']),
    -1,
    'Example 3';

is minimum_genetic_mutation('GAAAAAAA', 'GCCCCCCC',
                            ['GCAAAAAA', 'GCCAAAAA', 'GCCCAAAA', 'GCCCCAAA',
                             'GCCCCCAA', 'GCCCCCCA', 'GCCCCCCC']),
    7,
    'Example 4';

is minimum_genetic_mutation('AACCGGTT', 'AACCGGTT', ['AACCGGTA']),
    0,
    'Example 5';

is minimum_genetic_mutation('AAAAAAAA', 'CCCCCCCC', ['AAAAAAAA', 'CCCCCCCC']),
    -1,
    'Both genes exist but no path between them';

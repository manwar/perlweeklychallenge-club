#! /usr/bin/raku

sub minimumgeneticmutation($from, $to, @bank) {
    if ($from eq $to) {
        return 0;
    }
    my %paths;
    my @nodes = @bank.clone();
    @nodes.push($from);
    for 0 .. @nodes.end - 2 -> $a {
        for $a + 1 .. @nodes.end -> $b {
            my $delta = 0;
            for 0 .. @nodes[$a].chars - 1 -> $c {
                if (substr(@nodes[$a], $c, 1) ne substr(@nodes[$b], $c, 1)) {
                    $delta += 1;
                    if ($delta > 1) {
                        last;
                    }
                }
            }
            if ($delta == 1) {
                %paths{@nodes[$a]} ||= [];
                %paths{@nodes[$a]}.push(@nodes[$b]);
                %paths{@nodes[$b]} ||= [];
                %paths{@nodes[$b]}.push(@nodes[$a]);
            }
        }
    }
    my %seen = SetHash.new;
    my @queue;
    @queue.push({gene => $from, depth => 0});
    while (@queue.elems > 0) {
        my %h = @queue.shift;
        my $gene = %h{"gene"};
        my $depth = %h{"depth"};
        if ($gene eq $to) {
            return $depth;
        }
        if (%paths{$gene}:exists) {
            my %sseen = %seen.clone;
            my $d = $depth + 1;
            for %paths{$gene}.split(" ") -> $g {
                unless (%seen{$g}:exists) {
                    @queue.push({gene => $g, depth => $d});
                    %sseen{$g} = 1;
                }
            }
            %seen = %sseen;
        }
    }
    -1
}

use Test;

plan 5;

is(minimumgeneticmutation('AACCGGTT', 'AACCGGTA', ['AACCGCTA', 'AAACGGTA']), -1, 'example 1');
is(minimumgeneticmutation('AACCGGTT', 'AACCGGAA', ['AACCGGTA', 'AACCGGAA', 'AACCGCTA', 'AACCCTAA', 'AACCGTAA']), 2, 'example 2');
is(minimumgeneticmutation('AAAAAAAA', 'AAAAACCC', ['CAAAAAAA', 'CCAAAAAA', 'AAAAAAAC']), -1, 'example 3');
is(minimumgeneticmutation('GAAAAAAA', 'GCCCCCCC', ['GCAAAAAA', 'GCCAAAAA', 'GCCCAAAA', 'GCCCCAAA', 'GCCCCCAA', 'GCCCCCCA', 'GCCCCCCC']), 7, 'example 4');
is(minimumgeneticmutation('AACCGGTT', 'AACCGGTT', ['AACCGGTA']), 0, 'example 5');

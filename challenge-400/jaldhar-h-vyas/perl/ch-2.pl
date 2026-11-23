#!/usr/bin/perl
use 5.40.1;
use warnings;

my ($start_gene, $end_gene, @gene_bank) = @ARGV;

if ($start_gene eq $end_gene) {
    say 0;
    exit;
}

my %bank = map { $_ => true } @gene_bank;

unless (exists $bank{$end_gene}) {
    say -1;
    exit;
}

my %distance;
$distance{$start_gene} = 0;
my @queue = $start_gene;
my $head = 0;

while ($head < scalar @queue) {
    my $currentGene = $queue[$head++];
    my @characters = split //, $currentGene;

    for my $position (0 .. scalar @characters - 1) {
        my $originalBase = $characters[$position];

        for my $nextBase (qw/ A C G T/) {
            if ($nextBase eq $originalBase) {
                next;
            }

            $characters[$position] = $nextBase;
            my $nextGene = join q{}, @characters;
            $characters[$position] = $originalBase;

            unless (exists $bank{$nextGene}) {
                next;
            }

            if (exists $distance{$nextGene}) {
                next;
            }

            $distance{$nextGene} = $distance{$currentGene} + 1;

            if ($nextGene eq $end_gene) {
                say $distance{$nextGene};
                exit;
            }

            push @queue, $nextGene;
        }
    }
}

say -1;

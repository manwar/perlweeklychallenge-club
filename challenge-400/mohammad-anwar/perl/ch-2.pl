#!/usr/bin/env perl

use v5.38;
use Test2::V0;

my @examples = (
    {
        in  => ["AACCGGTT","AACCGGTA",
                "AACCGCTA","AAACGGTA"],
        out => -1,
    },
    {
        in  => ["AACCGGTT","AACCGGAA",
                "AACCGGTA","AACCGGAA","AACCGCTA","AACCCTAA","AACCGTAA"],
        out => 2,
    },
    {
        in  => ["AAAAAAAA","AAAAACCC",
                "CAAAAAAA","CCAAAAAA","AAAAAAAC"],
        out => -1,
    },
    {
        in  => ["GAAAAAAA","GCCCCCCC",
                "GCAAAAAA","GCCAAAAA","GCCCAAAA","GCCCCAAA","GCCCCCAA","GCCCCCCA","GCCCCCCC"],
        out => 7,
    },
    {
        in  => ["AACCGGTT","AACCGGTT",
                "AACCGGTA"],
        out => 0,
    },
);

is min_mutation(@{$_->{in}}), $_->{out} foreach @examples;

done_testing;

sub min_mutation($start, $end, @bank) {
    return 0 if $start eq $end;

    my %bank = map { $_ => 1 } @bank;
    return -1 unless $bank{$end};

    my @queue   = ([$start, 0]);
    my %visited = ($start => 1);

    while (@queue) {
        my ($curr, $steps) = @{ shift @queue };
        return $steps if $curr eq $end;

        for my $i (0 .. length($curr) - 1) {
            my $orig = substr($curr, $i, 1);
            for my $c (qw(A C G T)) {
                next if $c eq $orig;
                my $next = $curr;
                substr($next, $i, 1) = $c;

                if ($bank{$next} && !$visited{$next}++) {
                    push @queue, [$next, $steps + 1];
                }
            }
        }
    }
    return -1;
}

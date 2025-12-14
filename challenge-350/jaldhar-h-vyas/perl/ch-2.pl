#!/usr/bin/perl
use 5.038;
use warnings;

sub permute(@arr) {
    my @permutations;

    my @idx = keys @arr;
    while ( push @permutations, [@arr[@idx]] ) {
        my $p = scalar @idx - 1;
        while ($idx[$p-1] >= $idx[$p]) {
            --$p;
        }
        my $q = $p;
        if (!$q) {
            last;
        }
        push @idx, reverse splice @idx, $p;
        while ($idx[$p-1] > $idx[$q]) {
            ++$q;
        }
        @idx[$p-1,$q]=@idx[$q,$p-1];
    }

    return @permutations;
}

sub unique(@list) {
    my %elems;
    for (@list) {
        $elems{$_}++;
    }

    return (keys %elems);
}

my ($from, $to, $count) = @ARGV;
my $total = 0;

for my $i ($from .. $to) {
    my $shufflePairs = 0;
    my @digits = split //, $i;

    if (@digits != unique(@digits)) {
        next;
    }

    for my $j (map {  join q{}, @{$_} } permute (@digits)) {
        if ($j <= $i) {
            next;
        }

        if ($j % $i == 0) {
            $shufflePairs++;
        }

        if ($shufflePairs == $count) {
            $total++;
            last;
        }
    }
}

say $total;

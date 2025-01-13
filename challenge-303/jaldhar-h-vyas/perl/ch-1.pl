#!/usr/bin/perl
use v5.38;


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

    return keys %elems;
}

my @ints = @ARGV;
my @permutations = permute @ints;

say  q{(}, 
    (join q{, }, 
        sort { $a <=> $b } 
        unique(
            grep { length $_ == 3 && $_ % 2 == 0 } 
            map { int join q{}, @{$_}[0..2] } 
            @permutations
        )
    ), q{)};


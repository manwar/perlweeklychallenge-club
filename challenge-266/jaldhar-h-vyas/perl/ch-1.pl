#!/usr/bin/perl
use v5.38;

sub makeUniqueBag(@array) {
    my %bag;
    for my $c (@array) {
        $bag{$c}++;
    }

    return grep { $bag{$_} == 1 } keys %bag;
}

sub symmetricDifference($set1, $set2) {
    my @all = (@{$set1}, @{$set2});
    return makeUniqueBag(@all);
}

my @words1 = makeUniqueBag(split /\s+/, @ARGV[0]);
my @words2 = makeUniqueBag(split /\s+/, @ARGV[1]);

say q{(}, ((join q{, }, map { "'$_'" } symmetricDifference(\@words1, \@words2)) || "''"), q{)};

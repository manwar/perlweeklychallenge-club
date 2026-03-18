#!/usr/bin/env perl

# Perl Weekly Challenge 260 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-260/

use Modern::Perl;
use List::Util 'uniq';
use List::MoreUtils 'onlyidx';

say dictionary_rank(shift // "");

sub dictionary_rank {
    my($word) = @_;
    return
        1+(onlyidx {$_ eq $word}
           sort {$a cmp $b}
           uniq
           map {join '', @$_}
           permutations(split //, $word))[0];
}

sub permutations {
    my(@items) = @_;

    # Base case: no items - one empty permutation
    return [] if @items == 0;

    my @result;

    for my $i (0 .. $#items) {
        my $item = $items[$i];

        # Remaining items after removing index $i
        my @rest = @items[0 .. $i-1, $i+1 .. $#items];

        # Recursively permute the rest
        for my $perm_ref (permutations(@rest)) {
            push @result, [$item, @$perm_ref];
        }
    }

    return @result;
}

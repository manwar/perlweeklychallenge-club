#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::Util qw{ sum };

sub similar_words(@words) {
    my %seen;
    for my $word (@words) {
        my $canonical = join("", sort split //, $word)
                      =~ s/(.)\1+/$1/gr;
        push @{ $seen{$canonical} }, $word;
    }
    return sum(map pairs(scalar @{ $seen{$_} }), keys %seen)
}

sub pairs($size) {
    return $size * ($size - 1) / 2
}

use Test::More tests => 3 + 4;

is similar_words('aba', 'aabb', 'abcd', 'bac', 'aabc'), 2, 'Example 1';
is similar_words('aabb', 'ab', 'ba'), 3, 'Example 2';
is similar_words('nba', 'cba', 'dba'), 0, 'Example 3';

is similar_words('abc', 'bca', 'cab'), 3, 'Three in one group';
is similar_words('ab', 'ab'), 1, 'Repeated words';
is similar_words('abc', 'bac', 'cba', 'cab'), 6, 'Four';
is similar_words('abc', 'bac', 'cba', 'cab', 'acb'), 10, 'Five';

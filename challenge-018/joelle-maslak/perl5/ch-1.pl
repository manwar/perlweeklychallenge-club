#!/usr/bin/env perl
use v5.22;
use strict;
use warnings;

# Turn on method signatures
use feature 'signatures';
no warnings 'experimental::signatures';

use autodie;
use List::Util qw(max);

sub main() {
    die "Usage: $0 <m> .. <n>" if @ARGV < 2;

    my @matchwords = intersection( map { substrings($_) } @ARGV );
    if ( scalar(@matchwords) ) {
        my $max = max map { length($_) } @matchwords;
        my (@longwords) = grep { length($_) == $max } @matchwords;
        say "Max length: $max; Substrings: " . join( " ", @longwords );
    } else {
        say "No substrings in common";
    }

    return;
}

sub substrings($word) {
    my %ret;

    for ( my $i = 0; $i < length($word); $i++ ) {
        for ( my $j = 1; $j < ( length($word) + 1 - $i ); $j++ ) {
            $ret{ substr( $word, $i, $j ) } = 1;
        }
    }

    return [ keys %ret ];
}

sub intersection ( $first, $second, @sets ) {
    my %hash1 = map { $_ => 1 } $first->@*;
    my %hash2 = map { $_ => 1 } $second->@*;

    my @common;
    for my $k ( keys %hash1 ) {
        push @common, $k if ( exists $hash2{$k} );
    }

    if ( scalar(@sets) ) {
        return intersection( \@common, @sets );
    } else {
        return @common;
    }
}

main();

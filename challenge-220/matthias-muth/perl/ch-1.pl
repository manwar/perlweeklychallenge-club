#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 220 Task 1: Common Characters
#
#       Perl solution by Matthias Muth.
#

use strict;
use warnings;
use feature 'say';

use lib '.';
use TestExtractor;

use List::Util qw( reduce any );
use Data::Dump qw( pp );

sub common_characters_reduce {
    my ( @words ) = map lc( $_ ), @_;
    my $result_set =
        reduce { [ grep( $b =~ /$_/, @$a ) ] }
            [ $words[0] =~ /./g ], @words[1..$#words];
    # return sort @$result_set;
}

sub common_characters_for_words {
    my ( @words ) = map lc( $_ ), @_;
    my @results = split "", $words[0];
    for my $word ( @words[1..$#words] ) {
        @results = grep $word =~ /$_/, @results;
    }
    return sort @results;
}

sub common_characters_for_index {
    my ( @words ) = map lc( $_ ), @_;
    my @results = split "", $words[0];
    for my $i ( 1..$#words ) {
        @results = grep $words[$i] =~ /$_/, @results;
    }
    return sort @results;
}

sub common_characters_while_shift {
    my ( @words ) = map lc( $_ ), @_;
    my @results = split "", shift @words;
    while ( my $word = shift @words ) {
        @results = grep { $word =~ /$_/ } @results;
    }
    return sort @results;
}

sub common_characters {
    common_characters_for_words( @_ );
}

sub benchmark {
    use Benchmark qw( timethese cmpthese );

    my @bench_data = ( "love", "live", "leave", "Perl", "Rust", "Raku" );

    cmpthese( 0, {
        # reduce_chars => sub { common_characters_reduce_chars( @bench_data ); },
        # reduce       => sub { common_characters_reduce( @bench_data ); },
        # for_index    => sub { common_characters_for_index( @bench_data ); },
        for_words    => sub { common_characters_for_words( @bench_data ); },
        selected     => sub { common_characters( @bench_data ); },
        # while_shift  => sub { common_characters_while_shift( @bench_data ); },
    } );
}

run_tests;

benchmark;

1;
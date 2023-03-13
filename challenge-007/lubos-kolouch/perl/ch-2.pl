#!/usr/bin/perl
use strict;
use warnings;

sub find_shortest_ladder {
    my ( $word1, $word2, @wordlist ) = @_;

    # Check if input words are valid
    my $wordlen = length($word1);
    my %wordset = map { $_ => 1 } @wordlist;
    unless ( $wordset{$word1} && $wordset{$word2} && length($word2) == $wordlen ) {
        return ();
    }

    # Use breadth-first search to find shortest ladder
    my @queue   = [ $word1, [$word1] ];
    my %visited = ( $word1 => 1 );
    while (@queue) {
        my ( $word, $path ) = @{ shift(@queue) };
        for my $i ( 0 .. $wordlen - 1 ) {
            for my $char ( 'a' .. 'z' ) {
                my $newword = substr( $word, 0, $i ) . $char . substr( $word, $i + 1 );
                if ( $newword eq $word2 ) {
                    return [ @$path, $word2 ];
                }
                if ( $wordset{$newword} && !$visited{$newword} ) {
                    push @queue, [ $newword, [ @$path, $newword ] ];
                    $visited{$newword} = 1;
                }
            }
        }
    }

    # If no ladder is found, return empty list
    return ();
}

# Test cases
my @wordlist = ( 'cold', 'cord', 'core', 'care', 'card', 'ward', 'warm', 'worm' );
my $ladder   = find_shortest_ladder( 'cold', 'warm', @wordlist );
my $expected = [ 'cold', 'cord', 'card', 'ward', 'warm' ];
die "Test case 1 failed" unless ( join( ',', @$ladder ) eq join( ',', @$expected ) );

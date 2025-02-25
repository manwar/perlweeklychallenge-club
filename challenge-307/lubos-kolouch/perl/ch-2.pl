#!/usr/bin/perl
use strict;
use warnings;
use Test::More tests => 4;

=head1 NAME

find_anagrams.pl - Drop consecutive anagrams and return the count of the final list

=head1 DESCRIPTION

This script applies the rule: whenever two consecutive words are anagrams,
drop the first word and keep the second. This is repeated until no such pair exists.
According to this rule, any contiguous block of anagrams will collapse to a single word.

=head2 sorted_word

  my $sorted = sorted_word($word);

Returns the characters of the word sorted in increasing order.

=head2 find_anagrams

  my $final_count = find_anagrams(\@words);

Processes the list iteratively and returns the count of words remaining.
=cut

sub sorted_word {
    my ($word) = @_;
    return join '', sort split //, $word;
}

sub find_anagrams {
    my ($words_ref) = @_;
    my @list        = @$words_ref;
    my $changed     = 1;
    while ($changed) {
        $changed = 0;
        for ( my $i = 0 ; $i < @list - 1 ; $i++ ) {
            if ( sorted_word( $list[$i] ) eq sorted_word( $list[ $i + 1 ] ) ) {

                # drop the first word of the pair
                splice( @list, $i, 1 );
                $changed = 1;
                last;    # restart scanning from beginning
            }
        }
    }
    return scalar @list;
}

# Unit tests for the iterative (fully applied) rule:
is( find_anagrams( [ "acca", "dog", "god", "perl", "repl" ] ),
    3, 'Test example 1' );
is( find_anagrams( [ "abba", "baba", "aabb", "ab", "ab" ] ),
    2, 'Test example 2' );
is( find_anagrams( [ "abc", "cab", "bca" ] ), 1, 'Test simple chain' );
is( find_anagrams( [ "word", "drow", "word", "word" ] ),
    1, 'Test repeating words' );

done_testing();

#!/usr/bin/env perl

use v5.24;
use strict;
use warnings;
use feature qw(say state signatures);
no warnings "experimental::signatures";
use List::Util qw(all uniqstr first);
use JSON;
use Tree::Trie;
use Graph;

# Challenge 2a: what's the longest word you can spell by traversing US states,
# taking the initial or initials of the states as you pass through them, without
# revisiting any states?

=over

=item get_paths( $graph, $trie, $vertex, $data, %seen ) : @paths_strings

Takes a Graph, Tree::Trie, vertex (string) in $graph, a reference to a hash of
US state data which must include a key called "initials", and a hash of vertex
=> index key-value pairs. The hash is not a reference, so modifications to the
hash in nested calls to this function will not modify the data in the parent
call.

Returns a list of key-value pairs which can be coerced into a hash.
The key is the path of states taken, and the value is the string produced.

=back

=cut
sub get_paths ( $graph, $trie, $vertex, $data, %seen ) {
    $seen{$vertex} = 1 + ( keys %seen );

    my $string_so_far = fc(
        join( "",
            map { $data->{$_}->{initials} }
                ( sort { $seen{$a} <=> $seen{$b} } keys %seen ) )
    );

    # Filter out successive vertexes which have already been visited
    # and which would not produce a word in the trie
    my @pot_successors = grep {
        !( exists $seen{$_} )
            && $trie->lookup(
            $string_so_far . fc( $data->{$_}->{initials} ) );
    } sort { $a cmp $b } $graph->neighbors($vertex);

    # Base case: no more successors, done with this path
    if ( !@pot_successors ) {
        return ( join( "->", sort { $seen{$a} <=> $seen{$b} } keys %seen ),
            $string_so_far );
    }
    else {
        # Process successors
        return
            map { get_paths( $graph, $trie, $_, $data, %seen ) }
            @pot_successors;
    }

}


# Read in US state adjacency data from JSON file.
my %us_adj_data;
{
    open my $adj_data, "<", "$ENV{HOME}/Downloads/usa-state-data.json";

    # Set $/ to undef so we can slurp the data in the file. Then
    # use decode_json to save as a Perl hash. decode_json returns
    # a hashref and I wanted a hash, so use postfix deref.
    local $/;
    %us_adj_data = decode_json(<$adj_data>)->%*;
    close $adj_data;
}

# Build a graph we can traverse of the states, based on their adjacency.
# Only save states which share borders with another state (the 48
# continental states).
my $us_graph = Graph->new(
    vertices =>
        [ grep { $us_adj_data{$_}->{adjacent}->@* > 0 } keys %us_adj_data ],
    edges => [
        map {
            my $i = $_;
            map { [ $i, $_ ] } $us_adj_data{$_}->{adjacent}->@*
        } keys(%us_adj_data)
    ]
);

# Build a trie (prefix tree) of our dictionary that we can query
my $eng_words = Tree::Trie->new( deepsearch => "boolean" );

# From https://github.com/dwyl/english-words
# open my $wl, "<", "$ENV{HOME}/Downloads/words_alpha.txt";
open my $wl, "<", "/usr/share/dict/words";
while ( my $w = <$wl> ) {

    # Chomp and fold case. This may add words
    # with apostrophes and, in this case, we will
    # never match with those
    chomp $w;
    $eng_words->add( fc($w) );
}

# Use a hash to save data on the longest word(s) found.
my %longest_word = ( paths => [], words => [], length => 0 );

# Iterate over all states in the graph.
for my $state ( sort $us_graph->vertices ) {

    # Finds all paths with strings that may be in the dictionary and
    # save them into a hash.
    my %paths = get_paths( $us_graph, $eng_words, $state, \%us_adj_data );

    # Set the trie to do exact string search only
    $eng_words->deepsearch("exact");

    # Iterate over all the path->word elements in the %paths hash
    while ( my ( $path, $search ) = each %paths ) {

        # Drop current path from the hash
        delete $paths{$path};

        # Do an exact string search for the word
        my $match = $eng_words->lookup($search);
        if ( $match && $match eq $search ) {

            # A word was found in the dictionary and its longer
            # than the longest seen so far. Clear the longest_word
            # hash and save the new data.
            if ( length($search) > $longest_word{length} ) {
                @longest_word{qw(paths words length)}
                    = ( [$path], [$match], length($search) );
            }
            elsif ( length($search) == $longest_word{length} ) {

                # A word of the same length as the longest seen
                # was found. Push the data onto the list members
                # of the longest_word hash.
                push $longest_word{paths}->@*, $path;
                push $longest_word{words}->@*, $match;
            }

            # last;
        }
    }

    # Change search setting again so we can do prefix searches on the
    # next iteration again.
    $eng_words->deepsearch("boolean");
}

say "Longest word(s) constructed using initials of US states: ";
for my $i ( 0 .. ( $longest_word{words}->@* - 1 ) ) {
    say join( ", ", $longest_word{paths}->[$i] ) . " = "
        . join( ", ", $longest_word{words}->[$i] );
}
say "with a length of $longest_word{length} alphabetical characters";


#!/usr/bin/env perl6

=begin SYNOPSIS

Task:
    Create a script to implement full text search functionality using Inverted Index.

Notes:
    This script has a hardcoded list of documents. Run the script and pass a word as
    the only argument to see which documents contain that word. Results are ordered
    by the document with the most occurrences of the word.

Example Usage:
    $ perl6 ch-2.p6 minds
    Found 2 document(s) for 'minds'
    * "Pride and Prejudice": 1 occurence(s)
    * "War of the Worlds": 1 occurence(s)

    $ perl6 ch-2.p6 universe
    Found 0 document(s) for 'universe'

=end SYNOPSIS


sub MAIN( Str $keyword where *.chars > 0 ) {
    my %index = build_inverse_index( get_documents() );
    my @matches = %index{ $keyword.lc }:v.sort( { .<freq> } ).reverse;
    say "Found @matches.elems() document(s) for '$keyword.lc()'";
    say "* '$_.<doc>': $_.<freq> occurrence(s)" for @matches;
}


sub build_inverse_index( %documents ) {
    my %index;

    for %documents.kv -> $name, $text {
        my $bag = bag $text.lc.words;
        for $bag.kv -> $word, $freq {
            %index{ $word }.push: %( doc => $name, freq => $freq );
        }
    }

    return %index;
}


sub get_documents {
    return %(
        'Pride and Prejudice' => q:to/TXT/,
            It is a truth universally acknowledged, that
            a single man in possession of a good fortune
            must be in want of a wife. However little
            known the feelings or views of such a man may
            be on his first entering a neighbourhood,
            this truth is so well fixed in the minds of
            the surrounding families, that he is
            considered the rightful property of some one
            or other of their daughters.
            TXT
        'War of the Worlds' => q:to/TXT/,
            No one would have believed, in the last years
            of the nineteenth century, that human affairs
            were being watched from the timeless worlds
            of space. No one could have dreamed that we
            were being scrutinised as someone with a
            microscope studies creatures that swarm and
            multiply in a drop of water. And yet, across
            the gulf of space, minds immeasurably
            superior to ours regarded this Earth with
            envious eyes, and slowly, and surely, they
            drew their plans against us...
            TXT
        'Richard III' => q:to/TXT/,
            Now is the winter of our discontent made
            glorious summer by this sun of York; and
            all the clouds that lour'd upon our
            house in the deep bosom of the ocean
            buried. Now are our brows bound with
            victorious wreaths; our bruised arms
            hung up for monuments; our stern
            alarums changed to merry meetings, our
            dreadful marches to delightful
            measures.
            TXT
        "Hitchhiker's Guide to the Galaxy" => q:to/TXT/,
            Far back in the mists of ancient
            time, in the great and glorious days
            of the former Galactic Empire, life
            was wild, rich and largely tax free.
            TXT
    );
}

#!/usr/bin/env perl

=head2 SYNOPSIS

Task:
    Create a script to implement full text search functionality using Inverted Index.

Notes:
    This script has a hardcoded list of documents. Run the script and pass a word as
    the only argument to see which documents contain that word.

Example Usage:
    $ perl ch-2.pl minds
	Found 2 document(s) for 'minds'
	* "Pride and Prejudice": 1 occurence(s)
	* "War of the Worlds": 1 occurence(s)

    $ perl ch-2.pl universe
    Found 0 document(s) for 'universe'

=cut

use v5.26;
use strict;
use warnings;

use List::MoreUtils qw( frequency );

my %index = build_inverse_index( get_documents() );
my $keyword = lc $ARGV[0] // '';
die "Must provide a keyword as an argument\n" unless length($keyword);

my @matches = sort { $b->{freq} <=> $a->{freq} || $a->{doc} cmp $b->{doc} } $index{ $keyword }->@*;
say "Found " . scalar(@matches) . " document(s) for '$keyword'";
if ( @matches ) {
    say qq[* "$_->{doc}": $_->{freq} occurence(s)] for @matches;
}

exit 0;


sub build_inverse_index {
    my %documents = @_;

    my %index;

    while ( my ($name, $text) = each %documents ) {
        my @words = map { lc $_ } $text =~ /\w+/g;
        my %freq = frequency @words;
        foreach my $word ( keys %freq ) {
            push $index{ $word }->@*, { doc => $name, freq => $freq{$word} };
        }
    }

    return %index;
}


sub get_documents {
    return (
        'Pride and Prejudice' => <<~'TXT',
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
        'War of the Worlds' => <<~'TXT',
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
        'Richard III' => <<~'TXT',
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
#'(Unconfuse VIM syntax highlighting)
        "Hitchhiker's Guide to the Galaxy" => <<~'TXT',
            Far back in the mists of ancient
            time, in the great and glorious days
            of the former Galactic Empire, life
            was wild, rich and largely tax free.
            TXT
    );
}




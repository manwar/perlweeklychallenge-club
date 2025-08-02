use warnings;
use strict;

use v5.38;

use List::Util qw(max);

my @inputs = (
    "and2 Raku3 cousins5 Perl1 are4",
    "guest6 Python1 most4 the3 popular5 is2 language7",
    "Challenge3 The1 Weekly2",
    "abc1 abc 23 a1s2d3f4"
    );
for (@inputs) {
    say $_ . " => " . unshuffle_string( $_ );
}

sub unshuffle_string( $s ) {
    my %words;
    for (split ' ', $s) {
	my ($word, $idx) = /(\w+?)(\d+$)/;
	# if the regex pattern matched
	if ( $word ) {
	    $words{ $idx } = $word;
	}
    }

    my @sorted_words = ();
    for (1..max( keys %words )) {
	my $word = exists($words{ $_ }) ? $words{ $_ } : 'REDACTED';
	push @sorted_words, $word;
    }
    return join ' ', @sorted_words;
}

# julia racket

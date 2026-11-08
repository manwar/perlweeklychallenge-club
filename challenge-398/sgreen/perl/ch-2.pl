#!/usr/bin/env perl

use strict;
use warnings;
use utf8::all;
use feature "say";
use experimental "signatures";

use List::Util 'any';

sub main (@words) {
    my %word_difference = ();
    # Check words are of the same length
    if ( any { length($_) != length( $words[0] ) } @words ) {
        die "Words must be of the same length\n";
    }

    foreach my $word (@words) {
        # Check words only contain lower case letters
        if ( $word !~ /^[a-z]+$/ ) {
            die "The word $word is not all lower case English letters\n";
        }

        # Create a tuple of the difference between letters
        my @differences = map {
            ord( substr( $word, $_, 1 ) ) - ord( substr( $word, $_ - 1, 1 ) )
        } ( 1 .. length($word) - 1 );
        push @{ $word_difference{ join( " ", @differences ) } }, $word;
    }

    # Find words with unique differences
    my @unique_words =
      map { $_->[0] } grep { scalar(@$_) == 1 } values(%word_difference);
    if ( scalar(@unique_words) == 1 ) {
        say $unique_words[0];
    }
    else {
        say "There were ", scalar(@unique_words),
          " words with unique differences";
    }
}

main(@ARGV);

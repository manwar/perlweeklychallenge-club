#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util 'mesh';

sub main (@s) {
    # Create letter to number mapping
    my %letter_map = mesh [ 'a' .. 'z' ], [ 0 .. 25 ];

    my %occurrences = ();
    foreach my $word (@s) {
        # Calculate the differences between characters, and store this
        #  as a space separated string
        my $diff = join(
            ' ',
            map {
                $letter_map{ substr( $word, $_, 1 ) } -
                  $letter_map{ substr( $word, $_ - 1, 1 ) }
            } ( 1 .. length($word) - 1 )
        );

        # Add the word to the occurrences hash
        push @{ $occurrences{$diff} }, $word;
    }

    # Find the unique words
    my @unique_words =
      ( map { $_->[0] } grep { $#$_ == 0 } values(%occurrences) );

    if ( $#unique_words > 0 ) {
        say 'More than one unique string!';
    }
    elsif ( $#unique_words == -1 ) {
        say 'No unique strings!';
    }
    else {
        say $unique_words[0];
    }
}

main(@ARGV);
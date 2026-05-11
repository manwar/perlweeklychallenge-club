#!/usr/bin/env perl

use strict;
use warnings;
use utf8::all;
use feature "say";
use experimental "signatures";

sub main ($input_string) {
    my @words  = grep { $_ ne "" } split /\s+/, $input_string;
    my $spaces = ( $input_string =~ tr/ / / );

    # To avoid a division by zero error, handle the single word case
    if ( $#words == 0 ) {
        say '"' . $words[0] . " " x $spaces . '"';
    }
    else {
        # Calculate how many spaces are required and return the string
        my $spaces_between_words = int( $spaces / $#words );
        my $spaces_at_end        = $spaces % $#words;
        say '"'
          . join( " " x $spaces_between_words, @words )
          . " " x $spaces_at_end . '"';
    }
}

main(@ARGV);

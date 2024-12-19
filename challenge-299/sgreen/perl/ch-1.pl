#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main (@words) {
    # Last value is the sentence
    my $sentence = pop(@words);

    my $regexp =
        "(?<![a-z])("
      . join( '|', map { quotemeta } @words )
      . ")([a-z]*(?:'[a-z]+)?)";
    $sentence =~ s/$regexp/$1/g;
    say $sentence;
}

main(@ARGV);